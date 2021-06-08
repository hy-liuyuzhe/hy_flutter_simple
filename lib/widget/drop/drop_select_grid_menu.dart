import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_bottom_confirm.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_controller.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_widget.dart';

import 'drop_select_list_menu.dart';
import 'drop_select_object.dart';

class DropSelectGridMenu extends DropSelectWidget {
  final DropSelectWidgetBuilder itemBuilder;
  final List<DropSelectObject> items;

  @override
  DropSelectWidgetState<DropSelectWidget> createState() =>
      DropSelectGridMenuState();

  DropSelectGridMenu({required this.itemBuilder, required this.items});
}

class DropSelectGridMenuState
    extends DropSelectWidgetState<DropSelectGridMenu> {
  late List<DropSelectObject> dataList;

  @override
  void initState() {
    super.initState();
    dataList = [];
    cloneDataList(widget.items, dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(dataList[index].title.toString()),
                    ),
                    renderGrid(dataList[index].children)
                  ],
                );
              },
              itemCount: dataList.length,
            ),
          ),
          DropSelectBottomConfirm(
            onConfirmCallback: () {
              print('confirm');
              cloneDataList(dataList, widget.items);
              controller?.confirm(widget.items);
            },
            onRestCallback: () {
              setState(() {
                print('rest');
                cloneDataList(widget.items, dataList);
                print('rest.');
              });
            },
          )
        ],
      ),
    );
  }

  @override
  void onEvent(DropEvent? event) {}

  Widget renderGrid(List<DropSelectObject>? children) {
    if (children == null || children.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (c, index) {
          var item = children[index];
          return Container(
              child: GestureDetector(
                  onTap: () {
                    if (item.selectedCleanOther) {
                      children.forEach((element) => element.selected = false);
                    }
                    if (index != 0) {
                      children[0].selected = false;
                    }

                    item.selected = !item.selected;
                    setState(() {});
                  },
                  child: widget.itemBuilder(c, item)));
        },
        itemCount: children.length,
      ),
    );
  }
}
