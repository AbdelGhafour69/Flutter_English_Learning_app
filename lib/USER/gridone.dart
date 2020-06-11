import 'package:flutter/material.dart';

class GridOne extends StatefulWidget {
  @override
  _GridOneState createState() => _GridOneState();
}

class _GridOneState extends State<GridOne> {
  List<String> sawsan = ['blue','red','green','yellow','pink','purple','Brown','Gray','Orange','Cyan','teal','lime'];
  List<Color> sawsa2 = [Colors.blue,Colors.red,Colors.green,Colors.yellow,Colors.pink,Colors.purple,Colors.brown,Colors.grey,Colors.orange,Colors.cyan,Colors.teal,Colors.lime];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(sawsan.length, (index){
          return new Card(
            elevation: 10.0,
            margin: EdgeInsets.all(5.0),
            shape: new RoundedRectangleBorder(
              borderRadius:new BorderRadius.circular(20.0)
            ),
            child: Align(
              alignment: Alignment.center,
                          child: new Text(sawsan[index],
              style: TextStyle(
                fontSize: 0.0294*height,
                color:sawsa2[index],
              ),
              ),
            ),
          );
        })
        ),
    );
  }
}