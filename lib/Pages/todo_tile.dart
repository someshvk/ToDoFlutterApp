// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  // ignore: prefer_typing_uninitialized_variables

  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteTask});

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3),
      child: Container(
        padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3),
        child: Row(
          children: [
            Transform.scale(
                scale: 0.8,
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  checkColor: Theme.of(context).colorScheme.tertiary,
                  activeColor: Colors.black,
                  //fillColor: MaterialStateProperty.resolveWith(getColor)
                )),
            Expanded(
                child: Text(
              taskName,
              style: TextStyle(
                color: taskCompleted
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            )),
            Transform.scale(
              scale: 0.5,
              child: IconButton(
                color: Theme.of(context).colorScheme.tertiary,
                onPressed: () => deleteTask!(context),
                icon: const Icon(Icons.clear),
              ),
            )
          ],
        ),
      ),
    );
  }
}
