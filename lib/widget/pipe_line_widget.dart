import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'base_stateless_widget.dart';

class PipeLineWidget extends BaseStatelessWidget {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(color: Colors.pink[200], child: App());
  }
}

final size = ui.window.physicalSize / ui.window.devicePixelRatio;

const frequency = Duration(milliseconds: 50);

int C = 1;

const numCircles = 299;

final red = Paint()..color = Colors.red;
final redStroke = Paint()
  ..color = Colors.red
  ..style = PaintingStyle.stroke;

final black = Paint()..color = Colors.black;

class Circle {
  final Offset? offset;
  final double radius;
  final Color color;

  const Circle({this.offset, this.color = Colors.white, this.radius = 10});
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late Timer timer;

  List<Circle> circles = <Circle>[];

  Offset force = Offset(1, 1);

  HSLColor hslColor = HSLColor.fromColor(Colors.pink.shade100);

  final StreamController<List<Circle>> _circleStreamer =
      StreamController<List<Circle>>.broadcast();

  Stream<List<Circle>> get _circle$ => _circleStreamer.stream;

  Color get color => hslColor.toColor();

  double hFactor = size.height / 30;
  double wFactor = size.width / 10;

  Offset get randomPoint => size.topLeft(Offset.zero) * Random().nextDouble();

  @override
  void initState() {
    timer = Timer.periodic(
      frequency,
      (t) {
        if (circles.isEmpty)
          _circleStreamer.add(
            circles
              ..add(
                Circle(
                  offset: randomPoint,
                  radius: 1,
                  color: hslColor.toColor(),
                ),
              ),
          );
        int count = 0;
        while (count < 29) {
          final p = // newPoint
              size.bottomRight(Offset.zero) * 0.5 +
                  (size.bottomRight(Offset.zero) * 0.1).scale(
                    cos(C / 59),
                    cos(C / 99),
                  );

          hslColor = hslColor
              .withHue((hslColor.hue + 0.2) % 360)
              .withLightness(min(1.0, .1 + sin(C / 49).abs() / 10));

          double r = max(10, (wFactor + (hFactor * sin(C / 79))));

          _circleStreamer
              .add(circles..add(Circle(offset: p, radius: r, color: color)));

          count++;
          C++;
        }

        if (circles.length > numCircles)
          circles = circles
              .getRange(circles.length - numCircles, circles.length)
              .toList();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _circleStreamer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          StreamBuilder<List<Circle>>(
            initialData: [],
            stream: _circle$,
            builder: (context, snapshot) => RepaintBoundary(
                child: CustomPaint(
              size: size,
              painter: Painter(circles: snapshot.data),
            )),
          ),
        ],
      );
}

class Painter extends CustomPainter {
  List<Circle>? circles;

  Painter({required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < circles!.length - 1; i++) {
      final c = circles![i];
      final hsl = HSLColor.fromColor(c.color);
      final paint = Paint()
        ..color = c.color
        ..shader = ui.Gradient.linear(
          c.offset!,
          c.offset! + Offset(0, c.radius),
          [
            hsl.withLightness(max(0, min(1, hsl.lightness + 0.7))).toColor(),
            c.color,
          ],
        );

      /* too heavy for mobile web rendering?
       final light = Paint()
        ..color = c.color
        ..shader = ui.Gradient.radial(
          c.offset - Offset(0, c.radius),
          c.radius,
          [
            Color(0x53ffffff),
            Colors.transparent,
          ],
        );*/
      canvas
        ..drawCircle(c.offset!, c.radius, paint)
        /*..drawCircle(c.offset, c.radius, light)*/
        ..rotate(pi / 10800);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
