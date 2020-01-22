# layout에 관해 내가 모르는 것들
Q. material app vs non material app
    
A. material library의 사용 유무에 따라 달라진다. 해당 library는 [material design](https://ko.wikipedia.org/wiki/%EB%A8%B8%ED%8B%B0%EB%A6%AC%EC%96%BC_%EB%94%94%EC%9E%90%EC%9D%B8) 규정을 따른다. [스택 오버플로우 답변](https://stackoverflow.com/questions/55044126/what-is-the-difference-between-non-material-apps-and-material-apps)

Q. 표를 만드는 법

A. table widget이란 것이 있었다..! 단, 이 경우는 scroll이 필요 없는 경우 추천된다.

* [layout tutorial](https://flutter.dev/docs/development/ui/layout/tutorial) 따라하기
* layout을 보자마자 해야할 생각

    row와 column 규명
    layout이 grid를 포함하는가?
    overlapping element가 존재하는가?
    UI에 tab이 필요한가?
    alignment, padding, 혹은 border가 필요한 구역을 파악한다.
    퍼블리싱에도 도움이 될 듯 하다

# animation에 관해 내가 모르는 것들
* [공식문서](https://flutter.dev/docs/development/ui/animations/overview)
* 개요
    * flutter에서 animation system은 type이 규명된 Animation 객체를 바탕으로 한다. Widget은 각 자신의 build function에 animation들을 바로 통합할 수 있다. 현재 값을 읽고 state 변화에 연결시키는 것의 방법 등으로 말이다. or they can use the animations as the basis of more elaborate animations that they pass along to other widgets.

