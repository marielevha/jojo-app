import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/home.dart';
import 'package:jojo/pages/widgets/form.validate.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

enum TypeVehicule { Petit, Moyen, Grand }

class Demenagement extends StatefulWidget {
  const Demenagement({super.key});

  @override
  State<Demenagement> createState() => _DemenagementState();
}

class Voiture {
  String label;
  Color color;
  Image image;
  Voiture(this.label, this.color, this.image);
}

class _DemenagementState extends State<Demenagement> {
  @override
  void initState() {
    super.initState();
    _date.text = "";
    _valueVehicule = _nbreVehicule[0];
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///////////////////////////Lieu d'enlevement////////////////////////
  late final String _lieuDepart;
  Widget _buildLieuDepart() {
    return TextFormField(
      decoration: const InputDecoration(
          suffixIcon: Icon(
            FontAwesomeIcons.mapLocation,
            color: Colors.blue,
            size: 15,
          ),
          labelText: "Lieu d'enlevement"),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'le lieu de depart est vide';
        }
        return null;
      },
      onSaved: (String? value) {
        _lieuDepart = value!;
      },
    );
  }
  ////////////////////////////////////////////////////////////////////////
  




  //////////////////////////Lieu de destination///////////////////////////
  late final String _lieuDestination;
  Widget _buildLieuDestination() {
    return TextFormField(
      decoration: const InputDecoration(
          suffixIcon: Icon(
            FontAwesomeIcons.mapLocation,
            color: Colors.blue,
            size: 15,
          ),
          labelText: 'Lieu de destination'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'le lieu de destination est vide';
        }
        return null;
      },
      onSaved: (String? value) {
        _lieuDestination = value!;
      },
    );
  }
///////////////////////////////////////////////////////////////////////




  //////////////////////////date de depart///////////////////////////
  late final TextEditingController _date = TextEditingController();
  Widget _buildDate() {
    return SizedBox(
      width: 150,
      child: TextFormField(
        controller: _date,
        decoration: const InputDecoration(
            suffixIcon: Icon(
              FontAwesomeIcons.calendar,
              color: Colors.blue,
              size: 15,
            ),
            labelText: "Date"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            String formatDate = DateFormat("dd-MM-yyyy").format(pickedDate);
            setState(() {
              _date.text = formatDate.toString();
            });
          } else {
            print('Date non definie');
          }
        },
      ),
    );
  }
//////////////////////////////////////////////////////////////////////





  ///////////////////////////heure de depart/////////////////////////////
  late final TextEditingController _heure = TextEditingController();
  Widget _buildHeure() {
    return SizedBox(
      width: 100,
      child: TextFormField(
        controller: _heure,
        decoration: const InputDecoration(
            suffixIcon: Icon(
              FontAwesomeIcons.clock,
              color: Colors.blue,
              size: 15,
            ),
            labelText: "Heure"),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
              context: context, initialTime: TimeOfDay(hour: 9, minute: 0));
          if (pickedTime != null) {
            String formatTime =
                '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
            setState(() {
              _heure.text = formatTime;
            });
          } else {
            print('heure non definie');
          }
        },
      ),
    );
  }
///////////////////////////////////////////////////////////////////




  ///////////////////////nombre de vehicule////////////////////////
  late final List _nbreVehicule = ["1", "2", "3", "4", "5"];
  late String? _valueVehicule = "1";
  Widget _buildNbreVehicule() {
    return SizedBox(
      width: 170,
      child: DropdownButtonFormField(
        value: _valueVehicule,
        items: _nbreVehicule
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _valueVehicule = val as String;
          });
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.blue,
        ),
        decoration: InputDecoration(
          labelText: "Nombre de vehicule",
        ),
      ),
    );
  }
  ////////////////////////////////////////////////////////////////
  



  /////////////////////////nombre de trajet///////////////////////
  late final List _nbreTrajet = ["1", "2", "3", "4", "5"];
  late String? _valueTrajet = "1";
  Widget _buildTrajet() {
    return SizedBox(
      width: 150,
      child: DropdownButtonFormField(
        value: _valueTrajet,
        items: _nbreTrajet
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _valueTrajet = val as String;
          });
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.blue,
        ),
        decoration: InputDecoration(
          labelText: "Nombre de Trajet",
        ),
      ),
    );
  }
/////////////////////////////////////////////////////////////////


///////////////////////////Lieu d'arret////////////////////////
  late final String _lieuArret;
  Widget _buildLieuArret() {
    return TextFormField(
      decoration: const InputDecoration(
          suffixIcon: Icon(
            FontAwesomeIcons.mapLocation,
            color: Colors.blue,
            size: 15,
          ),
          labelText: "Ajouter un stop en cours de trajet"),
      onSaved: (String? arret) {
        if(arret == null){
          _lieuArret = 'Pas de stop';
        }else{
          _lieuArret = arret;
          print(_lieuArret);
        }
        
      },
    );
  }
  ////////////////////////////////////////////////////////////////////////
  

//////////////////////////Type de vehicule////////////////////////

List<bool> select = [true, false, false];
List<String> _typeVoiture = ['Petit', 'Moyen', 'Grand'];
TextEditingController _typeDeVoiture = TextEditingController();
late int selectedIndex = 0;
  late List<Voiture> _chipsList = [
    Voiture(
      "Petit",
      Colors.blue,
      Image(
        image: AssetImage('assets/images/camionpetit.png'),
        height: 20,
      ),
    ),
    Voiture(
      "Moyen",
      Colors.blue,
      Image(
        image: AssetImage('assets/images/camionmoyen.png'),
        height: 20,
      ),
    ),
    Voiture(
      "Grand",
      Colors.blue,
      Image(
        image: AssetImage('assets/images/camiongrand.png'),
        height: 20,
      ),
    ),
  ];

  Widget _buildTypeVehicule(){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
              "Type de camion",
              style: TextStyle(color: Colors.grey),
            ),
                
            
            SizedBox(
              height: 10,
            ),


          ToggleButtons(
            isSelected: select,
            borderColor: Colors.grey,
            fillColor: GlobalColors.Orangecolor,
            color: GlobalColors.Blackcolor,
            selectedColor: GlobalColors.Whitecolor,
            splashColor: Colors.amber[700],
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/camionpetit.png'),
                      height: 50,
                    ),
                    Text(_typeVoiture[0], style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),),
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/camionmoyen.png'),
                      height: 50,
                    ),
                    Text(_typeVoiture[1], style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/camiongrand.png'),
                      height: 50,
                    ),
                    Text(_typeVoiture[2], style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),),
                  ],
                ),
              ),
            ], 
            onPressed: (int newIndex){
              
                setState(() {
                  for(int index = 0 ; index < select.length; index++ ){
                    if(index == newIndex){
                      select[index] = true;
                      _typeDeVoiture.text = _typeVoiture[index];
                    } else {
                      select[index] = false;
                    }
                  }
                });
              
            },
          ),
        ],
      ),
    );
  }
///////////////////////////////////////////////////////////////////


  //////////////////////////Personne à contacter////////////////////////
  late final String _nomPrenom;
  Widget _buildPersonContact(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              "Personne à contacter",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Nom & prenoms', hintStyle: GoogleFonts.poppins(),),
          validator: (String? nom) {
            if (nom!.isEmpty) {
            return 'le champ est vide';
            }
            return null;
          },
          onSaved: (String? nom) {
            _nomPrenom = nom!;
          },
        ),
      ],
    );
  }
//////////////////////////////////////////////////////////////////



  //////////////////////////numero de telephone/////////////////////////////////////
  late final String _numero;
  Widget _buildNumero() {
    return SizedBox(
      width: 200,
      child: TextFormField(
        decoration: const InputDecoration(
          suffixIcon: Icon(
            FontAwesomeIcons.phone,
            color: Colors.blue,
            size: 15,
          ),
          labelText: 'Numero de telephone',
        ),
        maxLength: 10,
        keyboardType: TextInputType.phone,
        validator: (String? value) {
          int? numero = int.tryParse(value!);

          if (numero == null || value.length < 10) {
            return 'Remplir le champ numero de telephone';
          }
          return null;
        },
        onSaved: (String? value) {
          _numero = value!;
        },
      ),
    );
  }
  //////////////////////////////////////////////////////////////
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text(
           "Déménagement / transport de biens personnels",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Center(
          child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 35,
                  ),
                  _buildLieuDepart(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildLieuDestination(),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: <Widget>[
                      _buildDate(),
                      SizedBox(
                        width: 50,
                      ),
                      _buildHeure()
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: <Widget>[
                     _buildNbreVehicule(),
                      SizedBox(
                        width: 50,
                      ),
                      _buildTrajet(),
                    ],
                  ),
                  
                  SizedBox(
                    height: 25,
                  ),
                  _buildLieuArret(),
                   SizedBox(
                    height: 35,
                  ),
                  _buildTypeVehicule(),
                  SizedBox(
                    height: 50,
                  ),
                  _buildPersonContact(),
                  _buildNumero(),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: GlobalColors.Orangecolor,
                        ),
                        child: Text(
                          "VALIDER",
                          style: TextStyle(
                            color: GlobalColors.Whitecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget okBtn = ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          _formKey.currentState!.save();
          FormDetails formDetails = FormDetails();
          formDetails.lieuDeDepart = _lieuDepart;
          formDetails.lieuDestination = _lieuDestination;
          formDetails.dateDepart = _date.text;
          formDetails.heureDepart = _heure.text;
          formDetails.nombreVehicule = _valueVehicule!;
          formDetails.nombreTrajet = _valueTrajet!;
          formDetails.lieuDarret =_lieuArret;
          formDetails.typeVoiture = _typeDeVoiture.text;
          formDetails.nomPrenom =  _nomPrenom;
          formDetails.numero = _numero;
          print('Details du formulaire de demenagement et transport de bien public');
          print("Lieu d'enlevement: " + _lieuDepart);
          print("Lieu de destination: " + _lieuDestination);
          print("Date: " + _date.text);
          print("Heure: " + _heure.text);
          print('Nombre de vehicule: ' '$_valueVehicule');
          print('Nombre de trajet: ' '$_valueTrajet');
          print("Lieu d'arret: " + _lieuArret);
          print("Type de camion: " + _typeDeVoiture.text);
          print("Personne à contacter: " + _nomPrenom);
          print("Numero de tel: " + _numero);
          /*showDialog(
            context: context, 
            builder: (context) => FutureProgressDialog(
              Future.delayed(Duration(seconds: 5), (){
                Get.to(HomePage());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Vous serez contacté dans les minutes qui suivent par nos assistants en ligne"),
              behavior: SnackBarBehavior.floating,
            ));
              }),
              message: Text("envoi du formulaire"),
              
            ),
          );*/
          Timer(const Duration(seconds: 2), () {
            Get.to(HomePage());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Stack(
                clipBehavior: Clip.none,
                children:[Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nous vous remercions d'avoir validé votre commande. Le service client de Jojo vous recontactera dans les minutes qui suivent pour une meilleure prise en charge de votre commande.",
                        maxLines: 5,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                        ),
                      ),
                    ],
                  )
                ),] 
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ));
          });
        },
        child: Text("Confirmer"));

    Widget cancelBtn = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Annuler"));
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation du formulaire"),
      content: Text("Êtes-vous sûr d'avoir entré les informations correctes ?"),
      actions: [
        okBtn,
        cancelBtn,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext buildercontext) {
          return alert;
        });
  }
}
