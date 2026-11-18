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
        appBar: AppBar(
          flexibleSpace: Image.asset(
            'assets/FirstPicExample.jpg',
            fit: BoxFit.cover,
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'about',
                  child: Text('About'),
                ),
              ],
              icon: const Icon(Icons.settings, color: Colors.white),
              onSelected: (option) {
                if (option == 'about') {
                  showAboutDialog(context: context, applicationName: 'Amblr');
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 380,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    image: AssetImage('assets/FirstPicExample.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amblr',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Walkingpage(),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Start Walking Brainstorming',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: const Color.fromARGB(
                    255,
                    235,
                    227,
                    160,
                  ).withOpacity(0.4),
                  child: FutureBuilder<List<Note>>(
                    future: notesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Could not load notes.'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
