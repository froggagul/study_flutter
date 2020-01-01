### widget은 무엇인가? :confused: 
[Introduction to widgets](https://flutter.dev/docs/development/ui/widgets-intro)중 이해안되는 것만 번역함

Flutter widgets은 react에서 영향받은 modern framework를 사용하여 만들어졌다. 핵심 아이디어는 UI를 widget에서 만드는 것이다. Widget은 현재 configuration 및 state에서 view를 나타낸다(&ap;설명한다). Widget의 state가 변하면, 그것의 description을 rebuild. rendering tree에서 한 상태에서 다음 상태로 전환하는 데 필요한 최소 변경 사항을 결정하기 위해 이전의 description과의 차이를 파악한다.

### Hello world
runApp function은 주어진 widget을 widget tree의 root로 만든다. 아래 예시에서, widget tree에는 두가지 widget이 존재. Center widget과 그것의 child인 Text위젯. root widget은 스크린을 커버하게 만든다.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
```

### 기본 widget

#### Text
run of styled text를 생성할 수 있게 해준다.
#### Row, Column
row 방향과 column 방향으로 flexible layout을 생성할 수 있게 해준다. 기본적으로 웹에서의 flexbox layout model에서 따왔다.
#### Stack
Instead of being linearly oriented (either horizontally or vertically), a Stack widget lets you place widgets on top of each other in paint order. You can then use the Positioned widget on children of a Stack to position them relative to the top, right, bottom, or left edge of the stack. Stack은 are based on the web’s **absolute** positioning layout model. (대충 absolute란 소리)
#### Container
The Container widget은 직사각형 visual element를 만들도록 해준다. A container can be decorated with a BoxDecoration, such as a background, a border, or a shadow. A Container can also have margins, padding, and constraints applied to its size. matrix를 사용해 3d로 사용할 수 있다.

### Using Material Components