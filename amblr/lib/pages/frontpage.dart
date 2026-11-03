import 'package:flutter/material.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/FirstPicExample.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 150),
              const Text(
                'Amblr',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 60)),
                onPressed: () {
                  // Handle button press
                },
                child: const Text('Start Walking Brainstorming'),
              ),
              Expanded(
                child: CarouselView.weighted(
                  scrollDirection: Axis.vertical,
                  flexWeights: const <int>[1],
                  children: List<Widget>.generate(10, (int index) {
                    return Center(child: Text('Item $index'));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
