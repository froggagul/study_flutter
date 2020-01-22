import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
      backgroundColor: Color.fromRGBO(255,204,209,1),
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
  List<int> prePositions=[0,0]; //전 단계에서 뱀의 꼬리 좌표
  List<int> pointPositions=[5,5];
  var currentGame=CurrentGame.initial;
  var snakeState=SnakeState.down;

  double maxWidth= 200;
  double maxHeight= 200;
  
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }
  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  @override
  Widget build(BuildContext context) {
    maxWidth= screenWidth(context, dividedBy: 1.25)~/25*25.toDouble();
    maxHeight= screenHeight(context, dividedBy: 2)~/25*25.toDouble();

    return Column(
      children: <Widget>[
        Container(
          /**
           * snake가 돌아다닐 공간
           */
          width: maxWidth,
          height: maxHeight,
          margin: EdgeInsets.only(top:10),
          color: Colors.green[200],
          child: snake(positions: positions, pointPositions:pointPositions),
        ),
        buttonBar(context),
      ],
    );
  }

  /// 전달받은 좌표가 뱀이 있는 좌표가 아닌지 판단
  bool isValidPoint(int x, int y) {
    int length = positions.length;
    for (var i = 0; i < length; i++) {
      if (positions[i][0]==x && positions[i][1]==y) {
        return true;
      }
    }
    return false;
  }
  /// [x,y] 형태의 먹이 좌표 반환
  List<int> genPoints() {
    int maxX=maxWidth~/25;
    int maxY=maxHeight~/25;
    int x = Random().nextInt(maxX);
    int y = Random().nextInt(maxY);
    while (isValidPoint(x, y)) {
      x = Random().nextInt(maxX);
      y = Random().nextInt(maxY);
    }
    return [x,y];
  }

  /// snakeState에 따라 뱀 이동
  void moveSnake(){
    List<List<int>> temp=[];
    var length = positions.length;
    prePositions=positions[0]; //꼬리 위치 기억
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
  /// 뱀의 먹이를 먹었을때 뱀의 행동 정의, 뱀을 전 state로 미룬뒤, 현재 먹이 위치 추가
  void addSnake(){
    List<List<int>> temp=[];
    var length = positions.length;
    temp.add(prePositions);
    for (var i = 0; i < length-1; i++) {
      temp.add(positions[i]);
    }
    temp.add(pointPositions);
    setState(() {
      positions=temp;
      pointPositions=genPoints();
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
  /// 뱀의 머리와 뱀의 먹이가 같은 좌표에 있는지 판단, 같으면 true 반환
  bool checkPoint(){
    var length = positions.length;
    var head = positions[length-1];
    if(head[0] == pointPositions[0] && head[1] == pointPositions[1]) return true;
    return false;
  }
  ///초기 위치로 뱀 이동
  void resetGame(){
    setState(() {
      currentGame=CurrentGame.initial;
      snakeState=SnakeState.down;
      positions=[[0,0],[0,1],[0,2]];
      pointPositions=genPoints();
    });
  }
  ///game reset후 game 시작
  void startGame(){
    resetGame();
    setState(() {
      currentGame=CurrentGame.onGame;
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
        if (checkSnake()) {
          // 맵 밖으로 나가거나 자신과 충돌시
          setState(() {
            currentGame=CurrentGame.fail;
          });
          timer.cancel();
        } else {
          if (checkPoint()) {
            addSnake();
          } else{
            moveSnake();
          }
        }
        
      });
  }

  Widget buttonBar(BuildContext context){
    double height = screenHeight(context, dividedBy:5);
    double width = screenWidth(context, dividedBy: 1);
    return(
      Column(
        children: <Widget>[
          Container(
            /**
             * button 부분
             */
            width: width,
            height: height,
            margin: EdgeInsets.all(9),
            color: Colors.amber[50], 
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: height/4,
                  left: 10,
                  width:60,
                  height:height/2,
                  child: FlatButton(
                    color: Colors.blue[100],
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
                  top: height/8,
                  left: 80,
                  width:60,
                  height:height/3,
                  child: FlatButton(
                    color: Colors.blue[100],
                    onPressed: (){
                      debugPrint(maxWidth.toString());
                      setState(() {
                        snakeState=SnakeState.up;
                      });
                    },
                    child: Icon(Icons.keyboard_arrow_up),
                  ),
                ),
                Positioned(
                  top: height/4,
                  left: 150,
                  width:60,
                  height:height/2,
                  child: FlatButton(
                    color: Colors.blue[100],
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
                  bottom: height/8,
                  left: 80,
                  width:60,
                  height:height/3,
                  child: FlatButton(
                    color: Colors.blue[100],
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
                  right: 10,
                  top: 25,
                  width: width/3,
                  height: height/2,
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
            width: width,
            height: height/2,
            color: Colors.amber[50],
            child: FlatButton(
              color: Colors.red[50],
              onPressed: (){
                debugPrint("start/reset");
                setState(() {
                  if (currentGame==CurrentGame.onGame) {
                    return;
                  } else if(currentGame==CurrentGame.initial) {
                    currentGame=CurrentGame.onGame;
                    startGame();
                  }  else {
                    resetGame();
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
                "reset",
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



}

Widget snake({List<List<int>> positions, List<int> pointPositions}) {
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
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      ),
    );
  });
  snakePositioned.add(
    AnimatedPositioned(
      left: pointPositions[0].toDouble()*25,
      top: pointPositions[1].toDouble()*25,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    ),
  );

  return Stack(
    children: snakePositioned, 
  );
}