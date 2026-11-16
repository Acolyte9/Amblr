import 'package:flutter/material.dart';
import 'package:amblr/pages/listNote.dart';
import 'walkingpage.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Walkingpage(),
                  ),
                );
              },
              child: const Text('Start Walking Brainstorming'),
            ),

            const SizedBox(height: 40),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(242, 206, 206, 0.6),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Brainstorms',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 48, 74, 1),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const Card(
                              child: ListTile(
                                leading: Icon(Icons.lightbulb_outline),
                                title: Text('Ideas'),
                                subtitle: Text('Amblr Amblr Amblr'),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            const Card(
                              child: ListTile(
                                leading: Icon(Icons.chat_bubble_outline),
                                title: Text('Chat'),
                                subtitle: Text('Amblr Amblr Amblr'),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            // YOUR SCROLLABLE NOTES LIST
                            Card(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.school_outlined,
                                ),
                                title: const Text(
                                  'Recent brainstorms',
                                ),
                                subtitle: const Text(
                                  'View your saved walking notes',
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NotesList(),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const Card(
                              child: ListTile(
                                leading: Icon(Icons.history),
                                title: Text('History'),
                                subtitle: Text('Amblr Amblr Amblr'),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            const Card(
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text('Profile'),
                                subtitle: Text('Amblr Amblr Amblr'),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            const Card(
                              child: ListTile(
                                leading: Icon(Icons.help_outline),
                                title: Text('Help'),
                                subtitle: Text('Amblr Amblr Amblr'),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            const Card(
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
          ],
        ),
      ),
    );
  }
}
