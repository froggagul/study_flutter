# flutter 공부하기
공식 문서: [flutter](https://flutter.dev/docs)
## 1주차
1. 설치하기

  - 환경: window10
  - 설치 방법: git clone https://github.com/flutter/flutter.git
  - 설치 위치: C:\src
  - 폴더 이름: flutter 
2. 환경변수 설정하기
  - Path 변수에 C:\src\flutter\bin 설정
  - 일반 cmd 창에서 
    ```ps
    $ flutter doctor
    
    [√] Flutter (Channel master, v1.13.6-pre.38, on Microsoft Windows [Version 10.0.18362.535], locale ko-KR)
    [X] Android toolchain - develop for Android devices
    X Unable to locate Android SDK.
      Install Android Studio from: https://developer.android.com/studio/index.html
      On first launch it will assist you in installing the Android SDK components.
      (or visit https://flutter.dev/setup/#android-setup for detailed instructions).
      If the Android SDK has been installed to a custom location, set ANDROID_HOME to that location.
      You may also want to add it to your PATH environment variable.

    [!] Android Studio (not installed)
    [!] VS Code (version 1.41.1)
    X Flutter extension not installed; install from
      https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
    [!] Connected device
    ! No devices available

    ! Doctor found issues in 4 categories.
    ```
  - Dart SDK를 설치한다는데 이게 뭔지는 모르겠다..
  - Android SDK가 없다, 설치해주자 :sweat_smile:

3. android sdk 설치, 모바일 디바이스 연결
  - 핸드폰에서 개발자 옵션을 획득하자 [개발자 옵션 설정](https://extrememanual.net/8492)
  - usb debugging 허용
  - google usb driver가 이미 설치되어있었다.
  - 디바이스를 pc에 연결한 후 cmd에서
  ```ps
  flutter devices
  C:\Users\frogg>flutter devices
  1 connected device:

  LM Q925S • (중략) • android-arm64 • Android 8.1.0 (API 27)
  ```

4. Android Emulator 설정
  - vm acceleration 허용 [vm acceleration-window](https://developer.android.com/studio/run/emulator-acceleration#vm-windows)
  - avd manager에서 virtual machine create
  - 휴대폰 기종, android version 선택후 next
  - finish 눌러서 가상머신 저장
  - run button 눌러서 가상머신 실행

5. vs code 설정
  - flutter plugin 설치
  - ctrl+shift+p : Flutter:Run Flutter Doctor
  - 빠진 것이 없는지 체크 (android studio 등)
  - ctrl+shift+p : Flutter: New Project
  - The code for your app is in lib/main.dart

6. test drive
  - device는 가상 머신을 사용하던지, 직접 연결해서 physical device를 사용(내껀 LG)
  - 왼쪽 위에서 3번째 아이콘인 debug and run을 클릭, debug with dart&flutter 클릭, 기다리자
  - path에 한글이 포함되어 있으면 경로 인식에 문제가 생김
  - 인터넷 연결하자..

7. Hot reload
  - 코드 일부를 바꿔도 즉시 실행된다.

8. starter project

**step1**

1)메인에 hello world 출력하기 
>This example creates a Material app. Material is a visual design language that is standard on mobile and the web. Flutter offers a rich set of Material widgets.

>The main() method uses arrow (=>) notation. Use arrow notation for one-line functions or methods.

>The app extends StatelessWidget which makes the app itself a widget. In Flutter, almost everything is a widget, including alignment, padding, and layout.

>The Scaffold widget, from the Material library, provides a default app bar, title, and a body property that holds the widget tree for the home screen. The widget subtree can be quite complex.

>A widget’s main job is to provide a build() method that describes how to display the widget in terms of other, lower level widgets.

>The body for this example consists of a Center widget containing a Text child widget. The Center widget aligns its widget subtree to the center of the screen.

(해석 귀찮다..)

**step2**

1) external package 사용하기-pubsbec.yaml
2) 파일에 english_words:^3.1.0을 추가하면 아래같이 뜬다
```ps
[startup_namer] flutter packages get
Running "flutter pub get" in startup_namer... 2.7s
exit code 0
```
3) 다음 코드 추가: restart할때마다 글자가 바뀜
```
import 'package:english_words/english_words.dart';
    (중략)
final wordPair= WordPair.random();
    (중략)
child: Text(wordPair.asPascalCase),
```

**step3**

1) 모듈화시키는건가..?

>Stateless widgets are immutable, meaning that their properties can’t change—all values are final.

>Stateless widgets은 immutable하다, 즉 그들의 [properties](https://m.blog.naver.com/magnking/220966405605)를 수정할 수 없다.

>Stateful widgets maintain state that might change during the lifetime of the widget. Implementing a stateful widget requires at least two classes: 1) a StatefulWidget class that creates an instance of 2) a State class. The StatefulWidget class is, itself, immutable, but the State class persists over the lifetime of the widget.

>Stateful widgets은 lifetime에 변할 수 있는 state를 포함. 이들은 두가지 방향으로 구현 가능 1) State Class의 인스턴스를 만드는 class 이거나, 2) State Class 자기 자신 

>In this step, you’ll add a stateful widget, RandomWords, which creates its State class, RandomWordsState. You’ll then use RandomWords as a child inside the existing MyApp stateless widget.

>이 step에서는 stateful widget인 RandomWords를 만들거다. RandomWords는 자신의 State class인 RandomWordState를 만든다. 그리고 이를 MyApp stateless widget의 안에서 child로 사용할 것이다.

**step4**: 무한 스크롤 만들기

1)
>The itemBuilder callback is called once per suggested word pairing, and places each suggestion into a ListTile row. For even rows, the function adds a ListTile row for the word pairing. For odd rows, the function adds a Divider widget to visually separate the entries. Note that the divider might be difficult to see on smaller devices.

>item Builder callback은 word pairing마다 called. 0에서 시작해 짝수 row에는 ListTile Row, 홀수 row에는 Divider widget(ListTile을 구분해줌). Divider는 작은 기기에서는 잘 안보일 수 있음
```dart
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StartUp Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*context와 index 전달*/ (context, i) {
        if (i.isOdd) return Divider(); /*material divider return*/

        final index = i ~/ 2; /*divider아닌 row 생성, a~/b는 연산자는 (a / b).truncate().toInt()와 같다*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*더 단어를 생성해야 하는 경우 10개 추가*/
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
```

**step5** 선호 유무를 나타내는 버튼을 row에 추가
* set과 list의 차이
    * list은 우리가 알고있는 배열과 동일
    * set은 모든 요소가 서로 다르다, positional Access가 불가능(ordered의 유무는 implementation에 따라 달라짐)
        ```dart
        * bool Set.contains(Object value)
            //returns true if value is in the set
        ```
* ListTile
  ```dart
  * void Function() onTap
    //Called when the user taps this list tile.
    //Inoperative if [enabled] is false.
  * Widget trailing
    /*Title 다음에 표기하는 Widget.
    Typically an [Icon] widget.
    To show right-aligned metadata (assuming left-to-right reading order; left-aligned for right-to-left reading order), consider using a [Row] with [MainAxisAlign.baseline] alignment whose first item is [Expanded] and whose second child is the metadata text, instead of using the [trailing] property.
    */
  ```

**step 6** 새로운 screen으로 navigate
```dart
  void _pushSaved() {
      Navigator.of(context).push( //Navigator Stack에 push
      MaterialPageRoute<void>(   // Add 20 lines from here...
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(  //A collection of values, or "elements", that can be accessed sequentially.
          (WordPair pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile
          .divideTiles(
            // tile 사이에 1pixel border 추가. If color isn't specified the [ThemeData.dividerColor] of the context's [Theme] is used.
            context: context,
            tiles: tiles,
          )
          .toList();
        return Scaffold(         // Add 6 lines from here...
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
      },
    ),
    );
  
```

**step7** Change the UI using Themes
* ThemeData는 css의 비슷한 역할을 하는듯...? *뭐가 편해진건지 모르겠다..*