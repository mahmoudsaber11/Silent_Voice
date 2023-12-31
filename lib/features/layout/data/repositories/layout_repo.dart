import 'package:flutter/material.dart';

abstract class LayoutRepo {
  void changeBottomNav({required int index, required context}) {}
  List<Widget> views();
}
