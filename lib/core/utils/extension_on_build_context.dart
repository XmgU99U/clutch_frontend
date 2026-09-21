import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  void replace(Widget page) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page , ));
  }

  void pushAndRemoveAll(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void back() {
    Navigator.pop(this);
  }

  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
}
