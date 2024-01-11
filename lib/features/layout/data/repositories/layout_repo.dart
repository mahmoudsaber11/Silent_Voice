import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class LayoutRepo {
  void changeBottomNav({required int index, required context}) {}
  List<Widget> views();
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData();
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers();
}
