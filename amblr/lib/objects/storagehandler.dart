import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageHandler {
    final Future<Database> DB;
    static Future<Database> initDatabase({String? path}) async {
      final dbPath = path ?? join(await getDatabasesPath(), 'storage.db');

      return openDatabase(
        dbPath,
        onCreate: createSchema,
        version: 1,
      );
    }

    static Future<void> createSchema(Database db, int version) async {
        await db.execute(
          '''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            body TEXT NOT NULL
          )
          '''
        );
      }   

    ///database parameter can be left null, exists to allow database injecting for testing purposes
    StorageHandler({Future<Database>? database}) : DB = database ?? initDatabase();


    ///Inserts a Note object into database
    ///
    ///Returns an integer - the primary key id of that note
    ///
    ///HEAVILY RECOMMENDED - set the Note's id field to this return variable immediately after
    Future<int> insert(Note note) async {
      var db = await DB;
      return await db.insert(
        'notes',
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    }

    ///Returns a list of all Note objects inside the database
    ///
    ///TODO: 
    ///Add way to sort (either through SQLite syntax or other means)
    ///Add pagination & lazy loading
    Future<List<Note>> getNotes() async {
      var db = await DB;
      final List<Map<String, Object?>> notes = await db.query('notes');
      return [
        for(final {'id': id as int, 'title': title as String, 'body': body as String} in notes)
          Note(id: id, title: title, body: body),
      ];
    }

    ///Updates an existing Note object inside the database
    ///
    ///Returns an int for number of changes made (should only be 1)
    Future<int> update(Note note) async {
      if(note.id == null)
      {
        throw ArgumentError.notNull();
      }
      var db = await DB;
      return await db.update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id]
      );
    }

    ///Deletes an existing Note object inside the database
    ///
    ///Returns an int for number of changes made (should only be 1)
    Future<int> delete(Note note) async {
      if(note.id == null)
      {
        throw ArgumentError.notNull();
      }
      var db = await DB;
      return await db.delete(
        'notes',
        where: 'id = ?',
        whereArgs: [note.id]
      );
    }

    ///Closes the database
    ///
    ///Only really needed for testing purposes
    Future<void> close() async {
      var db = await DB;
      db.close();
    }
}

class Note {
  int? id;
  String? title;
  String? body;

  //Add extra metadata (Date created, Date modified, Length of body?, etc)

  Note({this.id, this.title, this.body});

  void setId(int id_)
  {
    id = id_;
  }

  Map<String, Object?> toMap() {
    return 
    {'title': title, 'body': body};
  }

  factory Note.fromMap(Map<String, Object?> map)
  {
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String
    );
  }
}