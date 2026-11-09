import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:amblr/objects/storagehandler.dart';

void main() {
  late StorageHandler storage;
  late Database db;

  setUp(() async {
    sqfliteFfiInit();

    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: StorageHandler.createSchema,
      ),
    );

    storage = StorageHandler(database: Future.value(db));
  });

  tearDown(() async {
    await storage.close();
  });

  group('StorageHandler CRUD operations', () {

    test('Database starts empty', () async {
      final notes = await storage.getNotes();

      expect(notes, isEmpty);
    });

    test('Insert a note', () async {
      final note = Note(
        title: 'Test Note',
        body: 'This is a test',
        created: DateTime.utc(2026),
        modified: DateTime.utc(2026)
      );

      final id = await storage.insert(note);
      note.setId(id);

      expect(id, greaterThan(0));

      final notes = await storage.getNotes();

      expect(notes.length, 1);
      expect(notes.first.title, 'Test Note');
      expect(notes.first.body, 'This is a test');
      expect(notes.first.id, id);
    });

    test('Insert multiple notes', () async {
      await storage.insert(
        Note(title: 'Note 1', body: 'Body 1', created: DateTime.utc(2026),
        modified: DateTime.utc(2026)),
      );

      await storage.insert(
        Note(title: 'Note 2', body: 'Body 2', created: DateTime.utc(2026),
        modified: DateTime.utc(2026)),
      );

      final notes = await storage.getNotes();

      expect(notes.length, 2);
      expect(notes[0].title, 'Note 1');
      expect(notes[1].title, 'Note 2');
    });

    test('Update an existing note', () async {
      final id = await storage.insert(
        Note(title: 'Original', body: 'Original body', created: DateTime.utc(2026), modified: DateTime.utc(2026)),
      );

      final updatedNote = Note(
        id: id,
        title: 'Updated',
        body: 'Updated body',
        created: DateTime.utc(2026), 
        modified: DateTime.utc(2026)

      );

      final rowsUpdated = await storage.update(updatedNote);

      expect(rowsUpdated, 1);

      final notes = await storage.getNotes();

      expect(notes.length, 1);
      expect(notes.first.title, 'Updated');
      expect(notes.first.body, 'Updated body');
      expect(notes.first.id, id);
    });

    test('Delete an existing note', () async {
      final id = await storage.insert(
        Note(title: 'Delete me', body: 'Temporary', created: DateTime.utc(2026),
        modified: DateTime.utc(2026)),
      );

      final rowsDeleted = await storage.delete(
        Note(
          id: id,
          title: 'Delete me',
          body: 'Temporary',
        ),
      );

      expect(rowsDeleted, 1);

      final notes = await storage.getNotes();

      expect(notes, isEmpty);
    });

    test('Multiple notes with the same title remain independent',
        () async {
      final firstId = await storage.insert(
        Note(title: 'Duplicate', body: 'First body', created: DateTime.utc(2026),
        modified: DateTime.utc(2026)),
      );

      final secondId = await storage.insert(
        Note(title: 'Duplicate', body: 'Second body', created: DateTime.utc(2026),
        modified: DateTime.utc(2026)),
      );

      await storage.delete(
        Note(
          id: firstId,
          title: 'Duplicate',
          body: 'First body',
          created: DateTime.utc(2026),
        modified: DateTime.utc(2026)
        ),
      );

      final notes = await storage.getNotes();

      expect(notes.length, 1);
      expect(notes.first.id, secondId);
      expect(notes.first.body, 'Second body');
    });

    test('Updating a nonexistent note affects zero rows', () async {
      final rowsUpdated = await storage.update(
        Note(
          id: 999,
          title: 'Missing',
          body: 'Does not exist',
          created: DateTime.utc(2026),
        modified: DateTime.utc(2026)
        ),
      );

      expect(rowsUpdated, 0);
    });

    test('Deleting a nonexistent note affects zero rows', () async {
      final rowsDeleted = await storage.delete(
        Note(
          id: 999,
          title: 'Missing',
          body: 'Does not exist',
          created: DateTime.utc(2026),
        modified: DateTime.utc(2026)
        ),
      );

      expect(rowsDeleted, 0);
    });

    test('Updating a note without an ID throws an error', () async {
      expect(
        () => storage.update(
          Note(title: 'Missing ID', body: 'Test', created: DateTime.utc(2026),
        modified: DateTime.utc(2026)),
        ),
        throwsArgumentError,
      );
    });

    test('Deleting a note without an ID throws an error', () async {
      expect(
        () => storage.delete(
          Note(title: 'Missing ID', body: 'Test', created: DateTime.utc(2026),
        modified: DateTime.utc(2026)),
        ),
        throwsArgumentError,
      );
    });
  });
}