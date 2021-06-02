import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/all_widget.dart';

import 'clip_image_widget.dart';

///利用Text.rich控件包裹TextSpan来实现富文本
class RichTextWidget extends StatefulWidget {
  @override
  _RichTextWidgetState createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {
  double _size = 50.0;

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _size += 10;
                });
              },
              icon: Icon(Icons.add_circle_outline)),
          IconButton(
              onPressed: () {
                setState(() {
                  _size -= 10;
                });
              },
              icon: Icon(Icons.remove_circle_outline))
        ],
      ),
      body: Center(
        child: Container(
          child: Text.rich(TextSpan(
              text: "Flutter ",
              // style: DefaultTextStyle.of(context).style,
              children: <InlineSpan>[
                WidgetSpan(
                    child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Card(
                    child: Center(child: Text("is")),
                    color: Colors.blue,
                    elevation: 5.0,
                  ),
                )),
                WidgetSpan(
                    child: Container(
                      child: Image.asset(icon_love,
                        fit: BoxFit.cover,
                        width: _size > 0 ? _size : 0,
                        height: _size > 0 ? _size : 0,),
                    )),
                TextSpan(text: " the best language")
              ])),
        ),
      ),
    );
  }
}
