import 'dart:async';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:amblr/objects/accelerationcheck.dart';
import 'package:amblr/widgets/pausedisplay.dart';

class Walkingpage extends StatefulWidget {
  Walkingpage({super.key});
  
  Accelcheck accelcheck = Accelcheck();

  @override
  State<Walkingpage> createState() => _WalkingpageState(accelcheck);
}

class _WalkingpageState extends State<Walkingpage> {
  _WalkingpageState(this.accelcheck);
  List<AccelerometerEvent> _accelerometerValues = [];
  late Timer _timer;

  late bool pauseup = false;
  Accelcheck? accelcheck;
  late final AmblrPauseDisplay _pausedisplay;

  // StreamSubscription for accelerometer events
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _pausedisplay = AmblrPauseDisplay(
      // accelcheck: accelcheck
      );

    // Subscribe to accelerometer events
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      setState(() {
        // Update the _accelerometerValues list with the latest event
        _accelerometerValues = [event];
      });
    });

    _timer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      setState(() {
        _checkAccel();
      });
    });
  }

  void _checkAccel() {
    if (_accelerometerValues.isNotEmpty) {
      accelcheck!.accelUpdate(_accelerometerValues[0].x, _accelerometerValues[0].y, _accelerometerValues[0].z);
    }
    if (accelcheck!.isStill()) {
      if (pauseup = false) {
        pauseup = true;
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) {
              return _pausedisplay;
            }
          ),
        );
      }
    }
    else {
      if (pauseup = true) {
        pauseup = false;
        // _pausedisplay.unpause();
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    // Cancel the accelerometer event subscription to prevent memory leaks
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('New Brainstorming')),
      body: const Center(child: Text('Walking = recording')),
    );
  }
}
