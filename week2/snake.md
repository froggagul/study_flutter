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
  * 
    1. 
    2. 
    3. 