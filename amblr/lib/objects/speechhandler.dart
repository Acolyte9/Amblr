import 'package:continuous_speech_to_text/continuous_speech_to_text.dart';

class SpeechRecognition
{
  final _speechHandler = ContinuousSpeechToText();
  String _recognizedText = '';
  String _errorMessage = '';
  bool    _isListening = false;

  String _selectedLocale = 'en-IN';

  SpeechRecognition()
  {
    _speechHandler.onSpeechEvent.listen((eventMap) {
      final event = eventMap['event'];
      final data = eventMap['data'];

      if(event == 'partialResult' || event == 'result') {
        _recognizedText += data;
      }
      else if(event == 'error') {
        _errorMessage += data + '\n';
      }
    });
  }


  String getLastRecognizedText()
  {
    String tmp = _recognizedText;
    _recognizedText = '';
    return tmp;
  }
  String getLastError()
  {
      String tmp = _errorMessage;
      _errorMessage = '';
      return tmp;
  }
  bool isListening()
  {
    return _isListening;
  }
  void startListening()
  {
    _speechHandler.startListening();
    _isListening = true;
  }
  void pauseListening()
  {
    _speechHandler.stopListening();
    _isListening = false;
  }
}