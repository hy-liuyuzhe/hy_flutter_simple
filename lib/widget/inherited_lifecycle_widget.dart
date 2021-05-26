import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

/// widget--element--createState--InheritedLifeCycleState--mount--initState--didChangeDependencies--build
class InheritedLifeCycleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InheritedLifeCycleState();
}

class InheritedLifeCycleState<InheritedLifeCycleWidget> extends State {
  var _count = 0;

  InheritedLifeCycleState() {
    print("construction");
  }

  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    final title =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "title";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ShareDataWidget(_count, _onPressed, ChipWidget()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _onPressed();
        },
      ),
    );
  }

  void _onPressed() {
    setState(() {
      _count++;
    });
  }

  @override
  void didUpdateWidget(covariant BaseStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }
}

class ShareDataWidget extends InheritedWidget {
  final int count;
  final PressedCallBack onPressedCallBack;

  ShareDataWidget(this.count, this.onPressedCallBack, child)
      : super(child: child);

  ///注册InheritedWidget监听并获取实例
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    return this.count != oldWidget.count;
  }
}

class ChipWidget extends StatefulWidget {

  @override
  _ChipWidgetState createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {

  ///当注册的inherit发生改变回调
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_ChipWidgetState.didChangeDependencies");
  }

  ///当父容器rebuild时回调
  @override
  void didUpdateWidget(covariant ChipWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_ChipWidgetState.didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    var count = ShareDataWidget.of(context)?.count;
    var onPressed = ShareDataWidget.of(context)?.onPressedCallBack;

    return Container(
      child: Center(
        child: ActionChip(
            label: Text(count.toString()),
            onPressed: () {
              onPressed?.call();
            }),
      ),
    );
  }
}

typedef PressedCallBack = void Function();
