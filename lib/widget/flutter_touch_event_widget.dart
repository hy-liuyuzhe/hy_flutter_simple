import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

class FlutterTouchEventWidget extends BaseStatefulWidget {
  @override
  State<BaseStatefulWidget> createState() => FlutterTouchEventState1();
}

class FlutterTouchEventState1 extends BaseStatefulState {
  var left = 0.0;
  var top = 0.0;

  @override
  Widget buildWidget(BuildContext context) {
    //return doubleContainer();
    // return behavior();
    return Stack(
      children: [
        Positioned(
          left: left,
          top: top,
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details){
              setState(() {
                left+=details.delta.dx;
                top+=details.delta.dy;
              });
            },
            onDoubleTap: ()=> Fluttertoast.showToast(msg: "onDoubleTap"),
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

  Listener behavior() {
    return Listener(
      //opaque将当前组件当前不透明的，即使没有子控件或空白处也能收到事件
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => print("Column"),
      child: Column(
        children: [
          //默认是deferToChild,子类和父类都可以收到事件
          AbsorbPointer(
            absorbing: true, //阻止孩子接受事件
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

  Listener doubleContainer() {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) => print("点击了"),
        child: Center(
          child: Stack(
            children: [
              Container(
                  color: Colors.blue,
                  width: 300.0,
                  height: 300.0,
                  child: Text("parent")),
              Container(width: 150.0, height: 150.0, child: Text("child"))
            ],
          ),
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
