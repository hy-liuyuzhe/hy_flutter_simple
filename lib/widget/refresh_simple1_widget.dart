import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateful_widget.dart';

/// RefreshIndicator: 下拉刷新，包裹子view show来实现
/// CircularProgressIndicator：加载更多，当滑动到最后一个item时，返回此view
class RefreshSimple1Widget extends BaseStatefulWidget {
  @override
  _RefreshSimple1WidgetState createState() => _RefreshSimple1WidgetState();
}

class _RefreshSimple1WidgetState extends BaseStatefulState {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
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

    Future.delayed(Duration(milliseconds: 500),(){
      print("show");
      refreshKey.currentState?.show();
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
    dataList.addAll(List.generate(pageSize, (index) => "load more"));
    setState(() {});
  }

  @override
  Widget buildWidget(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          if(index == dataList.length){
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
        itemCount:
            dataList.length >= pageSize ? dataList.length + 1 : dataList.length,
      ),
    );
  }
}
