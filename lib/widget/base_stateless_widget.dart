import 'package:flutter/material.dart';

abstract class BaseStatelessWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "title";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: buildWidget(context),
    );
  }

  Widget buildWidget(BuildContext context);
}
