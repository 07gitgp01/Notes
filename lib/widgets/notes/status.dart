import 'dart:ffi';

import 'package:flutter/material.dart';

Widget StatusWidget({
  required String text,
  required bool active,
  Color? statusColor,
  Function? onClick,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: statusColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
  );
}
