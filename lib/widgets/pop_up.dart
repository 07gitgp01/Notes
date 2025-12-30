import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void PopUp({required BuildContext context, required Widget child, bool insetPadding = false, MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center, bool dismissible = true, Color barrierColor = Colors.black54, double elevation = 2, bool autoFocus = true})
{
  if(context.mounted)
  {
    final FocusNode _focusNode = FocusNode();
    showDialog(
        fullscreenDialog: true,
        barrierColor: barrierColor,
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context)
        {
          return StatefulBuilder(
              builder: (context, setState)
              {
                return KeyboardListener(
                  focusNode: _focusNode,
                  autofocus: autoFocus,
                  onKeyEvent: (event)
                  {
                    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape)
                    {
                      Navigator.pop(context);
                    }
                  },
                  child: Dialog(
                    backgroundColor: barrierColor,
                    elevation: elevation,
                    insetPadding: insetPadding == true ? const EdgeInsets.all(12) : null,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: child,
                  ),
                );
              }
          );
        });
  }
}