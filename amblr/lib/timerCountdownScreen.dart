import 'dart:async';
import 'package:flutter/material.dart';

class TimerCountDownScreen extends StatefulWidget {
  const TimerCountDownScreen({super.key});

  @override
  State<TimerCountDownScreen> createState() {
    return _TimerCountDownScreenState();
  }
}

class _TimerCountDownScreenState extends State<TimerCountDownScreen> {
  int remainingSeconds = 300;
  bool isRunning = false;
  Timer? timer;
  String formatTime() {
  int minutes = remainingSeconds ~/ 60;
  int seconds = remainingSeconds % 60;

  return '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}';
}


void startCountdown() {
  if (isRunning || remainingSeconds == 0) {
    return;
  }

  setState(() {
    isRunning = true;
  });

  timer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      }

      if (remainingSeconds == 0) {
        timer.cancel();

        setState(() {
          isRunning = false;
        });
      }
    },
  );
}

@override
void dispose() {
  timer?.cancel();
  super.dispose();
}


@override
Widget build(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Walking Countdown',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          formatTime(),
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isRunning || remainingSeconds == 0
              ? null
              : startCountdown,
          child: const Text('Start'),
        ),
      ],
    ),
  );
}
}
