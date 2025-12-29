import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:notes/widgets/pomodoro/circle.dart';

class PlayButton extends StatefulWidget
 {
  double totalTime;
  double size;
  Function? onUpdate;
  PlayButton({super.key, required this.totalTime, required this.size, this.onUpdate});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> 
{
  bool off = false;
  double button_size = 200;

    late double totalTime;
  late double size;
  Function? onUpdate;
  double _secondsRemaining = 0;

  Timer? _timer;

  @override
  void initState() 
  {
    super.initState();
    totalTime = widget.totalTime;
    size = widget.size;
    onUpdate = widget.onUpdate;
  }

  void startTimer()
  {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer)
    {
      setState(() {
        if (_secondsRemaining < 1) 
        {
            timer.cancel();
          } 
          else 
          {
            _secondsRemaining--;
          }
      });
    });
  }

  


  @override
  Widget build(BuildContext context) 
  {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border.all(width: 4), borderRadius: BorderRadius.circular(button_size)),
      child: GestureDetector(
        onTap: () => setState(() {off = !off;}),
        child: Container(
          height: button_size,
          width: button_size,
          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(button_size)),
          child: Icon(off ? Icons.pause_circle_filled_rounded: Icons.play_arrow_rounded, size: 88,),
        ),
      ),
    );
  }
}