import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  late Timer _timer;
  void timer(){
     _timer=Timer(const Duration(seconds: 5), ()=>);
  }
  void navigateTo(){
    Helper.uId=CacheHelper.getStringData(key: 'uId');
    if(Helper.uId !=null){
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        const Spacer(),
        Text('Silent Voice',),
        const Spacer(),
        Divider(),
        Text('FROM INJOY',),
      ],
    );
  }
}