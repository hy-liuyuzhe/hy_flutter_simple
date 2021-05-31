
import 'package:flutter/material.dart';

class AnimatedSwitcherWidget extends StatefulWidget {
  @override
  _AnimatedSwitcherWidgetState3 createState() => _AnimatedSwitcherWidgetState3();
}

class _AnimatedSwitcherWidgetState3 extends State<AnimatedSwitcherWidget>
    with SingleTickerProviderStateMixin {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    var valueKey = ValueKey(_count);
    final title =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "title";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: Colors.green.shade50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  var position = Tween(begin: Offset(1,0),end: Offset(0, 0)).animate(animation);
                  return SlideTransitionY(
                    position: position,
                    child: child,
                  );
                },
                child: Text(
                  "$_count count",
                  key: valueKey,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    _count++;
                  });
                },
                fillColor: Colors.red,
                child: Text("+1"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class _AnimatedSwitcherWidgetState2 extends State<AnimatedSwitcherWidget>
    with SingleTickerProviderStateMixin {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    var valueKey = ValueKey(_count);
    final title =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "title";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: Colors.green.shade50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Text(
                  "$_count count",
                  key: valueKey,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    _count++;
                  });
                },
                fillColor: Colors.red,
                child: Text("+1"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedSwitcherWidgetState extends State<AnimatedSwitcherWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: Duration(seconds: 1), vsync: this);
  late final ca = CurvedAnimation(parent: controller, curve: Curves.easeIn);

  late var animate;

  ///屏幕左边是-1，正中间0，右边是1
  @override
  Widget build(BuildContext context) {
    animate = Tween(begin: Offset(0, 0), end: Offset(-1, 0)).animate(ca);
    final title =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "title";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: Colors.green.shade50,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return SlideTransition(
              position: animate,
              child: Center(
                child: FlutterLogo(size: 150.0),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.reset();
          controller.forward();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class SlideTransitionY extends AnimatedWidget {
  final transformHitTests;

  final textDirection;

  final child;

  const SlideTransitionY({
    Key? key,
    required Animation<Offset> position,
    this.transformHitTests = true,
    this.textDirection,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get animation => listenable as Animation<Offset>;

  @override
  Widget build(BuildContext context) {
    var offset = animation.value;
    if (animation.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }

    return FractionalTranslation(
      transformHitTests: transformHitTests,
      translation: offset,
      child: child,
    );
  }
}
