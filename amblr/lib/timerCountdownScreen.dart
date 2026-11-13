
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

  String formatTime() {
  int minutes = remainingSeconds ~/ 60;
  int seconds = remainingSeconds % 60;

  return '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walking Timer'),
      ),
      body: Center(
  child: Text(
    formatTime(),
    style: const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      ),),
      ),
    );
  }
}
