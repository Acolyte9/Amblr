import 'package:amblr/objects/note.dart';
import 'package:amblr/objects/storagehandler.dart';
import 'package:flutter/material.dart';

import 'walkingpage.dart';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => FrontClassExtension();
}

class FrontClassExtension extends State<Frontpage> {
  final storage = StorageHandler();
  late Future<List<Note>> notesFuture = storage.getNotes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
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
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 60),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Walkingpage()),
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
                        textAlign: TextAlign.center,
                        'Recent Brainstorms',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 48, 74, 1),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<List<Note>>(
                          future: notesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Could not load notes.'),
                              );
                            }

                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final notes = snapshot.data!;
                            if (notes.isEmpty) {
                              return const Center(
                                child: Text('No saved brainstorms yet.'),
                              );
                            }

                            return ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                for (final note in notes)
                                  ListTile(
                                    title: Text(note.title ?? ''),
                                    subtitle: Text(
                                      note.body ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            );
                          },
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
