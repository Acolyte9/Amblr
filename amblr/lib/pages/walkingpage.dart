import 'package:flutter/material.dart';

class Walkingpage extends StatelessWidget {
  const Walkingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Brainstorming'),
      ),
      body: const Center(child: Text('Walking = recording')),
    );
  }
}
