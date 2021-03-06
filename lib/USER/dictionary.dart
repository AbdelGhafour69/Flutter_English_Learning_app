import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quiz/Colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "3754db1d98d21240ea553b18562e05c892897b08";

  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    Response response = await get(_url + _controller.text.trim(),
        headers: {"Authorization": "Token " + _token});
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 0.0367 * height,
            child: TextFormField(
              onChanged: (String text) {
                if (_debounce?.isActive ?? false) _debounce.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  _search();
                });
              },
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search for a word",
                contentPadding: const EdgeInsets.only(left: 24.0),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 0.4044 * height,
            margin: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: _stream,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text(
                      "Enter a search word",
                      style: simple(height),
                    ),
                  );
                }
                if (snapshot.data == "waiting") {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data["definitions"] == null
                      ? 0
                      : snapshot.data["definitions"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListBody(
                      children: <Widget>[
                        Container(
                          color: Colors.grey[300],
                          child: ListTile(
                            leading: snapshot.data["definitions"][index]
                                        ["image_url"] ==
                                    null
                                ? null
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data["definitions"][index]
                                            ["image_url"]),
                                  ),
                            title: Text(_controller.text.trim() +
                                "(" +
                                snapshot.data["definitions"][index]["type"] +
                                ")"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data["definitions"][index]
                              ["definition"]),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
