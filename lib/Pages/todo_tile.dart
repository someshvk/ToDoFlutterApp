// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application/themes/style.dart';
import 'package:flutter_application/themes/theme_manager.dart';
import 'package:provider/provider.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  Function(BuildContext)? editToDo;

  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteTask,
      required this.editToDo});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    
    return Padding(
  padding: const EdgeInsets.only(left: 3.0, right: 3),
  child: Container(
    padding: const EdgeInsets.only(left: 3.0, right: 3, top: 15.0),
    child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 24.0,
              height: 24.0,
              child: Checkbox(
                visualDensity: VisualDensity.compact,
                value: taskCompleted,
                onChanged: onChanged,
                side: BorderSide(
                  color: themeManager.darkTheme
                      ? Styles.darkActiveTextColor
                      : Styles.lightActiveTextColor,
                ),
                checkColor: themeManager.darkTheme
                    ? Styles.darkBackgroundColor
                    : Styles.lightBackgroundColor,
                activeColor: themeManager.darkTheme
                    ? Styles.darkActiveTextColor
                    : Styles.lightActiveTextColor,
              ),
            ),
          Expanded(
            child: Padding(padding: const EdgeInsets.only(left: 8.0, right: 3.0),
            child: GestureDetector(
              onTap: () => editToDo!(context),
              child: Text(
                ('$taskName.'),
                style: TextStyle(
                  color: taskCompleted
                      ? (themeManager.darkTheme
                          ? Styles.darkInactiveTextColor
                          : Styles.lightInactiveTextColor)
                      : (themeManager.darkTheme
                          ? Styles.darkActiveTextColor
                          : Styles.lightActiveTextColor),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  decorationThickness: 2,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          )),
          SizedBox(
              width: 24.0,
              height: 24.0,
              child: Transform.translate(
              offset: const Offset(-7.0, -8.0),
              child: Transform.scale(
                scale: 0.7,
                child: IconButton(
                  color: themeManager.darkTheme
                      ? Styles.darkActiveTextColor
                      : Styles.lightActiveTextColor,
                  onPressed: () => deleteTask!(context),
                  icon: const Icon(Icons.clear),
                ),
              ),
            )
          ),
        ],
      ),
    ),
  ),
);

  }
}
