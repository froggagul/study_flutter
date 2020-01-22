## 2주차
- snake game을 만들기로 함
- layout -> logic -> component

* layout
    * [flutter docs](https://flutter.dev/docs/development/ui/layout)대로 한번 만들어보자
    * layout에 대한 이해*느낌대로 하는 번역.. 오타 주의*
    이제부터 당신은 간단한 widget들로 복잡한 widget을 구성해 layout을 구성할겁니다.
    예를 들어, 아래 3개의 icon으로 이루어진 layout을 눈으로 분석해봅시다
    <p>
      <img src="icons_layout.png">
    </p>
    위 layout을 widget tree로 나타내면 다음과 같습니다.
    <p>
      <img src="widgetTree.png">
    </p>
* container widget
    * 여기서 [container widget](https://api.flutter.dev/flutter/widgets/Container-class.html)은 child widget을 customize할 수 있게 도와줍니다. 
* 구성은
  * 아래 뱀이 움직일 수 있는 widget
  * 그 위에 터치를 인식할 수 있는 widget을 놓으려고 한다. gesture를 인식하면 아래 있는 widget의 state가 바뀌어 뱀이 움직이는 방향이 바뀐다.

* logic
  * 뱀은 gesture에 의해 움직이게 하려고 한다. flutter에서 gesture에 의해 발생하는 event를 찾아보았다.
  * 뱀의 좌표를 state로 한 뒤 뱀을 직접 구현 or table 위에 구현: table로 구현하면 rendering양이 많아 지므로 뱀을 직접 구현한다.

1. 기본 틀 잡기(뱀이 움직이는 구역, 버튼 구역)
2. 뱀 기본 layout 구현하기
  - parameter를 넘겨줄때, 생긴오류

    Q. type 'int' is not a subtype of type 'double' of 'value'

    A. int타입을 double을 매개변수로 받는 함수에 넘겨줘서 생긴 오류, type 변환 함수를 적용하여 해결 [관련 링크](https://github.com/dart-lang/googleapis/issues/11)

    Q. 반응형 웹 제작하려면 써야하는 것
    
    A. MediaQuery.of(context)를 써야 한다.
    [링크](https://medium.com/flutter-community/a-guide-to-using-screensize-in-flutter-a-more-readable-approach-901e82556195)

3. logic 제작

    Q. 처음에 게임 시작하는 방법

    A. 일단은 게임 시작 버튼 만들기(gesture만으로도 작동하게 만들어보고 싶다.)

    Q. 뱀이 이동하는 방법, 일정 시간마다 setState를 시켜줘야 한다. timeduration을 주는 방법은?
  
    A. flutter의 Timer class를 사용하자, 그 중 periodic을 사용하면, 반복적인 timer를 사용할 수 있다. Timer.periodic의 constructor는 다음과 같다.
    ```dart
    Timer.periodic(
      Duration duration,
      void callback(
      Timer timer
      )
    )
    ``` 

    - error
    
    Q. Unhandled Exception: type 'List<dynamic>' is not a subtype of type 'List<List<int>

    A. 처음 선언할때 type을 맞춰놓자
    ```dart
      List<List<int>> temp = [];
    ```

    - ~/는 int형을 반환한다. / 는 double형을 반환한다.
4. event 연결
##### reference
* [전체적인 틀을 여기서 잡았다](https://github.com/sur950/Flutter_SnakeGame_FlutterWeb/blob/master/snake_game/lib/game.dart)