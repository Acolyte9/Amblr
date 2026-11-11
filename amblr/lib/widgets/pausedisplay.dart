// import 'dart:async';
import 'package:amblr/objects/note.dart';
import 'package:amblr/objects/storagehandler.dart';
import 'package:amblr/pages/finishwalkpage.dart';
import 'package:flutter/material.dart';
// import 'package:amblr/objects/accelerationcheck.dart';


class AmblrPauseDisplay extends StatefulWidget {
  final Note document;
  const AmblrPauseDisplay({
    super.key,
    // required this.accelcheck,
    required this.document,
  });

  // final Accelcheck? accelcheck;
  // bool awaitunpause = false;

  // void unpause() {
  //   awaitunpause = true;
  // }

  @override
  State<StatefulWidget> createState() => PauseDisplayState();  
}

class PauseDisplayState extends State<AmblrPauseDisplay> {
  // late Timer _timer;

  void saveDocument() {
    // try 
    // {
      StorageHandler storage = StorageHandler();
      // await 
      storage.update(
        // widget.documentId,
        Note(
          body: widget.document.body, 
          id: widget.document.id, 
          title: widget.document.title, 
          created: DateTime.now(),
          modified: DateTime.now(),
          )
        
        // widget.document.title = title,
        // content: textController.text,
      );

      // if (!mounted) return;

      // titleController.text = title;

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Document saved!')),
      // );
      // } catch (error) {
      //   if (!mounted) return;

      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Could not save document: $error')),
      //   );
      // } finally {
      //   if (mounted) {
      //     setState(() {
      //       isSaving = false;
      //     });
      //   }
      // }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Paused'),
          ElevatedButton(
            key: const Key("HomepageButton"),
            style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20), backgroundColor: Colors.green),
            onPressed: () {
              saveDocument();
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute<void>(
                  builder: (context) {
                    return Finishwalkpage(document: widget.document);
                  },
                ),
                ModalRoute.withName('/'),
              );
            },
            child: const Text('Finish'),
          ),
        ]
      ),
    );
  }
  
  // void unpause() {
  //   Navigator.pop(context);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _timer = Timer.periodic(const Duration(milliseconds: 250), (_) {
  //     setState(() {
  //       if (this.awaitunpause) {

  //       }
  //     });
  //   });
  // }
}