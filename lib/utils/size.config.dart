import 'package:flutter/material.dart';

class SizeConfig {
  late MediaQueryData _mediaQueryData;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double defaultSize = 0.0;
  static double blockSizeHorizontal = 0.0;
  static double blockSizeVertical = 0.0;
  static Orientation orientation = Orientation.landscape;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    // On iPhone 11 the defaultSize = 10 almost
    // So if the screen size increase or decrease then our defaultSize also vary

    blockSizeVertical = screenHeight / 100;
    blockSizeHorizontal = screenWidth / 100;
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

