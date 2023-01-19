import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/pages/detail.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';

class DisplayDoc extends StatefulWidget {
  const DisplayDoc({
    super.key,
    required this.deliveries,
  });

  final List<Delivery> deliveries;

  @override
  _DisplayDocState createState() => _DisplayDocState();
}

class _DisplayDocState extends State<DisplayDoc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: EdgeInsets.all(defaultSize * 0.1),
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.deliveries == null ? 0 : widget.deliveries.length,
        itemBuilder: (context, index) {
          Delivery delivery = widget.deliveries[index];
          return ListTile(
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return DetailPage(delivery: delivery);
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
                  "${delivery.departDate} (${delivery.departHour})",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,)),
                ),
                Text(
                  delivery.transactionType,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: GlobalColors.Orangecolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  //"course N° 123456789",
                  "course N° ${delivery.code}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontStyle: FontStyle.italic
                      ),
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  "De ${delivery.departCity}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                Text(
                  "A ${delivery.destinationCity}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "le ${delivery.destinationDate}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                    const SizedBox(width: 3,),
                    Text(
                      "à ${delivery.destinationHour}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w300
                        ),
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
                        buildStatus(delivery.status),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: GlobalColors.Orangecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10,)
              ],
            ),
          );
          /*return Container(
            margin: EdgeInsets.symmetric(vertical: defaultSize * 0.1),
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 15.0,
                        left: 0,
                        right: 0,
                        child: Container(
                          //padding: EdgeInsets.all(20),
                          padding: EdgeInsets.only(left: 24, top: 24, right: 24),
                          //height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 33,
                                color: SHADOW_COLOR.withOpacity(.84),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: size.width * 0.5,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: TERTIARY_TEXT_COLOR),
                                    children: [
                                      TextSpan(
                                        text:
                                        '${delivery.title} \n',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${delivery.author} \n',
                                        style: TextStyle(color: SECONDARY_TEXT_COLOR),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 110,),
                              Row(
                                children: <Widget>[
                                  BookRating(
                                    score: delivery.rating,
                                    document: document,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: RoundedButton(
                                      text: READ_TEXT,
                                      verticalPadding: 10,
                                      press: () {
                                        Navigator.pushNamed(context, documentDetailsRoute, arguments: document);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 100,),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      favoriteRemote
                          ? FutureBuilder(
                          future: checkInternetAccess(),
                          builder: (context, snapshot) {
                            if(snapshot.data == null || !snapshot.data) {
                              return displayMemoryImage(
                                top: 15,
                                right: 0,
                                bottom: 15,
                                document : document,
                                readPress: () {
                                  Navigator.pushNamed(context, documentDetailsRoute, arguments: document);
                                },
                              );
                            }
                            else if(snapshot.data && snapshot.hasData) {
                              return Positioned(
                                top: 15,
                                right: 0,
                                bottom: 15,
                                child: GestureDetector(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/spinner.gif",
                                    image: delivery.image,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, documentDetailsRoute, arguments: document);
                                  },
                                ),
                              );
                            }
                            else {
                              return displayMemoryImage(
                                top: 15,
                                right: 0,
                                bottom: 15,
                                document : document,
                                readPress: () {
                                  Navigator.pushNamed(context, documentDetailsRoute, arguments: document);
                                },
                              );
                            }
                          }
                      )
                      /*Positioned(
                        top: 0,
                        right: 0,
                        //bottom: 0,
                        child: Image.asset(
                          BOOK_ASSET,
                          width: 150,
                          //height: 90,
                          fit: BoxFit.fitWidth,
                        ),
                      )*/
                          : displayMemoryImage(
                        top: 15,
                        right: 0,
                        bottom: 15,
                        document : document,
                        readPress: () {
                          Navigator.pushNamed(context, documentDetailsRoute, arguments: document);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );*/
        },
      ),
    );
  }

}
