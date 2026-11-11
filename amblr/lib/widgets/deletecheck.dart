import 'package:amblr/objects/note.dart';
import 'package:amblr/objects/storagehandler.dart';
import 'package:flutter/material.dart';

// typedef ToDoListDeletedCallback = Function(
//     String item
//     );

class AmblrDeleteCheck extends StatefulWidget {
  const AmblrDeleteCheck({
    super.key,
    required this.note,
    required this.storage,
  });

  final Note note;
  final StorageHandler storage;
  // final (SOME KIND OF LIST OF FILES OR WAY TO INTERACT WITH SAVED FILES);

  @override
  State<AmblrDeleteCheck> createState() => _AmblrDeleteCheckState();
}

class _AmblrDeleteCheckState extends State<AmblrDeleteCheck> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  // final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.grey);

  // String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Item?'),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          key: const Key("OKButton"),
          style: yesStyle,
          onPressed: () {
            setState(() {
              widget.storage.delete(widget.note);
              // ^^^^^^^^^^^^^THIS IS WHERE THE DELETING HAPPENS
              Navigator.pop(context);
            });
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
