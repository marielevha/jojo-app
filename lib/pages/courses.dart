import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/detail.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:google_fonts/google_fonts.dart';


class MesCourses extends StatefulWidget {
  const MesCourses({super.key});

  @override
  State<MesCourses> createState() => _MesCoursesState();
}

class _MesCoursesState extends State<MesCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text('Mes courses',style: GoogleFonts.poppins(),)
      ),
      body: Container(
        color: GlobalColors.Whitecolor,
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return DetailPage();
                }));
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.0,
                  color: Colors.grey.shade300
                )
              ),
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.truckFast,
                          color: GlobalColors.Orangecolor,),
                onPressed: (){},
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    "31/12/2022 (19:50)",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,)),
                    ),
                   Text(
                    "Déménagement / transport de biens personnels",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: GlobalColors.Orangecolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  Text(
                  "course N° 123456789",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontStyle: FontStyle.italic)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "De Abidjan yopougon",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                  ),
                  Text(
                    "A Abidjan abobo",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "le 01/01/2023",
                        style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "à 8h00",
                        style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                        "En cours...",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: GlobalColors.Orangecolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),


            ListTile(
              onTap: (){},
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.0,
                  color: Colors.grey.shade300
                )
              ),
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.truckFast,
                          color: GlobalColors.Orangecolor,),
                onPressed: (){},
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Déménagement / transport de biens personnels",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: GlobalColors.Orangecolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  Text(
                  "course N° 123456789",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontStyle: FontStyle.italic)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "De Abidjan yopougon",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                  ),
                  Text(
                    "A Abidjan abobo",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "le 01/01/2023",
                        style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "à 8h00",
                        style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300
                      )
                    ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                        "Terminé",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}