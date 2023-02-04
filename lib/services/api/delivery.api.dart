import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/models/voucher/voucher.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils//functions.dart';
import 'package:jojo/utils/locator.dart';
//import 'package:prepa_bac/helpers/strings.helper.dart';
//import 'package:prepa_bac/models/series/series.dart';
import 'package:jojo/models/user/user.dart';
import 'package:jojo/services/hive/hive_service.dart';

@lazySingleton
class DeliveryApi {
  final HiveService hiveService = locator<HiveService>();

  createDelivery({required Delivery delivery}) async {
    String url = '$apiBaseUrl/deliveries';
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${currentUser.accessToken}"
    };

    Map<String, dynamic> depart() => {
      "city": delivery.departCity ?? '',
      "latitude": delivery.departLat ?? '',
      "longitude": delivery.departLng ?? '',
      "ship_date": delivery.departDate ?? '',
      "hour": delivery.departHour ?? ''
    };
    Map<String, dynamic> destination() => {
      "city": delivery.destinationCity ?? '',
      "latitude": delivery.destinationLat ?? '',
      "longitude": delivery.destinationLng ?? '',
      "ship_date": delivery.destinationDate ?? '',
      "hour": delivery.destinationHour ?? ''
    };
    Map<String, dynamic> stop() => {
      "city": delivery.stopCity ?? '',
      "latitude": delivery.stopLat ?? '',
      "longitude": delivery.stopLng ?? '',
      "ship_date": "",
      "hour": ""
    };

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['depart'] = jsonEncode(depart())
      ..fields['destination'] =  jsonEncode(destination())
      ..fields['stop'] = jsonEncode(stop())
      ..fields['contact_name'] = delivery.contactName
      ..fields['contact_phone'] = delivery.contactPhone
      ..fields['transaction_type'] = delivery.transactionType
      ..fields['car_type'] = delivery.carType
      ..fields['car_number'] = delivery.carNumber.toString()
      ..fields['user_email'] = delivery.userEmail
      ..fields['user_id'] = delivery.userId.toString()
      ..fields['voucher'] = delivery.voucher!
      ..fields['house'] = delivery.house ?? ''
      ..fields['bedrooms_number'] = delivery.bedroomsNumber.toString()
      ..fields['route_number'] = delivery.routeNumber.toString();

    request.headers.addAll(headers);
    var response = await request.send();
    printWarning(response.statusCode);
    if (response.statusCode == 201) {
      //var respStr = await response.stream.bytesToString();
      //printError(respStr);
      //Delivery deliveryResponse = Delivery.fromJson(jsonDecode(respStr));
      return response.statusCode;
    }
    else {
      throw response;
    }
  }

  createDeliveryPackage({required Delivery delivery}) async {
    String url = '$apiBaseUrl/deliveries';
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${currentUser.accessToken}"
    };

    Map<String, dynamic> depart() => {
      "city": delivery.departCity,
      "latitude": delivery.departLat,
      "longitude": delivery.departLng,
      "ship_date": "",
      "hour": ""
    };
    Map<String, dynamic> destination() => {
      "city": delivery.destinationCity,
      "latitude": delivery.destinationLat,
      "longitude": delivery.destinationLng,
      "ship_date": delivery.destinationDate,
      "hour": delivery.destinationHour
    };
    Map<String, dynamic> stop() => {
      "city": delivery.stopCity,
      "latitude": delivery.stopLat,
      "longitude": delivery.stopLng,
      "ship_date": "",
      "hour": ""
    };

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['depart'] = jsonEncode(depart())
      ..fields['destination'] =  jsonEncode(destination())
      ..fields['stop'] = jsonEncode(stop())
      ..fields['packages'] = delivery.packages!
      ..fields['nature_packages'] = delivery.naturePackages!
      ..fields['weight_packages'] = delivery.weightPackages!
      ..fields['contact_name'] = delivery.contactName
      ..fields['contact_phone'] = delivery.contactPhone
      ..fields['transaction_type'] = delivery.transactionType
      ..fields['car_type'] = delivery.carType
      ..fields['car_number'] = delivery.carNumber.toString()
      ..fields['user_email'] = delivery.userEmail
      ..fields['user_id'] = delivery.userId.toString()
      ..fields['voucher'] = delivery.voucher!
      ..fields['route_number'] = delivery.routeNumber.toString();

    request.headers.addAll(headers);
    var response = await request.send();
    printWarning(response.statusCode);
    if (response.statusCode == 201) {
      //var respStr = await response.stream.bytesToString();
      //printError(respStr);
      //Delivery deliveryResponse = Delivery.fromJson(jsonDecode(respStr));
      return response.statusCode;
    }
    else {
      printError("Error1: $response");
      throw response;
    }
  }

  findDeliveryById({required int id}) async {}

  findDeliveryByCode({required String code}) async {}

  findDeliveriesByUserId({required int id, int page = 1, int size = 25}) async {
    String url = '$apiBaseUrl/deliveries?';
    url = '${url}user=$id&';
    url = '${url}page=$page&';
    url = '${url}size=$size';
    printWarning(url);
    printWarning(currentUser.accessToken);

    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${currentUser.accessToken}"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) {
        if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 403) {
          throw Exception(response.statusCode);
        }
        throw Exception('Failed to load');
      }
      //printWarning(json.decode(response.body)['data']);
      printError("Before");
      List<Delivery> deliveries = (json.decode(response.body)['data'] as List)
          .map((delivery) => Delivery.fromJson(delivery))
          .toList();
      printError("After");
      favoriteRemote = true;
      return deliveries;
    }
    on SocketException catch (_) {
      printError(_.message);
      printError("Except");
      favoriteRemote = false;
      throw Exception('Failed to load');
    }
  }

  findDeliveriesByUserEmail({required String email}) async {}

  checkVoucher({required String code}) async {
    String url = '$apiBaseUrl/vouchers/$code';

    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${currentUser.accessToken}"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) {
        if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 403) {
          throw Exception(response.statusCode);
        }
        throw Exception('Failed to load');
      }
      Voucher voucher = Voucher.fromJson(jsonDecode(response.body));
      return voucher;
    }
    on SocketException catch (_) {
      printError(_.message);
      throw Exception('Failed to load');
    }
  }

}