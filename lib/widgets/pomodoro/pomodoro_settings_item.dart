
import 'package:flutter/material.dart';
import 'package:notes/widgets/pomodoro/transparent_pop_up.dart';

class PomodoroSettingsItem extends StatefulWidget 
{
  int initialValue;
  Function(int)? onConfirm;
  String label;
  PomodoroSettingsItem({super.key, required this.initialValue, required this.label, this.onConfirm});

  @override
  State<PomodoroSettingsItem> createState() => _PomodoroSettingsItemState();
}

class _PomodoroSettingsItemState extends State<PomodoroSettingsItem> 
{
  late int initialValue;
  late Function(int)? onConfirm;
  late String label;

  @override
  void initState() 
  {
    super.initState();
    initialValue = widget.initialValue;
    onConfirm = widget.onConfirm;
    label = widget.label;
  }

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Text(label),
          TextButton(onPressed: ()
          {
            TransparentPopUp(context: context, initialValue: initialValue, onConfirm: (value) 
              {
                setState(() {
                  initialValue = value;
                  onConfirm?.call(initialValue);
                });
              },
            );}, child: Text(initialValue.toString())),
        ],
      ),
    );
  }
}