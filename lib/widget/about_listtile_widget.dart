import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateless_widget.dart';

///
/// text不设置style 会使用 defaultStyle， 他是常量对象， 所以全局生效
///
/// 显示关于APP信息
/// AboutListTile
///   使用ListTitle构建的文本，点击弹showAboutDialog
/// showAboutDialog->AboutDialog->AlertDialog->Dialog
///
///
class AboutListTileWidget extends BaseStatelessWidget {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            AboutListTile(
              icon: FlutterLogo(),
              applicationName: "yuzhe 程序员👨🏻‍💻",
                applicationLegalese: "",
            ),
            SizedBox(height: 100),
            TextButton(
              onPressed: () {
                showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset(
                      'static/icon_love.png',
                      width: 100,
                      height: 100,
                    ),
                    applicationName: "hyApp",
                    applicationVersion: "1.0.1");
              },
              child: Text("show AboutDialog"),
            ),
          ],
        ),
      ),
    );
  }
}
