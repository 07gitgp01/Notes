import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notes/consts/colors.dart';

Widget StatusWidget({
  required String text,
  required bool active,
  Function? onClick,
}) {
  return Expanded(
    child: InkWell(
      onTap: () => onClick?.call(),
      child: Container(
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: active ? Colors.white : null,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.disabled,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
  );
}
