import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/all_widget.dart';


Map<String, WidgetBuilder> routers = {
  "关于dialog": (_) => new AboutListTileWidget(),
  "实现控件圆角不同组合": (_) => ClipImageWidget(),
};
