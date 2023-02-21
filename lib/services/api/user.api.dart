import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:jojo/models/response/login.response.dart';
import 'package:jojo/models/response/register.response.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils//functions.dart';
import 'package:jojo/utils/locator.dart';
//import 'package:prepa_bac/helpers/strings.helper.dart';
//import 'package:prepa_bac/models/series/series.dart';
import 'package:jojo/models/user/user.dart';
import 'package:jojo/services/hive/hive_service.dart';

@lazySingleton
class UserApi {
  final HiveService hiveService = locator<HiveService>();

  login({required User user}) async {
    String url = '$apiBaseUrl/auth/login';

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['email'] = user.email
      ..fields['password'] = user.password;

    var response = await request.send();

    if (response.statusCode == 200) {
      var respStr = await response.stream.bytesToString();
      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(respStr));

      //Open User Box && Add user to box
      final userBox = await Hive.openBox(hiveUserTableName);
      await userBox.add(loginResponse.user);

      //Add info user to constant CURRENT_USER
      currentUser = loginResponse.user;

      return currentUser;
    }
    else {
      throw response;
    }
  }

  register({required User user}) async {
    String url = '$apiBaseUrl/auth/register';
    printWarning(url);

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['first_name'] = user.firstName
      ..fields['last_name'] = user.lastName
      ..fields['profile'] = user.profile
      ..fields['phone'] = user.phone
      ..fields['country'] = user.country
      ..fields['email'] = user.email
      ..fields['password'] = user.password
      ..fields['password_confirmation'] = user.confirmPassword;

    var response = await request.send();
    printWarning(response.statusCode);
    /*if (response.statusCode == 201) {
      var respStr = await response.stream.bytesToString();
      RegisterResponse registerResponse = RegisterResponse.fromJson(jsonDecode(respStr));
      return registerResponse.user;
    }
    else if (response.statusCode == 401) {
      return response;
    }*/

    if (response.statusCode == 201 || response.statusCode == 401) {
      //var respStr = await response.stream.bytesToString();
      //RegisterResponse registerResponse = RegisterResponse.fromJson(jsonDecode(respStr));
      return response;
    }
    else {
      throw response;
    }
  }

  logout() async {
    final headers = {
      "Authorization": "Bearer ${currentUser.accessToken}"
    };

    String url = '$apiBaseUrl/auth/logout';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      /*var respStr = */await response.stream.bytesToString();

      //Empty current user
      currentUser = User.initId(0);
      //Clear user box
      await hiveService.clearBox(boxName: hiveUserTableName);
      await addFakeUser();
      var isExist = await hiveService.isExists(boxName: 'users');
      return response.statusCode;
    }
    else {
      throw Exception('Failed to logout');
    }
  }

  updateColumn({ required String column, required dynamic value }) async {
    final headers = {
      "Authorization": "Bearer ${currentUser.accessToken}"
    };
    String url = '$apiBaseUrl/auth/updateColumn';

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['column'] = column
      ..fields['value'] = value;
    request.headers.addAll(headers);


    var response = await request.send();
    if (response.statusCode == 200) {
      var respStr = await response.stream.bytesToString();
      User user = User.fromJson(jsonDecode(respStr));

      //Open User Box && Add user to box
      final userBox = await Hive.openBox(hiveUserTableName);
      User currentUser = userBox.getAt((userBox.length - 1)) as User;
      if(column == 'name') {
        currentUser.name = user.name;
      }
      else if(column == 'email') {
        currentUser.email = user.email;
      }

      await userBox.add(currentUser);
      currentUser = currentUser;
      return currentUser;
    }
    else {
      throw response;
    }
  }

  updateUser({ required User user }) async {
    final headers = {
      "Authorization": "Bearer ${currentUser.accessToken}"
    };
    String url = '$apiBaseUrl/auth/updateUser/${currentUser.id}';

    printWarning(url);

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['first_name'] = user.firstName
      ..fields['last_name'] = user.lastName
      ..fields['phone'] = user.phone
      ..fields['country'] = user.country
      ..fields['password'] = user.password
      ..fields['password_confirmation'] = user.password;
    request.headers.addAll(headers);


    var response = await request.send();

    printWarning(response.statusCode);
    if (response.statusCode == 201) {
      var respStr = await response.stream.bytesToString();
      User user = User.fromJson(jsonDecode(respStr));
      printWarning("User new: ${user.country}");

      //Open User Box && Add user to box
      final userBox = await Hive.openBox(hiveUserTableName);
      User lastUser = userBox.getAt((userBox.length - 1)) as User;
      lastUser.name = user.name;
      lastUser.firstName = user.firstName;
      lastUser.lastName = user.lastName;
      lastUser.phone = user.phone;
      lastUser.country = user.country;
      //printWarning("User new: ${lastUser.country}");
      /*if(column == 'name') {
        lastUser.name = user.name;
      }
      else if(column == 'email') {
        lastUser.email = user.email;
      }*/

      await userBox.add(lastUser);
      currentUser = lastUser;
      return lastUser;
    }
    else {
      throw response;
    }
  }

  updatePassword({ required String lastPass, required String newPass, required String confirmNewPass }) async {
    final headers = {
      "Authorization": "Bearer ${currentUser.accessToken}"
    };
    String url = '$apiBaseUrl/auth/updatePassword';

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['last_password'] = lastPass
      ..fields['password'] = newPass
      ..fields['password_confirmation'] = confirmNewPass;
    request.headers.addAll(headers);

    var response = await request.send();
    if (response.statusCode == 200) {
      var respStr = await response.stream.bytesToString();
      LoginResponse _loginResponse = LoginResponse.fromJson(jsonDecode(respStr));

      //Open User Box && Add user to box
      final userBox = await Hive.openBox(hiveUserTableName);
      await userBox.add(_loginResponse.user);

      //Add infos user to constant CURRENT_USER
      currentUser = _loginResponse.user;
      return currentUser;
    }
    else {
      throw response;
    }
  }

  requestResetPassword({required String email}) async {
    final headers = {
      "Accept": "application/json",
    };
    String url = '$apiBaseUrl/auth/resetPasswordRequest';
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['email'] = email;
    request.headers.addAll(headers);

    var response = await request.send();
    printWarning("Status: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 404) {
      var respStr = await response.stream.bytesToString();
      var rep = jsonDecode(respStr);
      return rep;
    }
    throw response;
  }

  resetPassword({ required String code, required String password, required String confirmPassword }) async {
    final headers = {
      "Accept": "application/json",
    };
    String url = '$apiBaseUrl/auth/resetPassword';
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['reset_code'] = code
      ..fields['password'] = password
      ..fields['password_confirmation'] = confirmPassword;
    request.headers.addAll(headers);

    var response = await request.send();
    if (response.statusCode == 200) {
      var respStr = await response.stream.bytesToString();
      var rep = jsonDecode(respStr);
      return rep;
    }
    throw response;
  }

  /*updateSeries({required String series}) async {
    final headers = {
      "Authorization": "Bearer ${currentUser.accessToken}"
    };
    String url = '$apiBaseUrl/auth/updateSeriesPref';

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['series'] = series;
    request.headers.addAll(headers);

    var response = await request.send();
    if (response.statusCode == 200) {
      var respStr = await response.stream.bytesToString();
      Series _series = Series.fromJson(jsonDecode(respStr));

      //Open User Box && Add user to box
      final userBox = await Hive.openBox(USERS_TABLE);
      User currentUser = userBox.getAt((userBox.length - 1)) as User;

      currentUser.series = _series.id;
      await userBox.add(currentUser);
      currentUser = currentUser;
      return currentUser;
    }
    else {
      throw response;
    }
  }*/

  addFakeUser() async {
    final userBox = await Hive.openBox(hiveUserTableName);
    User user = User.init();
    user.id = 0;
    user.name = 'config';
    user.phone = 'phone';
    user.email = 'config@jojo.com';
    user.firstName = '';
    user.lastName = '';
    user.country = '';
    user.profile = '';
    user.password = '';
    user.accessToken = '';
    userBox.add(user);
  }
}