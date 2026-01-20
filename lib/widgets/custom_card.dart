import 'package:flutter/material.dart';
import 'package:notes/consts/colors.dart';

Widget CustomCard({double radius = 6, required Widget child})
{
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: AppColors.card),
    child: child,
  );
}