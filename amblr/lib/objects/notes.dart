import 'package:flutter/material.dart';
import 'lib/widgets/deletecheck.dart'

class Notes{
  //constructor
  const Notes ({
    required this.id,
    required this.title,
    required this.text,
    required this.timeRange,
    required this.date,
  });

  final String id;
  final String title;
  final String text;
  final String timeRange;
  final String date;

}

//time range
//date