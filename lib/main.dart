import 'package:camera/camera.dart';
import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observable.dart';
import 'package:social_app/core/helpers/cache_helper.dart';

List<CameraDescription>? cameras;
void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  await CacheHelper.initSharedPref();

  // bool? isDarkMode = CacheHelper.getBoolData(key: 'isDarkMode');

  runApp(MyApp());
}
