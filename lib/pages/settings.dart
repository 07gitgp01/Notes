import 'package:flutter/material.dart';
import 'package:notes/widgets/custom_card.dart';
import 'package:notes/widgets/pomodoro/transparent_pop_up.dart';

class Settings extends StatefulWidget 
{
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> 
{

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: AlignmentGeometry.topLeft , child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_left)),),
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
                        Expanded(child: TextButton(onPressed: ()
                        {
                          TransparentPopUp(context: context, initialValue: 25, onConfirm: (value) 
                            {
                              print('Selected value: $value');
                            },
                          );}, child: Text(''))),
                        Expanded(child: TextButton(onPressed: (){}, child: Text(''))),
                        Expanded(child: TextButton(onPressed: (){}, child: Text(''))),
                      ],
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}