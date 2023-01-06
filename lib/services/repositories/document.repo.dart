/*import 'dart:io';
import 'package:prepa_bac/helpers/constants.helper.dart';
import 'package:prepa_bac/helpers/functions.helper.dart';
import 'package:prepa_bac/helpers/locator.dart';
import 'package:prepa_bac/helpers/strings.helper.dart';
import 'package:prepa_bac/models/document/document.dart';
import 'package:prepa_bac/models/series/series.dart';
import 'package:prepa_bac/models/subject/subject.dart';
import 'package:prepa_bac/services/api/document-api.dart';
import 'package:prepa_bac/services/hive/hive_service.dart';
import 'package:stacked/stacked.dart';

class DocumentRepository extends BaseViewModel {
  final HiveService hiveService = locator<HiveService>();
  final DocumentApi documentApi = locator<DocumentApi>();

  //Series
  List<Series> _series = [];
  List<Series> get series => _series;
  findSeries() async {
    try {
      var checkInternet = await InternetAddress.lookup('www.google.com');
      if (checkInternet.isNotEmpty && checkInternet[0].rawAddress.isNotEmpty) {
        setBusy(true);
        _series = await documentApi.findSeries();

        await hiveService.clearBox(boxName: SERIES_TABLE);

        await hiveService.addBoxes(_series, SERIES_TABLE);
        setBusy(false);
      }
    }
    on SocketException catch(_) {
      bool exists = await hiveService.isExists(boxName: SERIES_TABLE);
      if (exists) {
        setBusy(true);
        List<dynamic> _dynamicList = await hiveService.getBoxes(SERIES_TABLE);
        _series = _dynamicList
            .map((data) => data as Series)
            .toList();
        setBusy(false);
      }
    }
  }

  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;
  findSubjects() async {
    try {
      var checkInternet = await InternetAddress.lookup('www.google.com');
      if (checkInternet.isNotEmpty && checkInternet[0].rawAddress.isNotEmpty) {
        setBusy(true);
        _subjects = await documentApi.findSubjects(
          page: 0,
          perPage: 10,
          columnSort: 0,
          sort: 'desc',
          series: currentUser.series
        );

        await hiveService.clearBox(boxName: SUBJECTS_SOLO_TABLE);

        await hiveService.addBoxes(_subjects, SUBJECTS_SOLO_TABLE);
        setBusy(false);
      }
    }
    on SocketException catch(_) {
      bool exists = await hiveService.isExists(boxName: SUBJECTS_SOLO_TABLE);
      if (exists) {
        setBusy(true);
        List<dynamic> _dynamicList = await hiveService.getBoxes(SUBJECTS_SOLO_TABLE);
        _subjects = _dynamicList
            .map((data) => data as Subject)
            .toList();
        setBusy(false);
      }
    }
  }

  List<Document> _documents = [];
  List<Document> get bestDocOfTheWeek => _documents;
  findBestDocOfTheWeek() async {
    try {
      var checkInternet = await InternetAddress.lookup('www.google.com');
      if (checkInternet.isNotEmpty && checkInternet[0].rawAddress.isNotEmpty) {
        setBusy(true);
        //_document.add(await documentApi.findBestDocOfTheWeek());
        Document doc = await documentApi.findBestDocOfTheWeek();
        _documents.add(doc);
        //printWarning(doc.toString());

        await hiveService.clearBox(boxName: DOCUMENTS_BEST_WEEK_TABLE);

        await hiveService.addBoxes(_documents, DOCUMENTS_BEST_WEEK_TABLE);
        setBusy(false);
      }
    }
    on SocketException catch(_) {
      bool exists = await hiveService.isExists(boxName: DOCUMENTS_BEST_WEEK_TABLE);
      if (exists) {
        setBusy(true);
        List<dynamic> _dynamicList = await hiveService.getBoxes(DOCUMENTS_BEST_WEEK_TABLE);
        _documents = _dynamicList
            .map((data) => data as Document)
            .toList();
        setBusy(false);
      }
    }
  }
}*/