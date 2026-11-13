import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'timerScreen.dart';
import 'main.dart';



class timerCountDownScreen extends StatefulWidget {
  const timerCountDownScreen({super.key});
  @override
    State<timerCountDownScreen> createState(){

      return _timerCountDownScreenState();
    }
    class _timerCountDownScreenState extends State<timerCountDownscreen> {

      int timerRange = 300;
      int startTimer = 5;
      bool isRunning = False;

      // if timerRange>0{ 
   //timerRange-=1;

    //}
   // else{
     // isRunning = false;

     @override
      Widget build(BuildContext context) {
        return Scaffold();
        Title: 'Timer Count Down',
        //Start 

        //Pause

      }


}

}