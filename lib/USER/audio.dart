import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:quiz/Colors.dart';

class SpeechRec extends StatefulWidget {
  @override
  _SpeechRecState createState() => _SpeechRecState();
}

class _SpeechRecState extends State<SpeechRec> {
  bool _hasSpeech = false;
  bool _stressTest = false;
  double level = 0.0;
  int _stressLoops = 0;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Initialize',
                        style: titlebl(height),
                      ),
                      onPressed: _hasSpeech ? null : initSpeechState,
                    ),
                    FlatButton(
                      child: Text(
                        'Stress Test',
                        style: titlebl(height),
                      ),
                      onPressed: stressTest,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Start',
                      style: simple(height),
                    ),
                    onPressed: !_hasSpeech || speech.isListening
                        ? null
                        : startListening,
                  ),
                  FlatButton(
                    child: Text(
                      'Stop',
                      style: simple(height),
                    ),
                    onPressed: speech.isListening ? stopListening : null,
                  ),
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: simple(height),
                    ),
                    onPressed: speech.isListening ? cancelListening : null,
                  ),
                ],
              ),
              SizedBox(
                height: 0.0367 * height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButton(
                    onChanged: (selectedVal) => _switchLang(selectedVal),
                    value: _currentLocaleId,
                    items: _localeNames
                        .map(
                          (localeName) => DropdownMenuItem(
                            value: localeName.localeId,
                            child: Text(localeName.name),
                          ),
                        )
                        .toList(),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 0.0267 * height,
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Recognized Words',
                  style: simple(height),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).selectedRowColor,
                      child: Center(
                        child: Text(
                          lastWords,
                          textAlign: TextAlign.center,
                          style: simple(height),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 10,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 0.09259 * width,
                          height: 0.049 * height,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: .26,
                                  spreadRadius: level * 1.5,
                                  color: Colors.black.withOpacity(.05))
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.mic),
                            onPressed: () {
                              startListening();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Error Status',
                  style:
                      TextStyle(fontSize: 0.02696 * height, color: Colors.red),
                ),
              ),
              Center(
                child: Text(lastError),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.02696 * height),
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: speech.isListening
                ? Text(
                    "I'm listening...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : Text(
                    'Not listening',
                    style: TextStyle(fontWeight: FontWeight.bold, color: move),
                  ),
          ),
        ),
      ]),
    );
  }

  void stressTest() {
    if (_stressTest) {
      return;
    }
    _stressLoops = 0;
    _stressTest = true;
    print("Starting stress test...");
    startListening();
  }

  void changeStatusForStress(String status) {
    if (!_stressTest) {
      return;
    }
    if (speech.isListening) {
      stopListening();
    } else {
      if (_stressLoops >= 100) {
        _stressTest = false;
        print("Stress test complete.");
        return;
      }
      print("Stress loop: $_stressLoops");
      ++_stressLoops;
      startListening();
    }
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
    });
  }

  void soundLevelListener(double level) {
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    changeStatusForStress(status);
    setState(() {
      lastStatus = "$status";
    });
  }

  _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}
