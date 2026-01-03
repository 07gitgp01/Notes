import 'package:flutter/material.dart';
import 'package:notes/consts/colors.dart';
import 'package:notes/widgets/notes/status.dart';

class AllProjects extends StatefulWidget {
  const AllProjects({super.key});

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Project(n)",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.search, color: Colors.black),
          ],
        ),

        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          Row(
            children: [
              StatusWidget(
                text: "Completed",
                active: true,
                statusColor: Colors.green,
              ),
              SizedBox(width: 10),
              StatusWidget(
                text: "Completed",
                active: true,
                statusColor: Colors.yellow,
              ),
              SizedBox(width: 10),
              StatusWidget(
                text: "Completed",
                active: true,
                statusColor: Colors.red,
              ),
            ],
          ),
          Column(),
        ],
      ),
    );
  }
}
