import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  Function(bool?)? onChanged;
  SettingsPage({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 23),
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Center(
          child: Text("Settings",
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 27))
          ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 3.0, top: 3),
        child: Container(
          padding: const EdgeInsets.only(left: 9.0, top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.tertiary)
              ),
              Transform.scale(
                scale: 1,
                child: Checkbox(
                  value: true,
                  onChanged: onChanged,
                  checkColor: Theme.of(context).colorScheme.tertiary,
                  activeColor: Colors.black
                )
              )
            ],
          )
        )
    )
    );
  }
}
