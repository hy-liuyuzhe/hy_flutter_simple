import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/all_widget.dart';

Map<String, WidgetBuilder> routers = {
  "关于dialog": (_) => AboutListTileWidget(),
  "简单上下刷新1": (_) => RefreshSimple1Widget(),
  "简单上下刷新2": (_) => RefreshSimple2Widget(),
  "实现控件圆角不同组合": (_) => ClipImageWidget(),
  "列表滑动到指定位置": (_) => ScrollToIndexWidget(),
  "控件动画组合展示（旋转加放大圆）": (_) => AnimationComposeWidget(),
  "探索InheritedLifeCycle": (_) => InheritedLifeCycleWidget(),
  "气泡提示框": (_) => BubbleSimpleWidget(),
  "外国友人的例子": (_) => PipeLineWidget(),
  "tab切换界面和key的学习": (_) => ObjectKeyWidget(),
  "炫酷的动画字体": (_) => AnimateTextWidget(),
};
