// import 'dart:async';
import 'package:amblr/objects/note.dart';
// import 'package:amblr/objects/storagehandler.dart';
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