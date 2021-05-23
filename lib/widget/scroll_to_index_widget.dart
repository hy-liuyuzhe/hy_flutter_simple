import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

///
/// controller.animateTo(offset）利用这个API滑动，这个offset不考虑当前滚动的位置，要layout view 后的距离尺寸
///
/// 如何计算offset
/// 每个itemview设置globalKey
/// scrollview设置globalkey
/// 使用item的key获取renderObject调用localToGlobal，拿到要定位点离scrollview顶部的距离
class ScrollToIndexWidget extends BaseStatefulWidget {
  @override
  State<BaseStatefulWidget> createState() => _ScrollToIndexState();
}

class _ScrollToIndexState extends State<ScrollToIndexWidget> {
  var _scrollKey = GlobalKey();
  var _scrollController = ScrollController();
  List<ItemModel> dataList = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      dataList.add(ItemModel(i));
    }
  }

  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      key: _scrollKey,
      controller: _scrollController,
      child: Column(
        children: dataList.map<Widget>((item) => buildItemView(item)).toList(),
      ),
    );
  }

  Widget buildItemView(ItemModel item) {
    return Container(
      child: Card(
        key: item.itemGlobalKey,
        child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: Random().nextInt(100) + 30,
            child: Text("Item ${item.index}")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "title";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: buildWidget(context),
      persistentFooterButtons: [
        TextButton(
            onPressed: () async {
              _scrollToIndex();
            },
            child: Text("Scroll to 12"))
      ],
    );
  }

  void _scrollToIndex() {
    GlobalKey key = dataList[12].itemGlobalKey;
    RenderBox renderObject =
        key.currentContext!.findRenderObject() as RenderBox;
    double y = renderObject
        .localToGlobal(Offset.zero,
            ancestor: _scrollKey.currentContext!.findRenderObject())
        .dy;

    double offset = y + _scrollController.offset;
    print("offset= $offset");

    _scrollController.animateTo(offset,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }
}

class ItemModel {
  var itemGlobalKey = GlobalKey();
  var index;

  ItemModel(this.index);
}
