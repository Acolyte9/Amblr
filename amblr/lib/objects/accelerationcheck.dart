// import 'dart:async';
import 'dart:math' as math;
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';


class Accelcheck {
  // const AccelCheck({super.key});
  Accelcheck({this.fallowThreshold = 20, this.timeThreshold = 1000});
  int fallowThreshold;
  int timeThreshold;
  int stillnessStreak = 0;


  // @override
  // State<AccelCheck> createState() => _AccelState();


  // List to store accelerometer data
  // List<AccelerometerEvent> _accelerometerValues = [];
  bool isStill() {
    return stillnessStreak > timeThreshold;
  }
  double magnitude(double accelX, double accelY, double accelZ) {
    return math.sqrt(accelX * accelX + accelY * accelY + accelZ * accelZ,);
  }
  // StreamSubscription for accelerometer events
  // late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  void accelUpdate(double accelX, double accelY, double accelZ) {
    if (magnitude(accelX, accelY, accelZ) <= fallowThreshold) {
      stillnessStreak += 1;
    }
    else {
      stillnessStreak = 0;
    }
  }
  
//   @override
//   void initState() {
//     super.initState();

//     // Subscribe to accelerometer events
//     _accelerometerSubscription = accelerometerEventStream().listen((event) {
//       setState(() {
// //including z axis involves acceleration due to gravity as well
//       double accelX = event.x;
//       double accelY = event.y;
//       double accelZ = event.z;

//       double magnitude = math.sqrt(accelX * accelX + accelY * accelY + accelZ * accelZ,);
//       isStill = magnitude > 20;
//       });
//     });
//   }

  // @override
  // void dispose() {
  //   // Cancel the accelerometer event subscription to prevent memory leaks
  //   _accelerometerSubscription.cancel();
  //   super.dispose();
  // }

}