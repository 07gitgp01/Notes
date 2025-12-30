import 'package:flutter/material.dart';
import 'package:notes/widgets/pop_up.dart';

void TransparentPopUp({required BuildContext context, int initialValue = 0, Function(int)? onConfirm}) 
{
  int currentValue = initialValue;

  PopUp(
    context: context,
    dismissible: true,
    barrierColor: Colors.transparent,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentValue--;
                          });
                        },
                        icon: const Icon(Icons.remove, size: 28),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 80,
                        child: Text(
                          '$currentValue',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentValue++;
                          });
                        },
                        icon: const Icon(Icons.add, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 28, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          onConfirm?.call(currentValue);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.check, size: 28, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}