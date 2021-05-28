import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

class BubbleSimpleWidget extends BaseStatefulWidget {
  @override
  State<BaseStatefulWidget> createState() => BubbleSimpleState();
}

class BubbleSimpleState extends BaseStatefulState {
  GlobalKey blueKey = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: TextButton(
                child: Text("ss"),
                key: blueKey,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        var size = (blueKey.currentContext!.findRenderObject()
                                as RenderBox)
                            .size;

                        return BubbleDialog(BubbleBuilder(
                            (getX(blueKey) + size.width / 2).toDouble(),
                            (getY(blueKey) + size.height - getStatusBarHeight())
                                .toDouble(),
                            text: "simple1"));
                      });
                }),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 2,
              child: Container(
                color: Colors.green,
                child: TextButton(
                  child: Text("FlatButton"),
                  onPressed: () => print("FlatButton Click"),
                ),
              ))
        ],
      ),
    );
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
    print("x= ${builder.x}");
    var x = builder.x;
    if (builder.arrowLocation == ArrowLocation.TOP) {
      x = 0.0;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            alignment: Alignment.centerLeft,
            width: builder.bubbleWidth,
            height: builder.bubbleHeight,
            color: Colors.purple,
            child: CustomPaint(
              size: Size(builder.bubbleWidth, builder.bubbleHeight),
              painter: BubblePainter(builder),
            ),
            margin: EdgeInsets.only(left: x, top: builder.y),
          ),
        ),
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  Rect? mRect;
  final path = Path();
  final mPaint = Paint()..color = Colors.green;
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

    setUpPath(mRect!);
    canvas.drawPath(path, mPaint);
  }

  void setUpPath(Rect rect) {
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
}

class BubbleBuilder {
  //气泡矩形尺寸
  final double bubbleWidth;
  final double bubbleHeight;

  //气泡指示器坐标
  final double x;
  final double y;

  final arrowWidth = 10.0;
  final arrowHeight = 10.0;

  final arrowLocation;
  final String? text;
  final radius;
  final arrowPosition = 54.0;

  BubbleBuilder(this.x, this.y,
      {this.arrowLocation = ArrowLocation.TOP,
      this.text,
      this.bubbleWidth = 120.0,
      this.bubbleHeight = 60.0})
      : radius = 4.toDouble();
}

enum ArrowLocation {
  LEFT,
  RIGHT,
  TOP,
  BOTTOM,
}

// class BubblePinter
