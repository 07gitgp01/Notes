import 'package:flutter/material.dart';
import 'package:notes/consts/colors.dart';
import 'package:notes/data/models/notes/task.dart';
import 'package:notes/widgets/notes/status.dart';
import 'package:notes/widgets/notes/task_item.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  Task task = Task(
    title: "Manger",
    description: "Juste manger les couille du mouton",
    due_date: DateTime.now(),
  );
  bool isFocusedOnCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tasks"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            child: Icon(Icons.search, color: Colors.black),
            onTap: () {
              print("hello");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 12,
          children: [
            Container(
              padding: EdgeInsets.all(6),
              child: Row(
                spacing: 6,
                children: [
                  StatusWidget(
                    text: "On Going",
                    active: !isFocusedOnCompleted,
                    onClick: onStatusFiltered,
                  ),
                  StatusWidget(
                    text: "Completed",
                    active: isFocusedOnCompleted,
                    onClick: onStatusFiltered,
                  ),
                ],
              ),
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(
                    12,
                    (index) => TaskItem(context: context, task: task),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  void onStatusFiltered() {
    setState(() {
      isFocusedOnCompleted = !isFocusedOnCompleted;
    });
  }
}
