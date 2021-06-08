import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_controller.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_widget.dart';

import 'drop_select_bottom_confirm.dart';
import 'drop_select_object.dart';

typedef DropSelectWidgetBuilder<T extends DropSelectObject> = Widget
    Function(BuildContext context, T data);

class DropSelectListMenu extends DropSelectWidget {
  static const double kDropSelectListHeight = 48.0;
  final bool singleSelected;
  final List<DropSelectObject> items;
  final DropSelectWidgetBuilder itemBuilder;

  @override
  DropSelectWidgetState createState() => _DropSelectListMenuState();

  DropSelectListMenu(
      {required this.itemBuilder,
      required this.items,
      this.singleSelected = true});
}

class _DropSelectListMenuState
    extends DropSelectWidgetState<DropSelectListMenu> {
  List<DropSelectObject> cloneList = [];

  @override
  void onEvent(DropEvent? event) {
  }

  List<DropSelectObject> _buildItems() {
    if (widget.singleSelected) {
      return widget.items;
    }
    if(cloneList.isEmpty) {
      cloneDataList(widget.items, cloneList);
    }
    return cloneList;
  }


  @override
  Widget build(BuildContext context) {
    var dataList = _buildItems();
    return GestureDetector(
      onTap: () {
        controller?.hide();
        print('hide');
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          color: widget.singleSelected ? Colors.black26 : Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (c, index) {
                    var item = dataList[index];
                    return GestureDetector(
                        onTap: () => onClickItem(item, dataList),
                        child: Dismissible(
                          background: Container(
                              decoration: BoxDecoration(color: Colors.red),
                              child: Icon(Icons.delete_forever)),
                          key: ValueKey(item),
                          onDismissed: (DismissDirection dir) {
                            if (dir == DismissDirection.endToStart) {
                              setState(() {
                                dataList.removeWhere((element) {
                                  return element.title == item.title;
                                });
                              });
                            }
                          },
                          confirmDismiss: (dir) async =>
                              dir == DismissDirection.endToStart,
                          child: Container(
                              height: DropSelectListMenu.kDropSelectListHeight,
                              color: Colors.white,
                              child: widget.itemBuilder(context, item)),
                        ));
                  },
                  itemCount: dataList.length,
                  itemExtent: DropSelectListMenu.kDropSelectListHeight,
                ),
              ),
              Visibility(
                  visible: !widget.singleSelected,
                  child: DropSelectBottomConfirm(
                    onConfirmCallback: () {
                      print('confirm');
                      cloneDataList(cloneList,widget.items);
                      controller?.confirm(widget.items);
                    },
                    onRestCallback: () {
                      setState(() {
                        print('rest');
                        cloneDataList(widget.items,cloneList);
                        print('rest.');
                      });
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void onClickItem(DropSelectObject item, List<DropSelectObject> dataList) {
    print("object" + item.title.toString());
    if (widget.singleSelected) {
      dataList.forEach((element) {
        element.selected = false;
      });
    }

    setState(() {
      item.selected = !item.selected;
    });
    if (widget.singleSelected) {
      controller?.confirm(item);
    }
  }
}
