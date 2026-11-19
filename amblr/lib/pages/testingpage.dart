import 'dart:async';
import 'dart:core';

import 'package:amblr/objects/speechhandler.dart';
import 'package:continuous_speech_to_text/continuous_speech_to_text.dart';
import 'package:flutter/material.dart';

class testPage extends StatefulWidget
{
  @override
  State<testPage> createState() => testState();
  const testPage({super.key});
}

class testState extends State<testPage>
{
  var _speechHandler = ContinuousSpeechToText();
  String partial = "";
  String wholeWords ="";
  String error = "";
  SpeechRecognition sr = SpeechRecognition();
  testState()
  {
    
  }
  
  
  @override
  void initState()
  {
    super.initState();
   
    sr.addSubscriber(onSpeechEvent);
    sr.startListening();
     _speechHandler.startListening(localeId: 'en-IN');
  }
  
  void onSpeechEvent()
  {
    setState(() {
      partial += sr.getLastPartialText();
      wholeWords = sr.getLastRecognizedText();
      error = sr.getLastError();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
        Column(
          children: [
            Text("Partial"),
            Text(partial),
            Text("whole words"),
            Text(wholeWords),
            Text("Last error"),
            Text(error),
            FilledButton(onPressed: () {
              setState(() {
                
              partial = "";
              wholeWords = "";
              error = "";
              });
            }, child: ColoredBox(color: Colors.lightGreenAccent),
            )
          ],
        )
    );
  }
}