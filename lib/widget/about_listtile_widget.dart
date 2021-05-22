import 'package:flutter/material.dart';

class AboutListTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)?.settings.arguments.toString() ?? "";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(),
    );
  }
}
