import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:io';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.delivery});
  final Delivery delivery;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Delivery delivery;
  late File pdfFile;

  @override
  void initState() {
    super.initState();
    delivery = widget.delivery;

    //printWarning("Destination date: ${delivery.departDate}");
    //printWarning("Destination hour: ${delivery.departHour}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: GlobalColors.bluecolor,
          centerTitle: true,
          excludeHeaderSemantics: true,
          title: Text(
            'course N° ${delivery.code}',
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
                "${delivery.transactionType}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.Orangecolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Text(
                "course N° ${delivery.code}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontStyle: FontStyle.italic)),
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  Text(
                    "Lieu d'enlèvement :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${delivery.departCity}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              delivery.stopCity?.trim() != '' ? Wrap(
                children: [
                  Text(
                    "Lieu de stop :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${delivery.stopCity}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ) : Container(),
              delivery.stopCity?.trim() != '' ? SizedBox(
                height: 20,
              ) : Container(),
              Wrap(
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
                    "${delivery.destinationCity}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
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
                        "${delivery.destinationDate}",
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
                        "${delivery.destinationHour}",
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
              Wrap(
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
                    "${delivery.carNumber}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
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
                    "${delivery.routeNumber}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
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
                    "${delivery.carType}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              delivery.naturePackages?.trim() != '' ? Wrap(
                children: [
                  Text(
                    "Nature colis :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${delivery.naturePackages}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ) : Container(),
              delivery.naturePackages?.trim() != '' ? SizedBox(
                height: 20,
              ) : Container(),
              delivery.weightPackages?.trim() != '' ? Wrap(
                children: [
                  Text(
                    "Poids :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${delivery.weightPackages} (kg)",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ) : Container(),
              delivery.weightPackages?.trim() != '' ? SizedBox(
                height: 20,
              ) : Container(),
              delivery.packages?.trim() != '' ? Wrap(
                children: [
                  Text(
                    "Liste de colis :",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${delivery.packages}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ) : Container(),
              delivery.packages?.trim() != '' ? SizedBox(
                height: 20,
              ) : Container(),
              Text(
                "Personne à contacter",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 5,
              ),
              Wrap(
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
                    delivery.contactName,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              Wrap(
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
                    delivery.contactPhone,
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
                buildStatus(delivery.status),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.Orangecolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
              onPressed: () async {
                pdfFile = await generatePDF();
                String pdfPath = pdfFile.path;
                await FlutterDownloader.enqueue(
                  url: 'file://$pdfPath',
                  savedDir: '/path/to/download/directory',
                  fileName: 'commande_${delivery.code}.pdf',
                  showNotification: true,
                  openFileFromNotification: true,
                );
              },
              child: Text('Télécharger le PDF'),
            ),
              ElevatedButton(
              onPressed: () async {
                pdfFile = await generatePDF();
                String pdfPath = pdfFile.path;
                await FlutterDownloader.enqueue(
                  url: 'file://$pdfPath',
                  savedDir: '/path/to/download/directory',
                  fileName: 'commande_${delivery.code}.pdf',
                  showNotification: true,
                  openFileFromNotification: true,
                );
              },
              child: Text('Télécharger le PDF'),
            ),
            SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${delivery.createdAt}",
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

  
Future<File> generatePDF() async {
  final pdf = pw.Document();
  // Add the order details to the PDF
  pdf.addPage(pw.Page(
    build: 
    (pw.Context context) => 
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Header(level: 0, text: 'Détails de la commande ${delivery.code} : ${delivery.transactionType}'),
        pw.SizedBox(height: 20),
        pw.Text("Lieu d'enlèvement : ${delivery.departCity}"),
        pw.Text("Lieu de stop : ${delivery.stopCity}"),
        pw.Text("Lieu de destination : ${delivery.destinationCity}"),
        pw.Text("Date : ${delivery.destinationDate}"),
        pw.Text("Heure : ${delivery.destinationHour}"),
        pw.Text("Nombre de vehicule : ${delivery.carNumber}"),
        pw.Text("Nombre de trajet : ${delivery.routeNumber}"),
        pw.Text("Type de camion : ${delivery.carType}"),
        pw.Text("Nature colis : ${delivery.naturePackages}"),
        pw.Text("Poids : ${delivery.weightPackages}"),
        pw.Text("Liste de colis : ${delivery.packages}"),
        pw.SizedBox(height: 10),
        pw.Text("Personne à contacter"),
        pw.Text("Nom & Prenoms : ${delivery.contactName}"),
        pw.Text("Contact : ${delivery.contactPhone}"),
        pw.SizedBox(height: 20),
      ],
    ),
  ));

  // Get the temporary directory to store the PDF file
  final output = await getTemporaryDirectory();
  final file = File('${output.path}/commande_${delivery.code}.pdf');

  // Write the PDF file to disk
  await file.writeAsBytes(await pdf.save());

  return file;
}
}
