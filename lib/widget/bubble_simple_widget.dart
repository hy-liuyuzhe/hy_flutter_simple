import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

/// 气泡指示器
/// TextButton.icon 当里面的文字越界了，无法使用expand包裹来解决；只能拆开单独使用text
class BubbleSimpleWidget extends BaseStatefulWidget {
  @override
  State<BaseStatefulWidget> createState() => BubbleSimpleState();
}

class BubbleSimpleState extends BaseStatefulState {
  GlobalKey blueKey = GlobalKey();
  GlobalKey redKey = GlobalKey();
  GlobalKey greenKey = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [blueButton(context), greenButton(context), redButton()],
      ),
    );
  }

  Positioned greenButton(BuildContext context) {
    return Positioned(
        left: MediaQuery.of(context).size.width / 2,
        child: Container(
          key: greenKey,
          color: Colors.green,
          child: TextButton(
            child: Text("simple2"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    var size = (greenKey.currentContext!.findRenderObject()
                            as RenderBox)
                        .size;

                    return BubbleDialog(BubbleBuilder(
                        (getX(greenKey) + size.width / 2).toDouble(),
                        (getY(greenKey) + size.height - getStatusBarHeight())
                            .toDouble(),
                        text: "simple2"));
                  });
            },
          ),
        ));
  }

  Container blueButton(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: TextButton(
          child: Text("simple1"),
          key: blueKey,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  var size =
                      (blueKey.currentContext!.findRenderObject() as RenderBox)
                          .size;

                  return BubbleDialog(BubbleBuilder(
                      (getX(blueKey) + size.width / 2).toDouble(),
                      (getY(blueKey) + size.height - getStatusBarHeight())
                          .toDouble(),
                      text: "simple1"));
                });
          }),
    );
  }

  redButton() {
    var screen = MediaQuery.of(context).size;
    var buttonTheme = Theme.of(context).buttonTheme;
    return Positioned(
        left: screen.width / 2 - buttonTheme.minWidth / 2,
        top: (screen.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top) /
            2,
        child: Container(
            key: redKey,
            color: Colors.red,
            width: Theme.of(context).buttonTheme.minWidth,
            height: Theme.of(context).buttonTheme.height,
            child: TextButton(
              child: Text("simple3"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      var size = (redKey.currentContext!.findRenderObject()
                              as RenderBox)
                          .size;

                      return BubbleDialog(BubbleBuilder(
                          (getX(redKey) + size.width / 2).toDouble(),
                          (getY(redKey) -
                                  BubbleBuilder.BUBBLE_HEIGHT -
                                  getStatusBarHeight())
                              .toDouble(),
                          text: "simple2",
                          arrowLocation: ArrowLocation.BOTTOM));
                    });
              },
            )));
  }
}

///这是控件左边距离屏幕的尺寸
double getX(GlobalKey key) {
  RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
  return box.localToGlobal(Offset.zero).dx;
}

///这是控件顶部距离屏幕的尺寸
double getY(GlobalKey key) {
  RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
  return box.localToGlobal(Offset.zero).dy;
}

///获取状态栏高度
double getStatusBarHeight() {
  return MediaQueryData.fromWindow(WidgetsBinding.instance!.window).padding.top;
}

class BubbleDialog extends StatelessWidget {
  final BubbleBuilder builder;

  BubbleDialog(this.builder);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var x = builder.x;
    if (top_b()) {
      x = builder.x - builder.bubbleWidth / 2;
    }

    if (x < 0) {
      //目标靠左边屏幕
      x = 0;
    } else if ((x + builder.bubbleWidth) > size.width) {
      //目标过于靠右边
      x = size.width - builder.bubbleWidth;
    }

    builder.arrowPosition = calculateArrowPosition(x);

    var margin = EdgeInsets.zero;
    if (builder.arrowLocation == ArrowLocation.TOP) {
      margin = EdgeInsets.only(top: builder.arrowHeight, left: 5, right: 5);
    } else if (builder.arrowLocation == ArrowLocation.BOTTOM) {
      margin = EdgeInsets.only(left: 5, right: 5, bottom: builder.arrowHeight);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          alignment: Alignment.centerLeft,
          width: builder.bubbleWidth,
          height: builder.bubbleHeight,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(builder.bubbleWidth, builder.bubbleHeight),
                painter: BubblePainter(builder),
              ),
              Center(
                child: Container(
                  color: Colors.green.shade50,
                  margin: margin,
                  width: builder.bubbleWidth,
                  height: builder.bubbleHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.send),
                      SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          builder.text.toString(),
                          style: TextStyle(color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          // color: Colors.purple,
          margin: EdgeInsets.only(left: x, top: builder.y),
        ),
      ),
    );
  }

  bool top_b() {
    return builder.arrowLocation == ArrowLocation.TOP ||
        builder.arrowLocation == ArrowLocation.BOTTOM;
  }

  /// position求的是箭头左顶点x相对于气泡left的距离)
  double calculateArrowPosition(double x) {
    double result = 0;
    if (top_b()) {
      result = builder.x - x - builder.arrowWidth / 2;
    }

    print("result= $result");
    print("builder= " + builder.toString());

    return result;
  }
}

class BubblePainter extends CustomPainter {
  Rect? mRect;
  final path = Path();
  final mPaint = Paint()..color = Colors.pink;
  final BubbleBuilder builder;

  BubblePainter(this.builder);

  @override
  void paint(Canvas canvas, Size size) {
    setup(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void setup(Canvas canvas, Size size) {
    mRect ??=
        new Rect.fromLTRB(0, 0, builder.bubbleWidth, builder.bubbleHeight);
    switch (builder.arrowLocation) {
      case ArrowLocation.TOP:
        setUpTopPath(mRect!);
        break;
      case ArrowLocation.BOTTOM:
        setUpBottomPath(mRect!);
        break;
    }

    canvas.drawPath(path, mPaint);
  }

  void setUpTopPath(Rect rect) {
    var arrowPosition = builder.arrowPosition;
    path.moveTo(rect.left, rect.top + builder.arrowHeight);
    path.lineTo(rect.left + arrowPosition, rect.top + builder.arrowHeight);
    path.lineTo(rect.left + builder.arrowWidth / 2 + arrowPosition, rect.top);
    path.lineTo(rect.left + builder.arrowWidth + arrowPosition,
        rect.top + builder.arrowHeight);

    path.addRRect(RRect.fromLTRBR(rect.left, rect.top + builder.arrowHeight,
        rect.right, rect.bottom, Radius.circular(builder.radius)));
    path.close();
  }

  void setUpBottomPath(Rect rect) {
    var arrowPosition = builder.arrowPosition;
    path.moveTo(rect.left + arrowPosition + builder.arrowWidth,
        rect.bottom - builder.arrowHeight);
    path.lineTo(rect.left + arrowPosition + builder.arrowWidth,
        rect.bottom - builder.arrowHeight);
    path.lineTo(
        rect.left + arrowPosition + builder.arrowWidth / 2, rect.bottom);
    path.lineTo(rect.left + arrowPosition, rect.bottom - builder.arrowHeight);

    path.addRRect(RRect.fromLTRBR(rect.left, rect.top, rect.right,
        rect.bottom - builder.arrowHeight, Radius.circular(builder.radius)));
    path.close();
  }
}

class BubbleBuilder {
  static const BUBBLE_WIDTH = 120.0;
  static const BUBBLE_HEIGHT = 60.0;

  //气泡矩形尺寸
  final double bubbleWidth;
  final double bubbleHeight;

  //气泡指示器坐标
  final double x;
  final double y;

  final arrowWidth = 10.0;
  final arrowHeight = 10.0;

  final arrowLocation;
  final radius;
  var arrowPosition = 54.0;
  String? text;

  BubbleBuilder(this.x, this.y,
      {this.arrowLocation = ArrowLocation.TOP,
      this.text,
      this.bubbleWidth = BUBBLE_WIDTH,
      this.bubbleHeight = BUBBLE_HEIGHT})
      : radius = 4.toDouble() {
    text ??= "simple";
  }
}

enum ArrowLocation {
  LEFT,
  RIGHT,
  TOP,
  BOTTOM,
}

/// 被点击的目标偏离左边还是右边或是正好
enum WidgetLocation { left, center, right }
