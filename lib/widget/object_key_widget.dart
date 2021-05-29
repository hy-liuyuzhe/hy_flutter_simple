import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectKeyWidget extends StatefulWidget {
  @override
  State<ObjectKeyWidget> createState() => ObjectKeyState();
}

class ObjectKeyState extends State<ObjectKeyWidget> {
  var _index = 0;
  PageController pageController = new PageController(initialPage: 0);
  List<Widget> pages = [HomePage(), MessagePage(), MinePage()];
  List<BottomNavigationBarItem> items = [
    HYBottomBarItem(Icons.home, "首页"),
    HYBottomBarItem(Icons.message, "消息"),
    HYBottomBarItem(Icons.mic, "我的")
  ];

  @override
  void initState() {
    super.initState();
    print("ObjectKeyState init state");
  }

  @override
  Widget build(BuildContext context) {
    print("ObjectKeyState buildWidget is index= $_index");
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _index = index;
            pageController.jumpToPage(index);
          },
        ),
        body: Container(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index){
             updateIndex(index);
            },
            itemBuilder: (_, index) {
              return pages[index];
            },
            itemCount: pages.length,
          ),
        ));
  }

  void updateIndex(int index) {
    setState(() {
      _index = index;
    });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
          child: Container(
        child: Text("HYHomePage"),
      )),
    );
  }
}

///非globalKey 都是在当前context作用下生效
class MessagePage extends StatefulWidget  {
  // 有bean对象，有唯一ID时
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin{
  ObjectKey objectKey = ObjectKey("{id: id}");

  UniqueKey uniqueKey = UniqueKey();

  var valueKey = ValueKey(12);

  var _reversed = false;
  var keys = [UniqueKey(), UniqueKey()];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("_MessagePageState");
    var button1 = FancyButton(
      key: keys.first,
      child: Text(
        "1号",
        style: TextStyle(fontSize: 16),
      ),
    );

    var button2 = FancyButton(
      key: keys.last,
      child: Text(
        "2号",
        style: TextStyle(fontSize: 16),
      ),
    );

    var _buttons = [button1, button2];

    if (_reversed) _buttons = _buttons.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("消息"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Row(
              children: _buttons,
            )),
            InkWell(
              child: Text("消息"),
              onTap: () {
                setState(() {
                  _reversed = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///虽然每次切换都会重新调用build，但listview不含key，类型也不会变; element不会选择对它更新
class MinePage extends StatefulWidget  {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin<MinePage>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("_MinePageState");
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
      ),
      body: Center(
          child: Container(
              child: ListView.builder(
        itemBuilder: (_, index) {
          return ListTile(
            title: Text("title: $index"),
            subtitle: Text("subtitle $index"),
          );
        },
        itemCount: 30,
      ))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HYBottomBarItem extends BottomNavigationBarItem {
  HYBottomBarItem(IconData iconName, String title)
      : super(
            label: title,
            icon: Icon(iconName),
            activeIcon: Icon(Icons.ac_unit));
}

class FancyButton extends StatefulWidget {
  final Widget child;

  const FancyButton({Key? key, required this.child}) : super(key: key);

  @override
  _FancyButtonState createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> {
  final Map<_FancyButtonState, Color> _buttonColor = {};
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: _getColor(),
        onPressed: () {},
        child: widget.child,
      ),
    );
  }

  List<Color> colors = [
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.red,
    Colors.orange
  ];

  _getColor() => _buttonColor.putIfAbsent(this, () => colors[next(0, 5)]);

  next(int min, int max) => min + _random.nextInt(max);
}
