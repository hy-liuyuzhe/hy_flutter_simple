import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

class AnimationComposeWidget extends BaseStatefulWidget {
  @override
  State<BaseStatefulWidget> createState() => AnimationComposeState();
}

class AnimationComposeState extends BaseStatefulState
    with SingleTickerProviderStateMixin {
  late Animation<num> circleTween;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);

    circleTween = Tween(begin: 0.0, end: 200).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.repeat();

    // reverse_forward();
  }

  ///无限循环， 正向和反向动画
  void reverse_forward() {
    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      child: Center(
        child: RotationTransition(
          turns: controller,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.green,
            child: CustomPaint(
              painter: CirclePainter(circleTween),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    controller.dispose();
  }
}

class CirclePainter extends CustomPainter {
  Animation<num> circleTween;
  var circlePaint = Paint();

  CirclePainter(this.circleTween);

  @override
  void paint(Canvas canvas, Size size) {
    circlePaint
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(100, 100), 1.5 * circleTween.value, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
