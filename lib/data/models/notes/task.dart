import 'dart:convert';

class Task {
  int? id;
  String title;
  String description;
  DateTime due_date;
  TaskStatus status;

  Task({
    required this.title,
    required this.description,
    required this.due_date,
    this.id,
    this.status = TaskStatus.ONGOING,
  });

  factory Task.fromJSON(Map<String, dynamic> json) {
    return Task(
      id: json["ID"],
      title: json["TITLE"],
      description: json["DESCRIPTION"],
      due_date: json["DUE_DATE"],
      status: json["STATUS"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "ID": id,
      "TITLE": title,
      "DESCRIPTION": description,
      "DUE_DATE": due_date,
      "STATUS": status,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}

enum TaskStatus { ONGOING, COMPLETED }
