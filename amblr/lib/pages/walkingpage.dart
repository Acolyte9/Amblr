import 'dart:async';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:amblr/objects/accelerationcheck.dart';
import 'package:amblr/objects/note.dart';
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
  String _document = '';
  late final AmblrPauseDisplay _pausedisplay;

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    _pausedisplay = AmblrPauseDisplay(
      document: Note(title: '', body: _document),
    );
    // TODO: pass the current transcribed document here instead of the empty string.
    // The speech-to-text should pause while the walking page is paused, so this only
    // needs a snapshot of the content recorded so far.

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Brainstorming'),
        flexibleSpace: const FlexibleSpaceBar(
          background: Image(
            image: AssetImage('assets/FirstPicExample.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
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
