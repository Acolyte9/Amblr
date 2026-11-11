import 'package:amblr/objects/note.dart';
import 'package:amblr/objects/storagehandler.dart';
import 'package:amblr/pages/frontpage.dart';
import 'package:flutter/material.dart';
import 'editpage.dart';

class Finishwalkpage extends StatelessWidget {
  final Note document;
  final StorageHandler storage;
  
  const Finishwalkpage({
    super.key,
    required this.document,
    required this.storage,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Paused'),
          ElevatedButton(
            key: const Key("HomepageButton"),
            style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20), backgroundColor: Colors.grey),
            onPressed: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute<void>(
                  builder: (context) {
                    return Frontpage();
                  },
                )
              );
            },
            child: const Text('Finish'),
          ),
          ElevatedButton(
            key: const Key("EditpageButton"),
            style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20), backgroundColor: Colors.grey),
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return DocumentEditorScreen(document: document, storage: storage);
                  },
                )
              );
            },
            child: const Text('Edit'),
          ),
        ]
      )
    );
  }
}