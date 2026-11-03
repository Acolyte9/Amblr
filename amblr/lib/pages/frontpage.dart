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
              const SizedBox(height: 24),

              Expanded(
                child: Container(
                  color: Colors.white.withOpacity(0.4),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.lightbulb_outline),
                          title: Text('Ideas'),
                          subtitle: Text('Amblr Amblr Amblr'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.chat_bubble_outline),
                          title: Text('Chat'),
                          subtitle: Text('Amblr Amblr Amblr'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.school_outlined),
                          title: Text('Recent brainstorms'),
                          subtitle: Text('Amblr Amblr Amblr'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text('History'),
                          subtitle: Text('Amblr Amblr Amblr'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),

                      Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profile'),
                          subtitle: Text('Amblr Amblr Amblr'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.help_outline),
                          title: Text('Help'),
                          subtitle: Text('Amblr Amblr Amblr'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          subtitle: Text('Amblr Amblr Amblr'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
