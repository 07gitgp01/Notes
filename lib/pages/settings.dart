import 'package:flutter/material.dart';
import 'package:notes/data/controller/pomodoro_controller.dart';
import 'package:notes/data/database_provider.dart';
import 'package:notes/data/models/pomodoro/pomodoro_settings.dart';
import 'package:notes/widgets/custom_card.dart';
import 'package:notes/widgets/pomodoro/pomodoro_settings_item.dart';
import 'package:notes/widgets/pomodoro/transparent_pop_up.dart';

class Settings extends StatefulWidget 
{
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> 
{

  PomodoroSettings pomodoroSettings = PomodoroSettings();

  @override
  void initState() 
  {
    super.initState();
    fetchData();
  }

  fetchData()async
  {
    pomodoroSettings = (await PomodoroSettingsController.getSettings()) ?? pomodoroSettings;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 18,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Align(alignment: AlignmentGeometry.topLeft , child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_left)),),
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text('Pomodoro', style: TextStyle(fontWeight: FontWeight.bold),),
                  CustomCard(
                    child: IntrinsicHeight(
                    child: Row(
                      spacing: 6,
                      children: [
                        Expanded(child: PomodoroSettingsItem(initialValue: pomodoroSettings.workDuration, label: 'Work', onConfirm: (value)async 
                        {
                          setState(() 
                          {
                            pomodoroSettings.copyWith(workDuration : value);
                          });
                          await PomodoroSettingsController.updateSettings(pomodoroSettings);
                         },)),
                        Expanded(child: PomodoroSettingsItem(initialValue: pomodoroSettings.shortBreak, label: 'Break', onConfirm: (value) async
                        {
                          setState(() 
                          {
                            pomodoroSettings.copyWith(shortBreak : value);
                          });
                          await PomodoroSettingsController.updateSettings(pomodoroSettings);
                         },)),
                        Expanded(child: PomodoroSettingsItem(initialValue: pomodoroSettings.longBreak, label: 'Long break', onConfirm: (value) async
                        {
                          setState(() 
                          {
                            pomodoroSettings.copyWith(longBreak : value);
                          });
                          await PomodoroSettingsController.updateSettings(pomodoroSettings);
                         },)),
                        Expanded(child: PomodoroSettingsItem(initialValue: pomodoroSettings.sessionsUntilLongBreak, label: 'Sessions', onConfirm: (value) async
                        {
                          setState(() 
                          {
                            pomodoroSettings.copyWith(sessionsUntilLongBreak : value);
                          });
                          await PomodoroSettingsController.updateSettings(pomodoroSettings);
                         },))
                      ],
                    ),
                  )),
                ],
              ),
              Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text('Notes', style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}