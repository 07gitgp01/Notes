import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

String secondsToTime(int seconds)
{
  int _minutes = 0;
  int _seconds = 0;

  _minutes = seconds ~/ 60;
  _seconds = seconds % 60;

  return '$_minutes:$_seconds';
}
