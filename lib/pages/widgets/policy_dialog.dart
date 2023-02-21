import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/utils/global.colors.dart';

class PolicyDialog extends StatelessWidget {
  const PolicyDialog({
    Key? key, 
    this.radius = 8, 
    required this.mdFileName, 
    }) :super(key: key);

  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      ),
      child:Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then((value){
                return rootBundle.loadString('assets/fichiers/$mdFileName');
              }),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Markdown(
                    data: snapshot.data.toString(),
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },
            )
          ),
          MaterialButton(
            padding: EdgeInsets.all(0),
            color: GlobalColors.Orangecolor,
            onPressed: () => Navigator.of(context).pop(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                )
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                "Fermer",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.Whitecolor
                  )
                ),
              ) ,
            ),
          )
        ],
      ) ,
    );
  }
}