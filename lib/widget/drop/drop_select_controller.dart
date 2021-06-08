import 'package:flutter/material.dart';

class DropSelectController extends ChangeNotifier {
  DropEvent? event;
  dynamic data;
  int menuIndex = 0;

  void hide() {
    event = DropEvent.hide;
    notifyListeners();
  }

  void show(int menuIndex) {
    this.menuIndex = menuIndex;
    event = DropEvent.show;
    notifyListeners();
  }

  void confirm(dynamic data) {
    this.data = data;
    event = DropEvent.confirm;
    notifyListeners();
  }
}

enum DropEvent { hide, confirm, show }
