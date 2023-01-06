import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jojo/pages/home.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:get/get.dart';


class Splash extends StatelessWidget {
  //Initial route
  final String initialRoute;

  const Splash({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      initialRoute == routeLogin ? Get.to(const LoginView()) :  Get.to(const HomePage());
    });
    return Scaffold(
      backgroundColor: GlobalColors.Whitecolor,
      body: const Center(
        child: Image(
          image: AssetImage('assets/logos/slogan.png'),
          height: 90,
        )
      ),
    );
  }
}