// import 'package:flutter/material.dart';
// import 'package:amblr/widgets/deletecheck.dart';

class Note{
  //constructor
  const Note ({
    required this.id,
    required this.title,
    required this.body,
    // required this.timeRange,
    // required this.date,
  });

  final String id;
  final String title;
  final String body;
  // final String timeRange;
  // final String date;

  Map<String, Object?> toMap() {
    return {'title': title, 'body': body};
  }
}

//time range
//date