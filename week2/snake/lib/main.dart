import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {  //BuildContext context는 무엇을 의미할까
    return Scaffold(
      appBar: AppBar(
        title: Text("Snake Game"),
        centerTitle: true,
      ),
      body: Game(),
      backgroundColor: Colors.pink[100],
    );
  }
}

class Game extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GameState();
}

class GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 500,
          height: 500,
          margin: EdgeInsets.all(29),
          color: Colors.green[200], 
        ),
        Container(
          width: 500,
          height: 100,
          margin: EdgeInsets.all(29),
          color: Colors.amber[50], 
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 25,
                left: 10,
                width:60,
                height:50,
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: (){
                    /* left방향 state */
                    debugPrint("left");
                  },
                  child: Icon(Icons.keyboard_arrow_left),
                ),
              ),
              Positioned(
                top: 10,
                left: 80,
                width:60,
                height:37.5,
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: (){
                    /* up 방향 state */
                    debugPrint("up");
                  },
                  child: Icon(Icons.keyboard_arrow_up),
                ),
              ),
              Positioned(
                top: 25,
                left: 150,
                width:60,
                height:50,
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: (){
                    /* left방향 state */
                    debugPrint("right");
                  },
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 80,
                width:60,
                height:37.5,
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: (){
                    /* left방향 state */
                    debugPrint("down");
                  },
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}