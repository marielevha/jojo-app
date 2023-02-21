import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/utils/global.colors.dart';

class Politique extends StatelessWidget {
  const Politique({super.key,required this.mdFileName});
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text('Politique de confidentialité',style: GoogleFonts.poppins(),)
      ),
      body: Column(
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
        ],
      ),
    );
  }
}