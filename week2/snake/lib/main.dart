import 'package:flutter/material.dart';
import 'dart:async';

enum CurrentGame {
  initial,
  onGame,
  fail
}
enum SnakeState {
  up,
  down,
  left,
  right
}

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
  List<List<int>> positions=[[0,0],[0,1],[0,2]];
  var currentGame=CurrentGame.initial;
  var snakeState=SnakeState.down;
  double maxWidth= 325;
  double maxHeight= 325;


  /// snakeState에 따라 뱀 이동
  void moveSnake(){
    List<List<int>> temp=[];
    var length = positions.length;
    for (var i = 1; i < length; i++) {
      temp.add(positions[i]);
    }
    var lastHead=positions[length-1];

    switch (snakeState) {
      case SnakeState.down:
        temp.add([lastHead[0],lastHead[1]+1]);
        break;
      case SnakeState.up:
        temp.add([lastHead[0],lastHead[1]-1]);
        break;
      case SnakeState.left:
        temp.add([lastHead[0]-1,lastHead[1]]);
        break;
      case SnakeState.right:
        temp.add([lastHead[0]+1,lastHead[1]]);
        break;
      default:
    }

    setState(() {
      positions=temp;
    });
  }

  /// 뱀이 자신과 부딫혔는지, 맵 밖으로 나갔는지 체크, 
  /// 둘중 해당되는 사항이 있으면 true 반환
  bool checkSnake(){
    var length = positions.length;
    var head = positions[length-1];
    
    if (head[0]<0 || head[1]<0) return true;
    if (head[0]>=maxWidth/25 || head[1]>=maxHeight/25) return true;
    for (var i = 0; i < length-1; i++) {
      if (positions[i][0]==head[0] && positions[i][1]==head[1]) return true;
    }
    
    return false;
  }

  void startGame(){
    setState(() {
      positions=[[0,0],[0,1],[0,2]];
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
        // 사과 생성
        if (checkSnake()) {
          // 맵 밖으로 나가거나 자신과 충돌시
          setState(() {
            currentGame=CurrentGame.fail;
          });
          timer.cancel();
        } else {
          moveSnake();
        }
        
      });
  }

  Widget buttonBar(){
    return(
      Column(
        children: <Widget>[
          Container(
            /**
             * button 부분
             */
            width: 500,
            height: 100,
            margin: EdgeInsets.all(9),
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
                      debugPrint("left");
                      setState(() {
                        snakeState=SnakeState.left;
                      });
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
                      debugPrint("up");
                      setState(() {
                        snakeState=SnakeState.up;
                      });
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
                      debugPrint("right");
                      setState(() {
                        snakeState=SnakeState.right;
                      });
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
                      debugPrint("down");
                      setState(() {
                        snakeState=SnakeState.down;
                      });
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
                ),
              ],
            )
          ),
          Container(
            width: 500,
            height: 75,
            color: Colors.amber[50],
            margin: const EdgeInsets.only(top: 100),
            child: FlatButton(
              color: Colors.red[50],
              onPressed: (){
                debugPrint("start/restart");
                setState(() {
                  if (currentGame==CurrentGame.onGame) {
                    currentGame=CurrentGame.initial;
                    // 이후 못누르게 바꾸기
                    // return;
                  } else{
                    currentGame=CurrentGame.onGame;
                    startGame();
                  }
                });
              },
              child: startText(),
            ),
          )
        ],
      )
    );
  }

  Widget startText() {
    if (currentGame == CurrentGame.initial) {
      return Text(
                "start",
                style: TextStyle(
                  fontSize: 20
                ),
              );
    } else if (currentGame == CurrentGame.fail) {
      return Text(
                "restart",
                style: TextStyle(
                  fontSize: 20
                ),
              );
    } else {
      return Text(
                "gaming..",
                style: TextStyle(
                  fontSize: 20
                ),
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          /**
           * snake가 돌아다닐 공간
           */
          width: maxWidth,
          height: maxHeight,
          margin: EdgeInsets.all(10),
          color: Colors.green[200],
          child: snake(positions: positions),
        ),
        buttonBar(),
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