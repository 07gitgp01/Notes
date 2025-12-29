import 'package:flutter/material.dart';
import 'package:notes/utils/functions.dart';
import 'package:notes/widgets/pomodoro/circle.dart';
import 'package:notes/widgets/pomodoro/play_button.dart';
import 'package:notes/widgets/pomodoro/timer.dart';

class Pomodoro extends StatefulWidget 
{
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> 
{
  var consumedTime = 0.0;
  var time = 5.0;
  Key key = UniqueKey();
  @override
  Widget build(BuildContext context) 
  {
    var screen_size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screen_size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentGeometry.topRight,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.settings))
                    ),
                  SizedBox(height: screen_size.height  * .20),  
                  Center(child: TimerWidget(totalTime: time, size: 200, onUpdate: (value)
                  {
                    setState(() 
                    {
                      consumedTime = value;
                      key = UniqueKey();
                    });
                  },
                  )),
                  SizedBox(height: 12,),
                  Text(key: key, secondsToTime((time - consumedTime).toInt()), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 36,),
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: GestureDetector(onTap: (){}, child: Text('RESET',  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}