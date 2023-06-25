import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 17, 24),
        title: Text("Settings",
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 3.0, top: 3),
        child: Container(
          padding: const EdgeInsets.only(left: 9.0, top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dark Mode'
              ),
              Transform.scale(
                scale: 0.7,
                child: LiteRollingSwitch(
                  value: true,
                  width: 100,
                  textOn: 'On',
                  textOff: 'Off',
                  colorOn: const Color.fromARGB(255, 75, 75, 111),
                  colorOff: const Color.fromARGB(255, 79, 79, 81),
                  textSize: 12.0,
                  iconOn: Icons.dark_mode,
                  iconOff: Icons.light_mode,
                  onTap: (){}, 
                  onDoubleTap: (){}, 
                  onSwipe: (){}, 
                  onChanged: (bool state) {
                    print('turned ${(state) ? 'yes' : 'no'}');
                  },
                )
              )
            ],
          )
        )
    ));
  }
}
