import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveService {
  isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  addBoxes<T>(List<T> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);

    for (var item in items) {
      openBox.add(item);
    }
  }

  createBox({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    return openBox;
  }

  getBoxes<T>(String boxName) async {
    List<T> boxList = <T>[];
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }
    return boxList;
  }

  clearBox({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.clear();
  }

  deleteAll({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.deleteAll(openBox.keys);
  }

  hasBox({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.isOpen;
  }
}