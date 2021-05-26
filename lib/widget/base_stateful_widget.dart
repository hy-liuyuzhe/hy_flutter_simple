import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  @override
  State<BaseStatefulWidget> createState();
}

abstract class BaseStatefulState<T extends BaseStatefulWidget>
    extends State<T> {



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
