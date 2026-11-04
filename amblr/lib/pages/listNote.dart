import 'package:flutter/material.dart';
import 'package:amblr/objects/notes.dart';
import 'package:amblr/widgets/deletecheck.dart';

// Screen that shows all saved walk notes in a scrolling list.
class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  // Sample notes so the screen shows something during the prototype.
  final List<Note> notes = [
    const Note(
        id: "1",
        title: "Walk by the lake",
        text: "Ideas for my essay intro...",
        date: "Nov 2, 2026",
        timeRange: "3:10 - 5:00 PM"),
    const Note(
        id: "2",
        title: "Morning Walk",
        text: "Thoughts on the project...",
        date: "Nov 1, 2026",
        timeRange: "8:00 - 9:20 AM"),
  ];

  void _openDeleteDialog(Note note) {
    showDialog(
      context: context,
      builder: (_) {
        return AmblrDeleteCheck(id: note.id);
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
              title: Text(note.title),
              subtitle: Text('${note.date}  •  ${note.timeRange}'),
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