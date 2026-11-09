import 'dart:async';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:amblr/objects/accelerationcheck.dart';
import 'package:amblr/widgets/pausedisplay.dart';

class Walkingpage extends StatefulWidget {
  const Walkingpage({super.key});

  @override
  State<Walkingpage> createState() => _WalkingpageState();
}

class _WalkingpageState extends State<Walkingpage> {
  final Accelcheck accelcheck = Accelcheck();

  List<AccelerometerEvent> _accelerometerValues = [];
  late Timer _timer;

  bool pauseup = false;
  late final AmblrPauseDisplay _pausedisplay;

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    _pausedisplay = AmblrPauseDisplay();

    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      _accelerometerValues = [event];
    });
    // Subscribe to accelerometer events

    _timer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      _checkAccel();
    });
  }

  void _checkAccel() {
    if (_accelerometerValues.isEmpty) return;

    final event = _accelerometerValues.last;
    accelcheck.accelUpdate(event.x, event.y, event.z);

    if (accelcheck.isStill()) {
      if (!pauseup) {
        pauseup = true;
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) {
              return _pausedisplay;
            },
          ),
        ).whenComplete(() {
          pauseup = false;
        });
      }
    } else {
      if (pauseup) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('New Brainstorming')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/FirstPicExample.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Walking Brainstorming in Progress...\nwhere your thoughts can flow freely while you walk!',
            style: TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
