import 'package:notes/data/database_provider.dart';
import 'package:notes/data/models/pomodoro/pomodoro_settings.dart';

class PomodoroSettingsController {
  
  /// Get Pomodoro settings (should only have one record with id = 1)
  static Future<PomodoroSettings?> getSettings() async {
    var data = await DatabaseProvider.queryById(
      PomodoroSettings.tableName,
      1,
      PomodoroSettings.primaryKey,
    );
    return data == null ? null : PomodoroSettings.fromJson(data);
  }

  /// Create initial Pomodoro settings
  static Future<PomodoroSettings?> createSettings(PomodoroSettings settings) async {
    var settingsId = await DatabaseProvider.insert(
      PomodoroSettings.tableName,
      settings.toJson(),
    );
    if (settingsId == 0) {
      return null;
    } else {
      return PomodoroSettings.fromJson({
        ...settings.toJson(),
        PomodoroSettings.primaryKey: settingsId,
      });
    }
  }

  /// Update Pomodoro settings
  static Future<PomodoroSettings?> updateSettings(PomodoroSettings settings) async {
    var result = await DatabaseProvider.update(
      PomodoroSettings.tableName,
      settings.toJson(),
      settings.id,
      PomodoroSettings.primaryKey,
    );
    if (result == 0) {
      return null;
    } else {
      return settings;
    }
  }

  /// Get settings or create default if they don't exist
  static Future<PomodoroSettings> getOrCreateSettings() async {
    var settings = await getSettings();
    if (settings == null) {
      settings = await createSettings(PomodoroSettings());
    }
    return settings ?? PomodoroSettings();
  }
}