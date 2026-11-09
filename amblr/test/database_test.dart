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
        Note(title: 'Note 1', body: 'Body 1'),
      );

      await storage.insert(
        Note(title: 'Note 2', body: 'Body 2'),
      );

      final notes = await storage.getNotes();

      expect(notes.length, 2);
      expect(notes[0].title, 'Note 1');
      expect(notes[1].title, 'Note 2');
    });

    test('Update an existing note', () async {
      final id = await storage.insert(
        Note(title: 'Original', body: 'Original body'),
      );

      final updatedNote = Note(
        id: id,
        title: 'Updated',
        body: 'Updated body',
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
        Note(title: 'Delete me', body: 'Temporary'),
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
        Note(title: 'Duplicate', body: 'First body'),
      );

      final secondId = await storage.insert(
        Note(title: 'Duplicate', body: 'Second body'),
      );

      await storage.delete(
        Note(
          id: firstId,
          title: 'Duplicate',
          body: 'First body',
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
        ),
      );

      expect(rowsDeleted, 0);
    });

    test('Updating a note without an ID throws an error', () async {
      expect(
        () => storage.update(
          Note(title: 'Missing ID', body: 'Test'),
        ),
        throwsArgumentError,
      );
    });

    test('Deleting a note without an ID throws an error', () async {
      expect(
        () => storage.delete(
          Note(title: 'Missing ID', body: 'Test'),
        ),
        throwsArgumentError,
      );
    });
  });
}