import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/all_widget.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

import 'bubble_simple_widget.dart';

class TransformSimpleWidget extends BaseStatefulWidget {
  @override
  State<BaseStatefulWidget> createState() => TransformSimpleState();
}

class TransformSimpleState extends BaseStatefulState
    with SingleTickerProviderStateMixin {
  late var animationController =
      AnimationController(duration: Duration(seconds: 1), vsync: this);
  late Animation animation =
      Tween(begin: 0, end: 1.0).animate(animationController);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 280,
            height: 200,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                rotateCard(),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Row(
                    children: [Transform.rotate(angle: pi/180 * -30,
                    child: Icon(Icons.arrow_back)), Text("点它")],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.black,
            child: Transform(
              alignment: FractionalOffset.topRight,
              transform: Matrix4.skewY(0.3)
                ..setEntry(3, 2, 0.0001)
                ..rotateZ(-pi / 12.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: const Color(0xFFE8581C),
                child: const Text('Apartment for rent!'),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.black,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(context));
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: const Color(0xFFE8581C),
                child: const Text('去下一个界面'),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.003)
              ..rotateY(pi / 180 * 45) //90就是正对着你的一条线，所以我们显示45度
            ,
            child: Container(
                color: Colors.yellow,
                width: 150,
                height: 150,
                child: FlutterLogo()),
          )
        ],
      ),
    );
  }

  Route createRoute(BuildContext context) {
    var currentPage = context.widget;
    var dest = BubbleSimpleWidget();
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return dest;
        },
        transitionDuration: Duration(seconds: 3),
        reverseTransitionDuration: Duration(seconds: 3),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: Curves.ease, parent: animation);

          //1角度 = pi/180;
          // 当前页面我们以右下角为起点，从0走到90度
          var currentPageRotateY =
              pi / 180 * (animation.value * 180); //pi/2 * animation.value;
          var destRotateY = pi /
              180 *
              ((animation.value - 1) * 180); //pi/2 * animation.value;
          // pi / 2 * (animation.value - 1)
          // print("animation.value ${animation.value}");
          print("currentPageRotateY ${currentPageRotateY}");
          return Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(-1.0, 0.0),
                ).animate(animation),
                child: Container(
                  color: Colors.white,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateX(currentPageRotateY),
                    alignment: FractionalOffset.centerRight,
                    child: currentPage,
                  ),
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: Container(
                  color: Colors.white,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateX(destRotateY),
                    alignment: FractionalOffset.centerLeft,
                    child: dest,
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget rotateCard() {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            if (animationController.isCompleted) {
              animationController.reverse();
              print("reverse");
            } else {
              print("forward");
              animationController.forward();
            }
          },
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setRotationY(pi / 180 * (animation.value * 180)),
            child: Container(
                color: Colors.yellow,
                width: 150,
                height: 150,
                child: animation.value >= 0.5
                    ? Image.asset(icon_love, fit: BoxFit.cover)
                    : FlutterLogo()),
          ),
        );
      },
    );
  }
}
