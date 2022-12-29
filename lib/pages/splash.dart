import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:get/get.dart';


class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
     });
    return Scaffold(
      backgroundColor: GlobalColors.Whitecolor,
      body: Center(
        child: Image(
          image: AssetImage('assets/logos/slogan.png'),
          height: 90,
        )
      ),
    );
  }
}