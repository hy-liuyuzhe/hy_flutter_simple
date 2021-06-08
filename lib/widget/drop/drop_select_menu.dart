import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_controller.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_widget.dart';

class DropSelectMenu extends DropSelectWidget {
  final List<DropSelectMenuBuilder> menus;
  final double maxHeight;
  final Duration hideDuration;
  final Duration showDuration;

  DropSelectMenu(
      {required this.menus,
      required this.maxHeight,
      hideDuration,
      showDuration})
      : hideDuration = hideDuration ?? Duration(milliseconds: 150),
        showDuration = showDuration ?? Duration(milliseconds: 300);

  @override
  DropSelectWidgetState<DropSelectWidget> createState() =>
      DropSelectMenuState();
}

class DropSelectMenuState extends DropSelectWidgetState<DropSelectMenu>
    with TickerProviderStateMixin {

  int? showIndex;
  double opacityLevel = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < widget.menus.length; i++) {
      var menu = widget.menus[i];
      children.add(AnimatedOpacity(
          duration: widget.showDuration,
          opacity: opacityLevel,
          child: createMenu(context, menu)));
    }
    return IndexedStack(
      sizing: StackFit.expand,
      index: showIndex,
      children: children,
    );
  }

  @override
  void onEvent(DropEvent? event) {
    if (event == null) return;
    print('menu.event = $event');
    switch (event) {
      case DropEvent.hide:
      case DropEvent.confirm:
        onHide();
        break;
      case DropEvent.show:
        onShow();
        break;
    }
  }

  void onShow() {
    if (showIndex == controller?.menuIndex) {
      return;
    }
    setState(() {
      opacityLevel = 1;
      showIndex = controller?.menuIndex;
      print('显示 ${showIndex! + 1}');
    });
  }

  Widget createMenu(BuildContext context, DropSelectMenuBuilder builder) {
    return ClipRect(clipper: SizeClipper(), child: builder.builder(context));
  }

  void onHide() {
    if (showIndex == null && opacityLevel==0) return;
    print('隐藏');
    setState(() {
      showIndex = null;
      opacityLevel = 0;
    });
  }
}

class SizeClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}

class DropSelectAnimation {
  late final AnimationController animationController;
  late Animation<Rect> animate;

  DropSelectAnimation(
      {required double height, required TickerProvider provider}) {
    print('height= $height');
    animationController = AnimationController(vsync: provider);
    animate =
        Tween(begin: Rect.fromLTRB(0.0, -height, 0.0, 0.0), end: Rect.zero)
            .animate(animationController);
  }

  set value(double value) {
    animationController.value = value;
  }

  TickerFuture animateTo(double value, Duration duration) {
    return animationController.animateTo(value, duration: duration);
  }

  void dispose() => animationController.dispose();
}
