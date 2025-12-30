import 'package:flutter/material.dart';
import 'package:notes/widgets/pop_up.dart';

void TransparentPopUp({required BuildContext context, int initialValue = 0, Function(double)? onConfirm})
{
  PopUp(
    context: context,
    dismissible: true,
    barrierColor: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: IntrinsicHeight(
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.remove, size: 22,)),
                      Expanded(child: Center(child: Text('', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),))),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add, size: 22,))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.close, size: 22,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.check, size: 22,))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    )
  );
}