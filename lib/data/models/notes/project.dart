import 'dart:convert';
import 'task.dart'; // Importer votre classe Task

class Project {
  int? id;
  String title;
  String description;
  List<Task> tasks;

  Project({
    required this.title,
    required this.description,
    required this.tasks,
    this.id,
  });

  factory Project.fromJSON(Map<String, dynamic> json) {
    return Project(
      id: json["ID"],
      title: json["TITLE"],
      description: json["DESCRIPTION"],
      tasks:
          (json["TASKS"] as List<dynamic>?)
              ?.map((taskJson) => Task.fromJSON(taskJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "ID": id,
      "TITLE": title,
      "DESCRIPTION": description,
      "TASKS": tasks.map((task) => task.toJSON()).toList(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
