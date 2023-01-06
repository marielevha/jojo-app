import 'dart:io';

import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/services/api/delivery.api.dart';
import 'package:jojo/services/hive/hive_service.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/locator.dart';
import 'package:stacked/stacked.dart';

class DeliveryViewModel extends BaseViewModel {
  final HiveService hiveService = locator<HiveService>();
  final DeliveryApi deliveryApi = locator<DeliveryApi>();

  bool _testFindDeliveries = false;
  bool get testFindDeliveries => _testFindDeliveries;
  List<Delivery> _deliveriesList = [];
  List<Delivery> get deliveriesList => _deliveriesList;
  findDeliveriesByUserId({required int page}) async {
    try {
      var checkInternet = await InternetAddress.lookup('www.google.com');
      if (checkInternet.isNotEmpty && checkInternet[0].rawAddress.isNotEmpty) {
        _testFindDeliveries = true;
        setBusy(true);
        _deliveriesList = await deliveryApi.findDeliveriesByUserId(id: currentUser.id, page: page);

        var clearResult = await hiveService.clearBox(boxName: hiveDeliveryTableName);
        printWarning('CLEAR BOX : $clearResult');

        await hiveService.addBoxes(_deliveriesList, hiveDeliveryTableName);
        setBusy(false);
        _testFindDeliveries = false;
      }
    }
    catch(_) {
      _testFindDeliveries = false;
      bool exists = await hiveService.isExists(boxName: hiveDeliveryTableName);
      if (exists) {
        setBusy(true);
        List<dynamic> dynamicList = await hiveService.getBoxes(hiveDeliveryTableName);

        _deliveriesList = dynamicList
            .map((data) => data as Delivery)
            .toList();
        setBusy(false);
      }
    }


  }

  /*bool _testFindLikedDoc = false;
  bool get testFindLikedDoc => _testFindLikedDoc;
  List<Document> _likedDocuments = [];
  List<Document> get likedDocuments => _likedDocuments;
  findLikedDocuments() async {
    try {
      var checkInternet = await InternetAddress.lookup('www.google.com');
      if (checkInternet.isNotEmpty && checkInternet[0].rawAddress.isNotEmpty) {
        _testFindLikedDoc = true;
        setBusy(true);
        _likedDocuments = await deliveryApi.findLikedDocuments();

        await hiveService.clearBox(boxName: DOCUMENTS_LIKED_TABLE);

        await hiveService.addBoxes(_likedDocuments, DOCUMENTS_LIKED_TABLE);
        setBusy(false);
        _testFindLikedDoc = false;
      }
    }
    on SocketException catch(_) {
      _testFindLikedDoc = false;
      bool exists = await hiveService.isExists(boxName: DOCUMENTS_LIKED_TABLE);
      if (exists) {
        setBusy(true);
        List<dynamic> _dynamicList = await hiveService.getBoxes(DOCUMENTS_LIKED_TABLE);

        _likedDocuments = _dynamicList
            .map((doc) => doc as Document)
            .toList();
        setBusy(false);
      }
    }

  }*/

  /*bool _testFindDoc = false;
  bool get testFindDoc => _testFindDoc;
  List<Document> _dataDocuments = [];
  List<Document> get dataDocuments => _dataDocuments;
  findDocuments({int page = 0, int size = RESPONSE_SIZE * 100, String query, int series, int subject}) async {
    try {
      var checkInternet = await InternetAddress.lookup('www.google.com');
      if (checkInternet.isNotEmpty && checkInternet[0].rawAddress.isNotEmpty) {
        _testFindDoc = true;
        setBusy(true);
        _dataDocuments = await deliveryApi.findDocuments(
            page: page,
            size: size,
            query: query,
            series: series,
            subject: subject
        );

        await hiveService.clearBox(boxName: DOCUMENTS_TABLE);

        await hiveService.addBoxes(_dataDocuments, DOCUMENTS_TABLE);
        setBusy(false);
        _testFindDoc = false;
      }
    }
    on SocketException catch(_) {
      printError('SERVER DOWN');
      _testFindDoc = false;
      bool exists = await hiveService.isExists(boxName: DOCUMENTS_TABLE);
      if (exists) {
        setBusy(true);
        List<dynamic> _dynamicList = await hiveService.getBoxes(DOCUMENTS_TABLE);

        _dataDocuments = _dynamicList
            .map((doc) => doc as Document)
            .toList();
        setBusy(false);
      }
    }*/

    /*var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile || connectivityResult != ConnectivityResult.wifi) {
      }
    }*/
}