import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/utils/global.colors.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: GlobalColors.bluecolor,
          centerTitle: true,
          excludeHeaderSemantics: true,
          title: Text(
            'course N° 123456789',
            style: GoogleFonts.poppins(),
          )),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Déménagement / transport de biens personnels",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.Orangecolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Text(
                "course N° 123456789",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontStyle: FontStyle.italic)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Lieu d'enlèvement:",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Abidjan yopougon",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Lieu de stop:",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "non",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Lieu de destination :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Abidjan abobo",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "Date :",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "01/01/2023",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Heure :",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "08h00",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Nombre de vehicule :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "1",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Nombre de trajet :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "1",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Type de camion :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "petit",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Personne à contacter",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "Nom & Prenoms :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Lamine Mohamed",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Contact :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "0786543499",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "En cours...",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.Orangecolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "31/12/2022 (19:50)",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontStyle: FontStyle.italic)),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
