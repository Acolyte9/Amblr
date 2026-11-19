import 'package:continuous_speech_to_text/continuous_speech_to_text.dart';

class SpeechRecognition
{
  final _speechHandler = ContinuousSpeechToText();
  late List<Function> updateCallbackList;
  String _recognizedText = '';
  //testing
  String _partialText = '';
  String _errorMessage = '';
  bool    _isListening = false;

  String _selectedLocale = 'en-IN';

  SpeechRecognition()
  {
    updateCallbackList = List.empty(growable: true);
    _speechHandler.onSpeechEvent.listen((eventMap) {
      final event = eventMap['event'];
      final data = eventMap['data'];


      if(event == 'partialResult') {
        _recognizedText += data;
      }
      else if(event == 'result')
      {
        _partialText = data;
      }
      else if(event == 'error') {
        _errorMessage = data;
        
      }
      onTextGet();
    });
  }

  void addSubscriber(Function func)
  {
    updateCallbackList.add(func);
  }


  String getLastRecognizedText()
  {
    String tmp = _recognizedText;
    _recognizedText = '';
    return tmp;
  }
  String getLastPartialText()
  {
    String tmp = _partialText;
    _partialText = '';
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
    _speechHandler.startListening(localeId: _selectedLocale);
    _isListening = true;
  }
  void pauseListening()
  {
    _speechHandler.stopListening();
    _isListening = false;
  }

  void onTextGet()
  {
    for(int i = 0; i < updateCallbackList.length; ++i)
    {
      updateCallbackList[i]();
    }
  }
}