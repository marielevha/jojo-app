import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jojo/pages/widgets/toast.widget.dart';
//import 'package:prepa_bac/models/document/document.dart';
import 'package:jojo/services/api/config.api.dart';
//import 'package:prepa_bac/widgets/toasts.widget.dart';

import 'package:jojo/utils/constants.dart';
import 'locator.dart';

final ConfigApi configApi = locator<ConfigApi>();

checkInternetAccess() async {
  try {
    var checkInternet = await InternetAddress.lookup('www.google.com');
    if (checkInternet.isNotEmpty && checkInternet[0].rawAddress.isNotEmpty) {
      printWarning('INET ACCESS: True');
      return true;
    }
  }
  on SocketException catch(_) {
    printWarning('INTERNET NOT ACCESS');
    return false;
  }
}

buildUrl({required String url, required int id, int page = 0, int size = 25, required String query}) {
  url = '${url}page=$page&';
  url = '${url}size=$size&';
  if(query != '') {
    url = '${url}query=$query&';
  }
  return url;
}

buildStatus(String status) {
  switch(status) {
    case '2': { return 'En retard';}

    case '3': { return 'En cours ...'; }

    case '4': { return 'Terminé'; }

    case '5': { return 'Annulé'; }

    default: { return 'En attente ...';}
  }
}


//NOTIFICATIONS
/*void checkProgressNotification() async {
  try {
    printError('GO');
    var response = await configApi.checkProgress(code: 0);
    printInfo(response);
    if(response) {
      scheduleAlarm(DateTime.now());
    }
  }
  catch (_) {
    printError('EXCEPTION');
  }
}*/

/*void checkNewVersionNotification() async {
  try {
    var response = await configApi.checkNewVersion(code: 0);
    printInfo(response);
    if(response) {
      scheduleAlarm(DateTime.now());
    }
  }
  catch (_) {
    printError('EXCEPTION');
  }
}*/


//TOAST
void showToast({required FToast fToast, required String message, required Color color, int duration = 3, required ToastGravity gravity, required IconData icon}) {
  fToast.showToast(
    gravity: gravity == null ? ToastGravity.TOP : gravity,
    toastDuration: Duration(seconds: duration),
    child: BasicToast(
      message: message,
      color: color == null ? Color(0xFF1976D2) : color,
      icon: Icons.info_outlined,
    ),
  );
}

//DISPLAY MEMORY IMAGE
/*Widget displayMemoryImage({Function readPress, @required Document document, double top, double bottom, double left, double right, double width}) {
  return Positioned(
    top: top,
    left: left,
    right: right,
    bottom: bottom,
    child: GestureDetector(
      child: Image.memory(
        base64Decode(document.imageOverview.replaceAll('\r\n', '')),
        width: width != null ? width : 150,
        fit: BoxFit.cover,
      ),
      onTap: readPress,
    ),
  );
}*/

/*Future<String> scanQr() async {
  String result = await FlutterBarcodeScanner.scanBarcode("#ffffff", "cancel", true, ScanMode.QR);
  return result;
}*/

void printInfo(Object text) {
  if (kDebugMode) {
    print('\x1B[34m${text.toString()}\x1B[0m');
  }
}

void printWarning(Object text) {
  if (kDebugMode) {
    print('\x1B[33m${text.toString()}\x1B[0m');
  }
}

void printError(Object text) {
  if (kDebugMode) {
    print('\x1B[31m${text.toString()}\x1B[0m');
  }
}