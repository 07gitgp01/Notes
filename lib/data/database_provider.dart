import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

class DatabaseProvider
{
  static late Database db;

  /// Initialize database with SQL script
  /// @param database_fullpath: Full path to database file
  /// @param tables_creation_query: SQL script content (from assets or string)
  static Future<void> init(String database_fullpath, String tables_creation_query) async
  {
    // Initialize FFI for desktop platforms (Windows, macOS, Linux)
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
    {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    print('Initializing database at: $database_fullpath');

    db = await openDatabase(
      database_fullpath,
      version: 1,
      onCreate: (Database database, int version) async {
        print('Creating database schema...');

        // Execute the SQL script
        await _executeSqlScript(database, tables_creation_query);

        print('Database schema created successfully');
      },
      onOpen: (Database database) async {
        // Enable foreign key constraints
        await database.execute('PRAGMA foreign_keys = ON');
        print('Database opened - Foreign keys enabled');
      },
    );

    print('Database initialized successfully');
  }

  /// Execute SQL script (handles multiple statements including triggers)
  static Future<void> _executeSqlScript(Database database, String sqlScript) async {
    // Split script into individual statements (handles triggers with BEGIN/END)
    final statements = _parseSqlScript(sqlScript);

    print('Executing ${statements.length} SQL statements...');

    int successCount = 0;
    int skipCount = 0;

    for (int i = 0; i < statements.length; i++) {
      final statement = statements[i];

      if (statement.isEmpty) {
        skipCount++;
        continue;
      }

      try {
        // Use execute for DDL (CREATE, DROP, ALTER) and DML (INSERT, UPDATE, DELETE)
        await database.execute(statement);
        successCount++;

        // Log progress every 10 statements
        if ((successCount) % 10 == 0)
        {
          print(' Progress: $successCount/${statements.length} statements executed');
        }
      } catch (e) {
        // Log error but continue with other statements
        print('   Warning: Failed to execute statement ${i + 1}');
        print('   Error: $e');
        print('   Statement preview: ${_previewStatement(statement)}');
      }
    }

    if (skipCount > 0)
    {
      print('Skipped $skipCount empty statements');
    }
  }

  /// Parse SQL script into individual statements
  /// Handles triggers with BEGIN...END blocks correctly
  static List<String> _parseSqlScript(String sqlScript)
  {
    // Remove single-line comments
    final lines = sqlScript.split('\n');
    final cleanedLines = <String>[];

    for (var line in lines)
    {
      // Remove comments (but preserve -- within strings)
      final commentIndex = line.indexOf('--');
      if (commentIndex >= 0 && !_isInsideString(line, commentIndex))
      {
        line = line.substring(0, commentIndex);
      }

      cleanedLines.add(line);
    }

    final cleanedScript = cleanedLines.join('\n');

    // Parse statements considering BEGIN...END blocks
    final statements = <String>[];
    final buffer = StringBuffer();
    int beginEndDepth = 0;

    // Split by semicolons but respect BEGIN...END blocks
    for (int i = 0; i < cleanedScript.length; i++)
    {
      final char = cleanedScript[i];
      buffer.write(char);

      // Check for BEGIN keyword
      if (i >= 4) {
        final lastFive = cleanedScript.substring(i - 4, i + 1).toUpperCase();
        if (lastFive == 'BEGIN' && _isWordBoundary(cleanedScript, i - 4, i + 1)) {
          beginEndDepth++;
        }
      }

      // Check for END keyword
      if (i >= 2) {
        final lastThree = cleanedScript.substring(i - 2, i + 1).toUpperCase();
        if (lastThree == 'END' && _isWordBoundary(cleanedScript, i - 2, i + 1)) {
          beginEndDepth--;
        }
      }

      // Split on semicolon only if not inside BEGIN...END
      if (char == ';' && beginEndDepth == 0) {
        final statement = buffer.toString().trim();
        if (statement.isNotEmpty) {
          statements.add(statement);
        }
        buffer.clear();
      }
    }

    // Add remaining buffer if not empty
    final remaining = buffer.toString().trim();
    if (remaining.isNotEmpty && remaining != ';') {
      statements.add(remaining);
    }

    return statements;
  }

  /// Check if position is inside a string literal
  static bool _isInsideString(String text, int position)
  {
    int singleQuotes = 0;
    int doubleQuotes = 0;

    for (int i = 0; i < position; i++) {
      if (text[i] == "'" && (i == 0 || text[i - 1] != '\\')) {
        singleQuotes++;
      } else if (text[i] == '"' && (i == 0 || text[i - 1] != '\\')) {
        doubleQuotes++;
      }
    }

    return (singleQuotes % 2 != 0) || (doubleQuotes % 2 != 0);
  }

  /// Check if word at position has word boundaries
  static bool _isWordBoundary(String text, int start, int end)
  {
    // Check character before start
    if (start > 0) {
      final before = text[start - 1];
      if (RegExp(r'[a-zA-Z0-9_]').hasMatch(before)) {
        return false;
      }
    }

    // Check character after end
    if (end < text.length) {
      final after = text[end];
      if (RegExp(r'[a-zA-Z0-9_]').hasMatch(after)) {
        return false;
      }
    }

    return true;
  }

  /// Get a preview of a statement (first 100 characters)
  static String _previewStatement(String statement)
  {
    if (statement.length <= 100)
    {
      return statement;
    }
    return '${statement.substring(0, 100)}...';
  }

  // Create table method (for individual table creation)
  static Future<void> createTable(Database database, String query) async
  {
    await database.execute(query);
  }

  // Insert
  static Future<int> insert(String table, Map<String, dynamic> data) async {
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update
  static Future<int> update(
      String table,
      Map<String, dynamic> data,
      int id,
      String primaryKey,
      ) async
  {
    return await db.update(
      table,
      data,
      where: '$primaryKey = ?',
      whereArgs: [id],
    );
  }

  // Delete
  static Future<int> delete(String table, int id, String primaryKey) async
  {
    return await db.delete(
      table,
      where: '$primaryKey = ?',
      whereArgs: [id],
    );
  }

  // Query all records
  static Future<List<Map<String, dynamic>>> queryAll(String table) async
  {
    return await db.query(table);
  }

  // Query by ID
  static Future<Map<String, dynamic>?> queryById(
      String table,
      int id,
      String primaryKey,
      ) async
  {
    List<Map<String, dynamic>> results = await db.query(
      table,
      where: '$primaryKey = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  // Query with custom where clause
  static Future<List<Map<String, dynamic>>> queryWhere(
      String table,
      String where,
      List<dynamic> whereArgs,
      ) async
  {
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // Execute raw query
  static Future<List<Map<String, dynamic>>> rawQuery(
      String sql, [
        List<dynamic>? arguments,
      ]) async {
    return await db.rawQuery(sql, arguments);
  }

  // Execute raw statement
  static Future<int> rawExecute(String sql, [List<dynamic>? arguments]) async
  {
    return await db.rawUpdate(sql, arguments);
  }

  // Get all table names
  static Future<List<String>> getTables() async
  {
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
    );
    return result.map((row) => row['name'] as String).toList();
  }

  // Get table info (columns, types, etc.)
  static Future<List<Map<String, dynamic>>> getTableInfo(String tableName) async
  {
    return await db.rawQuery('PRAGMA table_info($tableName)');
  }

  // Check if table exists
  static Future<bool> tableExists(String tableName) async
  {
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );
    return result.isNotEmpty;
  }

  // Get record count for a table
  static Future<int> getRecordCount(String tableName) async
  {
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');
    return result.first['count'] as int;
  }

  // Close database
  static Future<void> close() async
  {
    await db.close();
  }

  // Delete database file
  static Future<void> deleteDatabase(String path) async
  {
    await databaseFactory.deleteDatabase(path);
  }
}