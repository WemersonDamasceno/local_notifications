import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/views/home_page.dart';

class ButtonForExample extends StatefulWidget {
  const ButtonForExample({super.key});

  @override
  State<ButtonForExample> createState() => _ButtonForExampleState();
}

class _ButtonForExampleState extends State<ButtonForExample> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.check, color: Colors.white),
          onPressed: () {
            setState(() {
              statusScreen = StatusScreenEnum.success;
            });
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.error, color: Colors.white),
          onPressed: () {
            setState(() {
              statusScreen = StatusScreenEnum.error;
            });
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () {
            setState(() {
              statusScreen = StatusScreenEnum.loading;
            });
          },
        ),
      ],
    );
  }
}
