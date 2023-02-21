import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jojo/pages/courses.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/demenagement2.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/pages/profil.dart';
import 'package:jojo/pages/transportcolis2.dart';
import 'package:jojo/pages/widgets/menu_item.dart' as mw;
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/menu.items.dart';
import 'package:share_plus/share_plus.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
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
              PopupMenuButton<mw.MenuItem>(
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
                        return Demenagement2();
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
                            return TransportColis2();
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
   case MenuItems.itemConnection:
      Get.off(LoginView());
      break;

    case MenuItems.itemShare:
      Share.share("Partagez l'application");
      break;
  }
}
