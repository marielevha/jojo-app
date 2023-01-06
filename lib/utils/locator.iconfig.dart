// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:jojo/services/api/config.api.dart';
import 'package:jojo/services/api/delivery.api.dart';
//import 'package:prepa_bac/services/api/document-api.dart';
import 'package:jojo/services/api/user.api.dart';
//import 'package:prepa_bac/services/api/series-api.dart';
import 'package:jojo/services/hive/hive_service.dart';


void $initGetIt(GetIt g, {required String environment}) {
  g.registerLazySingleton<HiveService>(() => HiveService());
  g.registerLazySingleton<DeliveryApi>(() => DeliveryApi());
  //g.registerLazySingleton<DocumentApi>(() => DocumentApi());
  g.registerLazySingleton<UserApi>(() => UserApi());
  g.registerLazySingleton<ConfigApi>(() => ConfigApi());
}