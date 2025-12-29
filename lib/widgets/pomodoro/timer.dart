import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/widgets/pomodoro/circle.dart';
import 'package:vibration/vibration.dart';

class TimerWidget extends StatefulWidget {
  double totalTime;
  double size;
  Function(double)? onUpdate;
  
  TimerWidget({
    super.key, 
    required this.totalTime, 
    required this.size, 
    this.onUpdate
  });
  
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> 
{
  late double totalTime;
  late double size;
  Function? onUpdate;
  double _secondsRemaining = 0;
  bool isPaused = true;
  double button_size = 250;
  double button_zone = 100;
  Timer? _timer;
  Key key = UniqueKey();
  
  @override
  void initState() {
    super.initState();
    totalTime = widget.totalTime;
    size = widget.size;
    onUpdate = widget.onUpdate;
    _secondsRemaining = totalTime;
  }
  
  
  void startTimer() 
  {
    if (_timer != null) return;
    
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) 
    {
      if (!isPaused) 
      {
        setState(() 
        {
          if (_secondsRemaining < 1) 
          {
            timer.cancel();
            _timer = null;
            isPaused = !isPaused;
            _secondsRemaining = totalTime;
            HapticFeedback.vibrate();
          } 
          else
          {
            _secondsRemaining--;
          }
          key = UniqueKey();
          if (onUpdate != null) 
          {
            onUpdate?.call(totalTime - _secondsRemaining);
          }
        });
      }
    });
  }
  
  void toggleTimer() 
  {
    setState(() 
    {
      isPaused = !isPaused;
      if (!isPaused && _timer == null) 
      {
        startTimer();
      }
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) 
  {
    double ratio = _secondsRemaining / totalTime;
    
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 6), 
        borderRadius: BorderRadius.circular(button_size)
      ),
      child: GestureDetector(
        onTap: toggleTimer,
        child: Container(
          height: button_size,
          width: button_size,
          decoration: BoxDecoration(
            border: Border.all(width: 2), 
            borderRadius: BorderRadius.circular(button_size)
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                key: key,
                size: Size(button_size, button_size),
                painter: CirclePainter(
                  paintColor: Colors.amber, 
                  ratio: ratio
                ),
              ),
              Container(
                height: button_zone,
                width: button_zone,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(button_zone)
                ),
                child: Center(
                  child: Icon(
                    isPaused 
                      ? Icons.play_arrow_rounded 
                      : Icons.pause_circle_filled_rounded, 
                    size: button_zone - 25,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}