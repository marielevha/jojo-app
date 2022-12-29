//import 'package:flutter/material.dart';
import 'package:jojo/pages/widgets/menu_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemCourse,
    itemProfil,
    itemShare
  ];
  
  static const itemCourse = MenuItem(
    text: 'Mes courses',
    icon: FontAwesomeIcons.truckFast,
  );

  static const itemProfil = MenuItem(
    text: 'Profil',
    icon: FontAwesomeIcons.solidUser,
  );

  static const itemShare = MenuItem(
    text: 'Partager',
    icon: FontAwesomeIcons.share,
  );
}