import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

///利用onPanUpdate来获取触摸的移动delta实现触摸全屏移动
class FlutterTouchEventWidget extends BaseStatefulWidget {
  @override
  State<BaseStatefulWidget> createState() => FlutterTouchEventState1();
}

class FlutterTouchEventState1 extends BaseStatefulState {
  var left = 0.0;
  var top = 0.0;

  @override
  Widget buildWidget(BuildContext context) {
    // return doubleContainer();
    // return behavior();
    return onPanUpdate();
  }

  Stack onPanUpdate() {
    return Stack(
      children: [
        Positioned(
          left: left,
          top: top,
          child: GestureDetector(
            // onVerticalDragUpdate: (DragUpdateDetails details){},设置这个会拦截下面vertical事件
            onPanUpdate: (DragUpdateDetails details) {
              printVerticalPercentage(details);
              setState(() {
                left += details.delta.dx;
                top += details.delta.dy;
              });
            },
            onDoubleTap: () => Fluttertoast.showToast(msg: "onDoubleTap"),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Center(child: Text("移动我")),
            ),
          ),
        )
      ],
    );
  }

  void printVerticalPercentage(DragUpdateDetails details) {
    var screenH = MediaQuery.of(context).size.height;
    final percentage = details.globalPosition.dy / screenH * 100;
    print('percentage= $percentage');
  }

  Listener behavior() {
    return Listener(
      //1.opaque将当前组件当前不透明的，即使没有子控件或空白处也能收到事件
      //2.默认是deferToChild,子类和父类都可以收到事件
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => print("Column"),
      child: Column(
        children: [
          AbsorbPointer(
            //3.阻止孩子接受事件
            child: Listener(
              onPointerDown: (_) => print("blue"),
              child: Container(
                  color: Colors.blue,
                  width: 300.0,
                  height: 300.0,
                  child: Text("blue")),
            ),
          )
        ],
      ),
    );
  }

  Widget doubleContainer() {
    return Center(
        child: Stack(
      children: <Widget>[
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300.0, 300.0)),
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 200.0)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          ),
          onPointerDown: (event) => print("down1"),
          behavior: HitTestBehavior.translucent, //4.放开此行注释后可以"点透";并且点击范围变成200*200，默认只有文字是点击区域
        )
      ],
    ));
  }
}

class FlutterTouchEventState extends BaseStatefulState {
  PointerEvent? _event;

  @override
  Widget buildWidget(BuildContext context) {
    return Listener(
      child: Center(
        child: Container(
          color: Colors.blue,
          width: 300.0,
          height: 150.0,
          child: Text(_event?.toString() ?? "",
              style: TextStyle(color: Colors.white)),
        ),
      ),
      onPointerDown: (event) => updatePointerDownEvent(event),
      onPointerMove: (event) => updatePointerDownEvent(event),
      onPointerCancel: (event) => updatePointerDownEvent(event),
      onPointerUp: (event) => updatePointerDownEvent(event),
      onPointerSignal: (event) => updatePointerDownEvent(event),
      onPointerHover: (event) => updatePointerDownEvent(event),
    );
  }

  updatePointerDownEvent(PointerEvent event) {
    setState(() {
      _event = event;
    });
  }
}
