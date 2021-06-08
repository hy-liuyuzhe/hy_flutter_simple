import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_controller.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_widget.dart';

typedef ShowTitle = String Function(dynamic data, int index);

class DropSelectMenuTitleWidget extends DropSelectWidget {
  final List<dynamic> titles;
  final ShowTitle showTitle;
  final double height;
  final int showIndex;

  @override
  DropSelectWidgetState<DropSelectMenuTitleWidget> createState() =>
      DropSelectMenuTitleState(showIndex);

  DropSelectMenuTitleWidget(
      {required this.showTitle,
      required this.titles,
      this.height = 45,
      this.showIndex = -1});
}

class DropSelectMenuTitleState
    extends DropSelectWidgetState<DropSelectMenuTitleWidget> {
  int? showIndex;

  DropSelectMenuTitleState(this.showIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border(bottom: Divider.createBorderSide(context))),
          child: SizedBox(
              height: widget.height,
              child: Row(children: buildMenuTitleWidget()))),
    );
  }

  List<Widget> buildMenuTitleWidget() {
    List<Widget> titleList = [];
    for (int i = 0; i < widget.titles.length; i++) {
      final selected = showIndex == i;

      var color = selected
          ? Theme.of(context).primaryColor
          : Theme.of(context).unselectedWidgetColor;
      titleList.add(Expanded(
          child: GestureDetector(
              onTap: (){_onTop(i);},
              child: Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border(left: Divider.createBorderSide(context))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.showTitle(widget.titles[i], i),
                        style: TextStyle(color: color),
                      ),
                      Icon(
                        selected ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: color,
                      )
                    ],
                  ),
                ),
              ))));
    }
    return titleList;
  }

  @override
  void onEvent(DropEvent? event) {
    if (event == null) return;
    // print('title.event = $event');
    switch (event) {
      case DropEvent.hide:
      case DropEvent.confirm:
        if (showIndex == null) return;
        setState(() {
          showIndex = null;
        });
        break;
      case DropEvent.show:
        if (showIndex == controller?.menuIndex) return;
        setState(() {
          showIndex = controller?.menuIndex;
        });
        break;
    }
  }

  void _onTop(int index) {
    print('index = $index');
    if(showIndex == index){
      controller?.hide();
      return;
    }
    controller?.show(index);
  }
}
