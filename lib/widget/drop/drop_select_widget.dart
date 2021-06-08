import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_object.dart';

import 'drop_select_controller.dart';

abstract class DropSelectWidget extends StatefulWidget {
  const DropSelectWidget({Key? key}) : super(key: key);

  @override
  DropSelectWidgetState<DropSelectWidget> createState();
}

abstract class DropSelectWidgetState<T extends DropSelectWidget>
    extends State<T> {
  DropSelectController? controller;

  @override
  void didChangeDependencies() {
    controller = controller ?? DropSelectMenuContainerWidget.of(context);
    controller?.addListener(() => _onEvent());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    if(mounted) {
      print("销毁");
      controller?.dispose();
    }
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    controller?.removeListener(() => _onEvent());
    controller = controller ?? DropSelectMenuContainerWidget.of(context);
    controller?.addListener(() => _onEvent());
    super.didUpdateWidget(oldWidget);
  }

  void cloneDataList(List<DropSelectObject> from, List<DropSelectObject> to) {
    to.clear();
    from.forEach((element) {
      to.add(element.clone());
    });
  }

  void resetList(List<DropSelectObject> list) {
    list.forEach((element) {
      element.selected = false;
      element.children?.forEach((element) {
        element.selected = false;
      });
    });
    list.forEach((element) {
      element.children?[0].selected = true;
    });
  }

  void _onEvent() {
    // print('event = ${controller?.event}');
    onEvent(controller?.event);
  }

  void onEvent(DropEvent? event);
}

class DropSelectMenuContainerWidget extends StatefulWidget {
  final Widget child;

  const DropSelectMenuContainerWidget({Key? key, required this.child})
      : super(key: key);

  static DropSelectController? of(BuildContext context) {
    var inherited =
        context.findAncestorWidgetOfExactType<DropSelectMenuInherited>();
    return inherited?.controller;
  }

  @override
  _DropSelectMenuContainerWidgetState createState() =>
      _DropSelectMenuContainerWidgetState();
}

class _DropSelectMenuContainerWidgetState
    extends State<DropSelectMenuContainerWidget> {
  late DropSelectController dropSelectController;

  @override
  void initState() {
    super.initState();
    dropSelectController = DropSelectController();
  }

  @override
  void dispose() {
    super.dispose();
    dropSelectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropSelectMenuInherited(
        controller: dropSelectController,
        child: widget.child,
      ),
    );
  }
}

class DropSelectMenuInherited extends InheritedWidget {
  final DropSelectController controller;

  DropSelectMenuInherited({required Widget child, required this.controller})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant DropSelectMenuInherited oldWidget) {
    return controller != oldWidget.controller;
  }
}

class DropSelectMenuBuilder {
  final WidgetBuilder builder;
  final double height;

  DropSelectMenuBuilder({required this.builder, required this.height});
}
