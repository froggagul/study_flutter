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

//game layout 부분
class Game extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GameState();
}

class GameState extends State<Game> {
  var positions=[[0,0],[2,3],[11,19]];

  Widget button(){
    return(
      Container(
        /**
         * button 부분
         */
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
            Positioned(
              right: 20,
              top: 25,
              width: 100,
              height: 50,
              child: Center(
                child: Text(
                  "level "+positions.length.toString(),
                  style: TextStyle(
                    // fontFamily: 뭐로하지
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          /**
           * snake가 돌아다닐 공간
           */
          width: 300,
          height: 500,
          margin: EdgeInsets.all(29),
          color: Colors.green[200],
          child: snake(positions: positions),
        ),
        button(),
      ],
    );
  }
}

Widget snake({List positions}) {
  List<AnimatedPositioned> snakePositioned = List();
  positions.forEach((item){
    snakePositioned.add(
      AnimatedPositioned(
        left: item[0].toDouble()*25,
        top: item[1].toDouble()*25,
        child:Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );
  });

  return Stack(
    children: snakePositioned
  );
}