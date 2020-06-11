import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'gridone.dart' as gridone;
import 'gridtwo.dart' as gridtwo;
import 'gridthree.dart' as gridthree;
import 'audio.dart' as audio;
import 'tts.dart' as tts;
import 'dictionary.dart' as dic;
import 'package:flutter_icons/flutter_icons.dart';

class Quiztab extends StatefulWidget {
  @override
  _QuiztabState createState() => _QuiztabState();
}

class _QuiztabState extends State<Quiztab> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
            "Learn english with media",
            style: TextStyle(color: Colors.redAccent),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: pinkey,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          bottom: new TabBar(
            unselectedLabelColor: Colors.redAccent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.orangeAccent],
              ),
              borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
            ),
            controller: controller,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(MaterialIcons.color_lens),
              ),
              new Tab(
                icon: new Icon(Icons.image),
              ),
              new Tab(
                icon: new Icon(Icons.video_label),
              ),
              new Tab(
                icon: new Icon(Icons.mic),
              ),
              new Tab(
                icon: new Icon(Icons.hearing),
              ),
              new Tab(
                icon: new Icon(Ionicons.ios_search),
              ),
            ],
          )),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          new gridone.GridOne(),
          new gridtwo.GridTwo(),
          new gridthree.VideoApp(),
          new audio.SpeechRec(),
          new tts.TextToSpeech(),
          new dic.MyHomePage(),
        ],
      ),
    );
  }
}
