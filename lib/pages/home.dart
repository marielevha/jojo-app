import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jojo/pages/courses.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/demenagement.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/pages/profil.dart';
import 'package:jojo/pages/transportcolis.dart';
import 'package:jojo/pages/widgets/menu_item.dart' as mw;
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/menu.items.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/image1.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: GlobalColors.bluecolor,
          centerTitle: true,
          title: const Image(
            image: AssetImage('assets/logos/jojoblancorange.png'),
            height: 50,
          ),
          actions: [
            currentUser.id != 0 ? PopupMenuButton<mw.MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context2) => [
                ...MenuItems.menuWithConnection.map(buildItem).toList(),
                //...MenuItems.itemsFirst.fi,
              ],
            )
            : PopupMenuButton<mw.MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context2) => [
                ...MenuItems.menuWithoutConnection.map(buildItem).toList(),
                //...MenuItems.itemsFirst.fi,
              ],
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Demenagement();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: GlobalColors.Orangecolor,
                  ),
                  child: Text(
                    "Déménagement / transport de biens personnels",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: GlobalColors.Whitecolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ),
              ),

              SizedBox(
                height: 50,
              ),

              SizedBox(
                width: 300,
                height: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return TransportColis();
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: GlobalColors.Orangecolor,
                  ),
                  child: Text(
                    "Transport de colis volumineux",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: GlobalColors.Whitecolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PopupMenuItem<mw.MenuItem> buildItem(mw.MenuItem item) => PopupMenuItem<mw.MenuItem>(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, color: GlobalColors.bluecolor, size: 20),
          const SizedBox(width: 12),
          Text(
            item.text,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: GlobalColors.bluecolor,
              fontWeight: FontWeight.w400,
            )),
          ),
        ],
      ),
    );

void onSelected(BuildContext context, mw.MenuItem item) {
  switch (item) {
    case MenuItems.itemCourse:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MesCourses();
      }));
      break;

    case MenuItems.itemProfil:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Profil();
      }));
      break;

    case MenuItems.itemConnection:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginView();
      }));
      break;

    case MenuItems.itemShare:
      Share.share("Partagez l'application");
      break;
  }
}
