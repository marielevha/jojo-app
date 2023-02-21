import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jojo/pages/profil.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jojo/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  //Initial route
  final String initialRoute;
  const Splash({super.key, required this.initialRoute});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      checkInternet();
      Timer(const Duration(seconds: 2), () {
        _isLoading = true;
      });
    });
  }

  Future checkInternet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isConnected = prefs.getBool('isConnected') ?? false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi || isConnected == true) {
            //Get.to(HomePage());
      if(widget.initialRoute == routeHome) {
        Get.to(HomePage());
      }
      else {
        Get.to(LoginView());
      }
    } else if(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi || isConnected == false){
          Get.to(LoginView());
        }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pas de connexion internet'),
            content: Text('Veuillez verifier votre connexion internet et ressayer encore.'),
            actions: [
              MaterialButton(
                child: Text('Ressayer'),
                onPressed: () {
                  checkInternet();
                },
              )
            ],
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: GlobalColors.Whitecolor,
      body: Center(
        child: _isLoading? Column(
         mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/logos/slogan.png'),
                    height: 90,
                  ),
                ],
        ) :Column(
         mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/logos/slogan.png'),
                    height: 90,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: GlobalColors.Orangecolor,
                      )),
                ],
        )  
      ),
    );
  }

}
