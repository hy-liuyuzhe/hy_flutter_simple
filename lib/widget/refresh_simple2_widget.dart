import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

class RefreshSimple2Widget extends BaseStatefulWidget {
  @override
  _RefreshSimple2WidgetState createState() => _RefreshSimple2WidgetState();
}

class _RefreshSimple2WidgetState extends BaseStatefulState {
  final dataList = <String>[];
  final pageSize = 30;
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        onLoadMore();
      }
    });

    //默认触发刷新
    Future.delayed(Duration(milliseconds: 500), () {
      controller.animateTo(-100,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    dataList.clear();
    dataList.addAll(List.generate(pageSize, (index) => "refresh"));
    setState(() {});
  }

  Future<void> onLoadMore() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    dataList.addAll(List.generate(pageSize, (index) => "loadmore"));
    setState(() {});
  }

  @override
  Widget buildWidget(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        CupertinoSliverRefreshControl(
          refreshTriggerPullDistance: 100.0,
          refreshIndicatorExtent: 60.0,
          onRefresh: onRefresh,
        ),
        SliverSafeArea(
            sliver: Container(
          child: SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == dataList.length) {
                return Container(
                  margin: EdgeInsets.all(6),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return Card(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: Text("item ${dataList[index]} $index"),
                ),
              );
            },
            childCount: dataList.length >= pageSize
                ? dataList.length + 1
                : dataList.length,
          )),
        ))
      ],
    );
  }
}
