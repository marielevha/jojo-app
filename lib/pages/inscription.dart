import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:country_picker/country_picker.dart';




class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  bool isHiddenPassword = true;
  bool isHiddenPassword2 = true;
  Icon visibility = Icon(Icons.visibility_off);
  Icon visibility2 = Icon(Icons.visibility_off);

  late String countryValue;
  late String stateValue;
  late String cityValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text("Inscription",style: GoogleFonts.poppins(),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Nom', hintStyle: GoogleFonts.poppins(),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Prenom', hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Adresse',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                      ),
                    ),),
                    SizedBox(
                      height: 5,
                    ),
                    CSCPicker(
                      layout: Layout.vertical,
                      flagState: CountryFlag.ENABLE,
                      onCountryChanged: (country) {
                        setState(() {
                          countryValue = country;
                          print(countryValue);
                        });
                      },
                      onStateChanged: (state) {
                      },
                      onCityChanged: (city) {
                      },
                      countryDropdownLabel: "Pays",
                      stateDropdownLabel: "Region",
                      cityDropdownLabel: "Ville",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration:
                          InputDecoration(hintText: 'Numero de telephone', hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Email', hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: isHiddenPassword,
                      decoration: InputDecoration(
                          hintText: 'Mot de passe',
                          hintStyle: GoogleFonts.poppins(),
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: visibility,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: isHiddenPassword2,
                      decoration: InputDecoration(
                          hintText: 'Repetez le mot de passe',
                          hintStyle: GoogleFonts.poppins(),
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView2,
                            child: visibility2,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginView();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: GlobalColors.Orangecolor,
                    ),
                    child: Text(
                      "S'inscrire",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                        color: GlobalColors.Whitecolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),)
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

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
    if (isHiddenPassword == true) {
      visibility = Icon(Icons.visibility_off);
    } else {
      visibility = Icon(Icons.visibility);
    }
  }

  void _togglePasswordView2() {
    setState(() {
      isHiddenPassword2 = !isHiddenPassword2;
    });
    if (isHiddenPassword2 == true) {
      visibility2 = Icon(Icons.visibility_off);
    } else {
      visibility2 = Icon(Icons.visibility);
    }
  }
}
