import 'dart:convert';

class PomodoroSettings {
  final int id;
  final int workDuration;
  final int shortBreak;
  final int longBreak;
  final int sessionsUntilLongBreak;

  static String tableName = 'POMODORO_SETTINGS';
  static String primaryKey = 'ID';

  PomodoroSettings({
    this.id = 1,
    this.workDuration = 25,
    this.shortBreak = 5,
    this.longBreak = 15,
    this.sessionsUntilLongBreak = 4,
  });

  // Convert from JSON/Map (from database)
  factory PomodoroSettings.fromJson(Map<String, dynamic> json) {
    return PomodoroSettings(
      id: json['ID'] ?? 1,
      workDuration: json['WORK_DURATION'] ?? 25,
      shortBreak: json['SHORT_BREAK'] ?? 5,
      longBreak: json['LONG_BREAK'] ?? 15,
      sessionsUntilLongBreak: json['SESSIONS_UNTIL_LONG_BREAK'] ?? 4,
    );
  }

  // Convert to JSON/Map (for database)
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'WORK_DURATION': workDuration,
      'SHORT_BREAK': shortBreak,
      'LONG_BREAK': longBreak,
      'SESSIONS_UNTIL_LONG_BREAK': sessionsUntilLongBreak,
    };
  }

  // Create a copy with modified values
  PomodoroSettings copyWith({
    int? id,
    int? workDuration,
    int? shortBreak,
    int? longBreak,
    int? sessionsUntilLongBreak,
  }) {
    return PomodoroSettings(
      id: id ?? this.id,
      workDuration: workDuration ?? this.workDuration,
      shortBreak: shortBreak ?? this.shortBreak,
      longBreak: longBreak ?? this.longBreak,
      sessionsUntilLongBreak: sessionsUntilLongBreak ?? this.sessionsUntilLongBreak,
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}