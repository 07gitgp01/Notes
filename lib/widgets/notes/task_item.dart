import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/data/models/notes/task.dart';

Widget TaskItem({required BuildContext context, required Task task}) {
  var screenWidth = MediaQuery.of(context).size.width;
  return Container(
    width: screenWidth > 700 ? 320 : (screenWidth - 36) / 2,
    height: 200,
    decoration: BoxDecoration(
      border: Border.all(width: .5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 3,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(task.description)),
          Row(
            spacing: 6,
            children: [
              Icon(Icons.calendar_today_rounded),
              Text(DateFormat("yy-M-d").format(task.due_date)),
            ],
          ),
          Row(
            spacing: 6,
            children: [
              Icon(Icons.access_time),
              Text(DateFormat("hh:mm").format(task.due_date)),
            ],
          ),
        ],
      ),
    ),
  );
}
