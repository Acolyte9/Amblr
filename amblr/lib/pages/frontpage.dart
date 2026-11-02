import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text('Welcome to Amblr!')],
                ),
              ),
            ),
            Image.asset('assets/FirstPicExample.jpg'),
          ],
        ),
        floatingActionButton: Center(
          child: FloatingActionButton(
            onPressed: () {
              // Handle button press
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(title: const Text('Amblr'));
}
