import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:jojo/models/delivery/delivery.dart';
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

  createDelivery({required Delivery delivery}) async {}

  findDeliveryById({required int id}) async {}

  findDeliveryByCode({required String code}) async {}

  findDeliveriesByUserId({required int id, int page = 1, int size = 25}) async {
    String url = '$apiBaseUrl/deliveries?';
    url = '${url}user=$id&';
    url = '${url}page=$page&';
    url = '${url}size=$size';
    printWarning(url);

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
      List<Delivery> deliveries = (json.decode(response.body)['data'] as List)
          .map((delivery) => Delivery.fromJson(delivery))
          .toList();
      favoriteRemote = true;
      return deliveries;
    }
    on SocketException catch (_) {
      favoriteRemote = false;
      throw Exception('Failed to load');
    }
  }

  findDeliveriesByUserEmail({required String email}) async {}

}