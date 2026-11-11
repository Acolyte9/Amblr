import 'package:amblr/objects/storagehandler.dart';
import 'package:flutter/material.dart';
import 'package:amblr/objects/note.dart';
import 'package:amblr/widgets/deletecheck.dart';

// Screen that shows all saved walk notes in a scrolling list.
class NotesList extends StatefulWidget {
  NotesList({super.key});
  
  final StorageHandler storage = StorageHandler();

  @override
  State<NotesList> createState() => _NotesListState(storage);
}

class _NotesListState extends State<NotesList> {
  // Sample notes so the screen shows something during the prototype.
  final List<Note> notes = [
    new Note(
        id: 1,
        title: "Walk by the lake",
        body: "Ideas for my essay intro...",
        // date: "Nov 2, 2026",
        // timeRange: "3:10 - 5:00 PM"
        ),
    new Note(
        id: 2,
        title: "Morning Walk",
        body: "Thoughts on the project...",
        // date: "Nov 1, 2026",
        // timeRange: "8:00 - 9:20 AM"
        ),
  ];

  _NotesListState(StorageHandler storage);
  
  late StorageHandler storage;

  void _openDeleteDialog(Note note) {
    showDialog(
      context: context,
      builder: (_) {
        return AmblrDeleteCheck(note: note, storage: storage,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Walks'),
        backgroundColor: const Color(0xFF4F7942), // calm outdoors green
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: notes.map((note) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF4F7942),
                child: Icon(Icons.directions_walk, color: Colors.white),
              ),
              title: Text(note.title.toString()),
              // subtitle: Text('${note.date}  •  ${note.timeRange}'),
              onTap: () {
                // Later: open the note to view and edit it
              },
              onLongPress: () {
                _openDeleteDialog(note);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}