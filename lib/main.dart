import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/consts/colors.dart';
import 'package:notes/consts/page_names.dart';
import 'package:notes/consts/specs.dart';
import 'package:notes/data/database_provider.dart';
import 'package:notes/pages/main.dart';
import 'package:notes/pages/pomodoro.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as PathProvider;

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  try
  {

    // Get database path
    final dbPath = await PathProvider.getApplicationDocumentsDirectory();
    final dbFullPath = path.join(dbPath.path, DB_NAME);
    final dbFile = File(dbFullPath);

    // Check if database already exists
    final dbExists = await dbFile.exists();

    if (dbExists) {
      print('Database already exists at: $dbFullPath');
    } else {
      print('Database will be created at: $dbFullPath');
    }

    // Load SQL script from assets
    print('Loading SQL schema from assets...');
    final sqlScript = await rootBundle.loadString('assets/sql/database.sql');
    print('SQL script loaded (${sqlScript.length} characters)\n');

    // Initialize database with SQL script
    await DatabaseProvider.init(dbFullPath, sqlScript);

    // Optional: Print database info for debugging
    await _printDatabaseInfo();

  }
  catch (e, stackTrace)
  {
    print('\nERROR: Failed to initialize database');
    print('Error: $e');
    print('Stack trace: $stackTrace\n');

    // You might want to show an error dialog to the user
    // or use a fallback database initialization
  }

  runApp(const MyApp());
}

/// Print database information (for debugging)
Future<void> _printDatabaseInfo() async
{
  try
  {
    print('═══════════════════════════════════════');
    print('DATABASE INFORMATION');
    print('═══════════════════════════════════════');

    // Get all tables
    final tables = await DatabaseProvider.getTables();
    print('Tables (${tables.length}):');
    for (var table in tables)
    {
      final count = await DatabaseProvider.getRecordCount(table);
      print('   - $table ($count records)');
    }

    print('═══════════════════════════════════════\n');
  }
  catch (e)
  {
    print('Could not retrieve database info: $e\n');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GENERATEUR DE RECU - SUR-TECH",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          // Primary colors
          primary: AppColors.primary,
          primaryContainer: AppColors.primaryDark,
          onPrimary: AppColors.textOnPrimary,

          // Secondary colors
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.accent,
          onSecondary: AppColors.textOnSecondary,

          // Background colors
          background: AppColors.background,
          surface: AppColors.surface,
          onBackground: AppColors.textPrimary,
          onSurface: AppColors.textPrimary,

          // Error colors
          error: AppColors.error,
          onError: AppColors.textOnPrimary,

          // Other theme colors
          brightness: Brightness.light,
          surfaceVariant: AppColors.card,
          outline: AppColors.border,
          outlineVariant: AppColors.divider,
          shadow: AppColors.shadow,
          scrim: AppColors.shadow,
          inverseSurface: AppColors.textPrimary,
          onInverseSurface: AppColors.surface,
          tertiary: AppColors.success,
          tertiaryContainer: AppColors.warning,
          onTertiary: AppColors.textOnPrimary,
          onTertiaryContainer: AppColors.textPrimary,
        ),

        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.error),
          ),
          labelStyle: TextStyle(color: AppColors.textSecondary),
          hintStyle: TextStyle(color: AppColors.textHint),
          errorStyle: TextStyle(
            color: AppColors.error,
            fontSize: 12.0,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        useMaterial3: true,
      ),
      home: const Pomodoro(),
      routes: {
        MAIN: (context) => const Main(),
        POMODORO: (context) => const Pomodoro(),
      },
    );
  }
}