import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';

@lazySingleton
class ConfigApi {
  final headers = {
    "Accept": "application/json",
  };

  checkProgress({required int code}) async {
    String apiUrl = '$apiBaseUrl/configs/check_progress/$code';

    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode != 200) {
      printError(response.body);
      throw Exception('Failed to load');
    }

    printInfo('CHECK_PROGRESS ${response.body}');
  }

  checkNewVersion({required int code}) async {
    String apiUrl = '$apiBaseUrl/configs/check_new_version/$code';

    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to load');
    }

    printInfo('CHECK_NEW_VERSION ${response.body}');
  }
}