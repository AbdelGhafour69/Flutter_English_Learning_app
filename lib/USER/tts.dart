import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';

class TextToSpeech extends StatefulWidget {
  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController textEditingController = TextEditingController();
    speak(String text) async {
      await flutterTts.setLanguage("en_US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            maxLines: 10,
            cursorColor: textcolor,
            controller: textEditingController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: textcolor,
                ),
              ),
              labelText: 'Enter your text here',
              labelStyle: simple(height),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(
            height: 0.06 * height,
          ),
          ButtonTheme(
            minWidth: 0.28127 * height,
            height: 0.06127 * height,
            child: FlatButton(
              color: pinkey,
              onPressed: () => speak(textEditingController.text),
              child: Text(
                "Read",
                style: title(height),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
