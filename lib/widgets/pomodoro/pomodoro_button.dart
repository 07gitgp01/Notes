import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/widgets/pomodoro/circle.dart';
import 'package:vibration/vibration.dart';

class PomodoroButton extends StatefulWidget {
  final double totalTime;
  final double size;
  final Function(double)? onUpdate;
  
  const PomodoroButton({
    super.key, 
    required this.totalTime, 
    required this.size, 
    this.onUpdate
  });
  
  @override
  State<PomodoroButton> createState() => _PomodoroButtonState();
}

class _PomodoroButtonState extends State<PomodoroButton> 
{
  late double _secondsRemaining;
  late double _totalTime;
  bool _isPaused = true;
  late double _buttonSize;
  final double _buttonZone = 100;
  Timer? _timer;
  Key _circleKey = UniqueKey();
  
  @override
  void initState() 
  {
    super.initState();
    _totalTime = widget.totalTime;
    _buttonSize = widget.size;
    _secondsRemaining = _totalTime;
  }
  
  @override
  void didUpdateWidget(PomodoroButton oldWidget) 
  {
    super.didUpdateWidget(oldWidget);
    if (widget.totalTime != oldWidget.totalTime) 
    {
      _totalTime = widget.totalTime;
      _secondsRemaining = _totalTime;
      _circleKey = UniqueKey();
    }
    if (widget.size != oldWidget.size) 
    {
      _buttonSize = widget.size;
    }
  }
  
  void _startTimer() 
  {
    if (_timer != null && _timer!.isActive) return;
    
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
  }
  
  Future<void> _timerCallback(Timer timer) async 
  {
    if (_isPaused) return;
    
    if (_secondsRemaining <= 1) 
    {
      _handleTimerCompletion();
      return;
    }
    
    setState(() 
    {
      _secondsRemaining--;
      _circleKey = UniqueKey();
    });
    
    if (widget.onUpdate != null) 
    {
      widget.onUpdate!(_totalTime - _secondsRemaining);
    }
  }
  
  Future<void> _handleTimerCompletion() async 
  {
    _timer?.cancel();
    _timer = null;
    
    setState(() {
      _isPaused = true;
      _secondsRemaining = _totalTime;
      _circleKey = UniqueKey();
    });
    
    
    
    // Trigger vibration if available
    try 
    {
      if (await Vibration.hasVibrator() ?? false) 
      {
        await Vibration.vibrate();
      }
    }
    catch (e) 
    {
      // Handle vibration error silently
      debugPrint('Vibration error: $e');

      // Trigger haptic feedback
      HapticFeedback.vibrate();
    }
    
    if (widget.onUpdate != null) {
      widget.onUpdate!(_totalTime);
    }
  }
  
  void _toggleTimer() {
    setState(() {
      _isPaused = !_isPaused;
    });
    
    if (!_isPaused && (_timer == null || !_timer!.isActive)) {
      _startTimer();
    }
  }
  
  void _resetTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _isPaused = true;
      _secondsRemaining = _totalTime;
      _circleKey = UniqueKey();
    });
    
    if (widget.onUpdate != null) {
      widget.onUpdate!(0);
    }
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double ratio = _secondsRemaining / _totalTime;
    
    return GestureDetector(
      onLongPress: _resetTimer,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(width: 6), 
          borderRadius: BorderRadius.circular(_buttonSize)
        ),
        child: GestureDetector(
          onTap: _toggleTimer,
          child: Container(
            height: _buttonSize,
            width: _buttonSize,
            decoration: BoxDecoration(
              border: Border.all(width: 2), 
              borderRadius: BorderRadius.circular(_buttonSize)
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  key: _circleKey,
                  size: Size(_buttonSize, _buttonSize),
                  painter: CirclePainter(
                    paintColor: Colors.amber, 
                    ratio: ratio
                  ),
                ),
                Container(
                  height: _buttonZone,
                  width: _buttonZone,
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(_buttonZone)
                  ),
                  child: Center(
                    child: Icon(
                      _isPaused 
                        ? Icons.play_arrow_rounded 
                        : Icons.pause_circle_filled_rounded, 
                      size: _buttonZone - 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}