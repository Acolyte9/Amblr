import 'dart:async';
import 'package:amblr/objects/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageHandler {
    static late final Database db;
    StorageHandler() {
      initDatabase();
    }
    static Future<Database> initDatabase() async {
      if(db.path.isEmpty)
      {
        db = await openDatabase(
          join(await getDatabasesPath(), 'storage.db'),
          onCreate: (db, version) {
            return db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY, title STRING, body STRING)'
            );
          },
          version: 1,
        );
      }
      return db;
    }

    static Future<void> insert(Note note) async {
      await db.insert(
        'notes',
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    }

    static Future<List<Note>> getNotes() async {
      final List<Map<String, Object?>> notes = await db.query('notes');
      return [
        for(final {'id': id as String, 'title': title as String, 'body': body as String} in notes)
          Note(id: id, title: title, body: body),
      ];
    }

    static Future<void> update(Note note) async {
      await db.update(
        'notes',
        note.toMap(),
        where: 'title = ?',
        whereArgs: [note.title]
      );
    }

    static Future<void> delete(Note note) async {
      await db.delete(
        'notes',
        where: 'title = ?',
        whereArgs: [note.title]
      );
    }
}

// class Note {
//   final String title;
//   final String body;

//   Note({required this.title, required this.body});

//   Map<String, Object?> toMap() {
//     return {'title': title, 'body': body};
//   }
// }