import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/all_widget.dart';


Map<String, WidgetBuilder> routers = {
  "关于dialog": (_) => new AboutListTileWidget(),
  "实现控件圆角不同组合": (_) => ClipImageWidget(),
  "列表滑动到指定位置": (_) => ScrollToIndexWidget(),
  "控件动画组合展示（旋转加放大圆）": (_) => AnimationComposeWidget(),
};
