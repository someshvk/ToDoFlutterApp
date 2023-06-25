import 'package:flutter/material.dart';
import 'package:flutter_application/utils/my_buttons.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onAdd;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onAdd,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a new task'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: MyButtons(buttonName: 'Add', onPressed: onAdd)),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child:
                          MyButtons(buttonName: 'Cancel', onPressed: onCancel))
                ],
              ),
            ],
          ),
        ));
  }
}
