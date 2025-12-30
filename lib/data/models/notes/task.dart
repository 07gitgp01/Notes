import 'dart:convert';

class Task {
  int? id;
  String title;
  DateTime due_date;

  Task({required this.title, required this.due_date, this.id});

  factory Task.fromJSON(Map<String, dynamic> json) {
    return Task(
      id: json["ID"],
      title: json["TITLE"],
      due_date: json["DUE_DATE"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {"ID": id, "TITLE": title, "DUE_DATE": due_date};
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
