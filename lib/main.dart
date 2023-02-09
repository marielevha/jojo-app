import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/models/user/user.dart';
import 'package:jojo/pages/splash.dart';
import 'package:get/get.dart';
import 'package:jojo/services/hive/hive_service.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/locator.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Hive
  if(kIsWeb) {
    await Hive.initFlutter();
  }
  else {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
  }

  //Register adapter
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(DeliveryAdapter());

  //Initial route
  String initialRoute = routeLogin;

  //Run locator
  setupLocator();

  //Init hive service
  final HiveService hiveService = locator<HiveService>();


  printInfo("Current1: ${currentUser.id}");
  //User exist?
  if (!await hiveService.isExists(boxName: hiveUserTableName)) {
    printWarning("User table not exist");
    await hiveService.createBox(boxName: hiveUserTableName);
  }
  else {
    printWarning("User table exist");
    final userBox = await Hive.openBox(hiveUserTableName);
    if(userBox.isNotEmpty) {
      printWarning("User table not empty");
      if(userBox.length >= 2) {
        printWarning("User table 2 data");
        initialRoute = routeHome;
        currentUser = userBox.getAt((userBox.length - 1)) as User;
        printInfo("Current2: ${currentUser.id}");
      }
      else {
        initialRoute = routeLogin;
      }
    }
    else {
      initialRoute = routeLogin;
    }
  }

  runApp(MyApp(initialRoute: initialRoute,));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(initialRoute: initialRoute,),
    );
  }
}

     