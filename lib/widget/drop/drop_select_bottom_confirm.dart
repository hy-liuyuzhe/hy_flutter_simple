import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_list_menu.dart';

class DropSelectBottomConfirm extends StatelessWidget {
  final VoidCallback onConfirmCallback;
  final VoidCallback onRestCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: DropSelectListMenu.kDropSelectListHeight,
        child: Row(
          children: [
            Expanded(child: GestureDetector(onTap:onRestCallback,child: Center(child: Text('重置')))),
            Expanded(
                child: GestureDetector(
                  onTap: onConfirmCallback,
                  child: Center(
                      child: Text(
              '确定',
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
                ))
          ],
        ),
      ),
    );
  }

  DropSelectBottomConfirm(
      {required this.onConfirmCallback, required this.onRestCallback});
}
