import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:amblr/objects/accelerationcheck.dart';
import 'package:amblr/widgets/pausedisplay.dart';

class Walkingpage extends StatefulWidget {
  Walkingpage({super.key});
  
  Accelcheck accelCheck = Accelcheck();

  @override
  State<Walkingpage> createState() => _WalkingpageState();
}

class _WalkingpageState extends State<Walkingpage> {
  _WalkingpageState(this.accelCheck);
  List<AccelerometerEvent> _accelerometerValues = [];
  late Timer _timer;

  Accelcheck? accelCheck;

  // StreamSubscription for accelerometer events
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

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
      accelCheck!.accelUpdate(_accelerometerValues[0].x, _accelerometerValues[0].y, _accelerometerValues[0].z);
    }
    if (accelCheck!.isStill()) {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => AmblrPauseDisplay(accelCheck)),
        );
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
