import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routers,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text("收藏控件: ${routers.length} 个"),
          ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildListItem(context, index);
              },
              itemCount: routers.length)
        ],
      ),
    );
  }

  Widget buildListItem(BuildContext context, int index) {
    var text = routers.keys.toList()[index];
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(text,arguments: text);
      },
      child: Card(
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: DefaultTextStyle.of(context).style,
          ),
        ),
      ),
    );
  }
}
