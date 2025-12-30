import 'package:flutter/material.dart';
import 'package:notes/consts/colors.dart';
import 'package:notes/data/models/notes/project.dart';

class ProjectItem extends StatelessWidget {
  Project project;
  ProjectItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  spacing: 12,
                  children: [
                    Icon(Icons.task, size: 30, color: AppColors.disabled),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            maxLines: 1,
                            project.description,
                            style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
      ),
    );
  }
}
