// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:amblr/objects/accelerationcheck.dart';


class AmblrPauseDisplay extends StatefulWidget {
  const AmblrPauseDisplay({
    super.key,
    // required this.accelcheck,
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
    return const Center(child: Text('Paused'));
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