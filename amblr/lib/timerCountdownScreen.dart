
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walking Timer'),
      ),
      body: const Center(
        child: Text('Countdown Timer'),
      ),
    );
  }
}
