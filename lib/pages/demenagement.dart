import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/models/voucher/voucher.dart';
import 'package:jojo/pages/home.dart';
import 'package:jojo/pages/maps/location.screen.dart';
import 'package:jojo/pages/widgets/form.validate.dart';
import 'package:jojo/services/api/delivery.api.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:jojo/utils/locator.dart';

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

  final DeliveryApi deliveryApi = locator<DeliveryApi>();

  bool isLoading = false;
  Delivery delivery = Delivery.init();
  late int reduction = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lieuDepartController = TextEditingController();
  final TextEditingController lieuStopController = TextEditingController();
  final TextEditingController lieuDestinationController = TextEditingController();
  final TextEditingController voucherController = TextEditingController();
  late final TextEditingController dateController = TextEditingController();
  late final TextEditingController hourController = TextEditingController();
  final TextEditingController carTypeController = TextEditingController();


  @override
  void initState() {
    super.initState();
    dateController.text = "";
    _valueVehicule = _nbreVehicule[0];

    delivery.voucher = '';
    delivery.routeNumber = 1;
    delivery.carNumber = 1;
    delivery.carType = "Petit";
    delivery.house = 'Appartement';
    delivery.bedroomsNumber = 1;
    delivery.transactionType = kTransactionTypeOne;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///////////////////////////Lieu d'enlevement////////////////////////
  late final String _lieuDepart;
  Widget _buildLieuDepart() {
    return TextFormField(
      controller: lieuDepartController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () async {
            //Open map
            printWarning("Open map depart");
            var location = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) { return const SearchPlacesScreen(); })
            );
            if(location != null) {
              location as LatLng;
              delivery.departLat = location.latitude.toString();
              delivery.departLng = location.longitude.toString();

              Placemark placeMark = await getAddressFromLatLng(context, location.latitude, location.longitude);

              setState(() {
                lieuDepartController.text = "${placeMark.street!}, ${placeMark.locality!}";
                _lieuDepart = lieuDepartController.text.trim();
                delivery.departCity = lieuDepartController.text.trim();
              });

              printWarning("Lieu depart: $_lieuDepart");
              //printWarning("Address: ${placeMark.street!} | ${placeMark.locality!}");


            }
          },
          icon: const Icon(
              FontAwesomeIcons.mapLocation,
              color: Colors.blue,
              size: 15,
            )
        ),
        labelText: "Lieu d'enlevement"
      ),
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
      controller: lieuDestinationController,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () async {
                //Open map
                printWarning("Open map destination");
                var location = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) { return const SearchPlacesScreen(); })
                );
                if(location != null) {
                  location as LatLng;
                  delivery.destinationLat = location.latitude.toString();
                  delivery.destinationLng = location.longitude.toString();

                  Placemark placeMark = await getAddressFromLatLng(context, location.latitude, location.longitude);

                  setState(() {
                    lieuDestinationController.text = "${placeMark.street!}, ${placeMark.locality!}";
                    _lieuDestination = lieuDestinationController.text.trim();
                    delivery.destinationCity = lieuDestinationController.text.trim();
                  });

                  printWarning("Lieu destination: $_lieuDestination");
                }
              },
              icon: const Icon(
                FontAwesomeIcons.mapLocation,
                color: Colors.blue,
                size: 15,
              )
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

  Widget _buildDate() {
    return SizedBox(
      width: 150,
      child: TextFormField(
        controller: dateController,
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
            String formatDate = DateFormat("dd/MM/yyyy").format(pickedDate);
            //printWarning("Date ${formatDate.toString()}");
            setState(() {
              dateController.text = formatDate.toString();
              delivery.departDate = formatDate.toString();
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
  Widget _buildHeure() {
    return SizedBox(
      width: 100,
      child: TextFormField(
        controller: hourController,
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
            //printWarning("Date ${formatTime.toString()}");
            setState(() {
              hourController.text = formatTime;
              delivery.departHour = formatTime;
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
            printError("val $val");
            _valueVehicule = val as String;
            delivery.carNumber = int.parse(val);
            printError("text: ${delivery.carNumber}");
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
            delivery.routeNumber = int.parse(val);
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
      controller: lieuStopController,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () async {
                //Open map
                printWarning("Open map stop");
                var location = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) { return const SearchPlacesScreen(); })
                );
                if(location != null) {
                  location as LatLng;
                  delivery.stopLat = location.latitude.toString();
                  delivery.stopLng = location.longitude.toString();

                  Placemark placeMark = await getAddressFromLatLng(context, location.latitude, location.longitude);

                  setState(() {
                    lieuStopController.text = "${placeMark.street!}, ${placeMark.locality!}";
                    _lieuArret = lieuStopController.text;
                    delivery.stopCity = lieuStopController.text.trim();
                  });

                  printWarning("Lieu stop: $_lieuArret");
                }
              },
              icon: const Icon(
                FontAwesomeIcons.mapLocation,
                color: Colors.blue,
                size: 15,
              )
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
                      carTypeController.text = _typeVoiture[index];

                      printWarning("CAR TYPE: ${carTypeController.text}");
                      delivery.carType = carTypeController.text.trim();
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
          controller: nameController,
          decoration: InputDecoration(
            hintText: /*currentUser != null ? currentUser.name :*/ 'Nom & prenoms',
            hintStyle: GoogleFonts.poppins(),
          ),
          validator: (String? nom) {
            if (nom!.isEmpty) {
              return 'le champ est vide';
            }
            return null;
          },
          onSaved: (String? nom) {
            printWarning("Contact name: ${nameController.text}");
            _nomPrenom = nom!;
            delivery.contactName = nameController.text.trim();
          },
          onChanged: (String? nom) {
            printWarning("Contact name: ${nameController.text}");
            delivery.contactName = nameController.text.trim();
          },
        ),
      ],
    );
  }
//////////////////////////////////////////////////////////////////


  ////////////////////////////Type de maison///////////////////////////
  late final List _Maisons = ["Appartement", "Maison basse", "Duplex", "Triplex"];
  late String? _valueMaisons = "Appartement";
  Widget _TypeDeMaison() {
    return SizedBox(
      child: DropdownButtonFormField(
        value: _valueMaisons,
        items: _Maisons
            .map((e) => DropdownMenuItem(
          child: Text(e),
          value: e,
        ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _valueMaisons = val as String;
            print(_valueMaisons);
            delivery.house = val;
          });
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.blue,
        ),
        decoration: InputDecoration(
          labelText: "Type de maison",
        ),
      ),
    );
  }
/////////////////////////////////////////////////////////////////////


////////////////////////////Nombre de piece///////////////////////////
  late final List _NbrePiece = ["1", "2", "3", "4","5","6","7","8","9","10"];
  late String? _valuePieces = "1";
  Widget _NbreDePieces() {
    return SizedBox(
      child: DropdownButtonFormField(
        value: _valuePieces,
        items: _NbrePiece
            .map((e) => DropdownMenuItem(
          child: Text(e),
          value: e,
        ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _valuePieces = val as String;
            print(_valuePieces);
            printWarning("Nombre de pieces: ${_valuePieces}");
            delivery.bedroomsNumber = int.parse(val);
          });
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.blue,
        ),
        decoration: InputDecoration(
          labelText: "Nombre de pièces",
        ),
      ),
    );
  }
/////////////////////////////////////////////////////////////////////

//////////////////////////Code promo////////////////////////
  late final String _codePromo;
  Widget _buildCodePromo() {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: voucherController,
                decoration: InputDecoration(
                  hintText: 'Appliquez un coupon',
                  hintStyle:
                  GoogleFonts.poppins(textStyle: TextStyle(fontSize: 10)),
                ),
                onSaved: (String? code) {
                  _codePromo = code!;
                },
                maxLength: 6,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: 100,
            height: 40,
            child: ElevatedButton(
              onPressed: isLoading ? null : () async {
                if(voucherController.text != '' && voucherController.text.length == 6) {
                  _codePromo = voucherController.text.toUpperCase();
                  Voucher voucher = await checkVoucher(_codePromo);
                  if(voucher.id != 0) {
                    printWarning("ACTIVE VOUCHER: $_codePromo");
                    reduction = voucher.value;
                    delivery.voucher = _codePromo;
                  }
                  else {
                    _codePromo = voucherController.text = '';
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: GlobalColors.Orangecolor,
              ),
              child: Text(
                "Appliquer",
                style: TextStyle(
                  color: GlobalColors.Whitecolor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
        controller: phoneController,
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
          printWarning("Contact phone: ${phoneController.text}");
          _numero = value!;
          delivery.contactPhone = phoneController.text.trim();
        },
        onChanged: (String? value) {
          printWarning("Contact phone: ${phoneController.text}");
          delivery.contactPhone = phoneController.text.trim();
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
                alignment: Alignment.center,
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
                      _TypeDeMaison(),
                      SizedBox(
                        height: 50,
                      ),
                      _NbreDePieces(),
                      SizedBox(
                        height: 25,
                      ),
                      _buildCodePromo(),
                      SizedBox(
                        height: 40,
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
        onPressed: () async {
          /*if (!_formKey.currentState!.validate()) {
            return;
          }
          _formKey.currentState!.save();*/
          /*FormDetails formDetails = FormDetails();
          formDetails.lieuDeDepart = _lieuDepart;
          formDetails.lieuDestination = _lieuDestination;
          formDetails.dateDepart = _date.text;
          formDetails.heureDepart = _heure.text;
          formDetails.nombreVehicule = _valueVehicule!;
          formDetails.nombreTrajet = _valueTrajet!;
          formDetails.lieuDarret =_lieuArret;
          formDetails.typeVoiture = _typeDeVoiture.text!;
          formDetails.nomPrenom =  _nomPrenom;
          formDetails.numero = _numero;*/

          delivery.userId = currentUser.id;
          delivery.userEmail = currentUser.email;
          delivery.contactName = nameController.text;
          delivery.contactPhone = phoneController.text;

          printWarning(delivery.house!);
          printWarning("${delivery.bedroomsNumber}");
          //delivery.departHour = null;
          //delivery.departDate = null;
          //delivery.departCity = null;
          //delivery.departLat = null;
          //delivery.departLng = null;
          printWarning("Car number: ${delivery.carNumber}");
          printWarning("[DELIVERY]: $delivery");
          createDelivery(delivery);
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
          Timer(const Duration(seconds: 3600), () {
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


  Future<Placemark> getAddressFromLatLng(context, double lat, double lng) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);

    /*for (var element in placeMarks) {
      printWarning(element);
    }*/
    return placeMarks.first;

    //return placeMarks;
  }

  Future<void> createDelivery(Delivery delivery) async {
    var isConnected = await checkInternetAccess();
    //if (validate()) {
    if(isConnected) {
      setState(() {
        isLoading = true;
      });

      try {
        printWarning("DELIVERY: $delivery");
        delivery = await deliveryApi.createDelivery(delivery: delivery);
        printWarning("DELIVERY CREATED");
      }
      catch (err) {
        setState(() {
          isLoading = false;
        });
        printError(err);
      }
    }
    else {
      /*showToast(
          fToast: _fToast,
          message: NOT_INTERNET_ACCESS_MESSAGE,
          color: Colors.yellow,
          duration: 5,
        );*/
    }
    //}
  }

  Future<Voucher> checkVoucher(String code) async {
    var isConnected = await checkInternetAccess();
    //if (validate()) {
    late Voucher voucher = Voucher.init();
    voucher.id = 0;
    if(isConnected) {
      setState(() {
        isLoading = true;
      });

      try {
        voucher = await deliveryApi.checkVoucher(code: code.toUpperCase());
        delivery.voucher = voucher.code;
        printWarning("CALL: ${voucher.value}, ${voucher.id}");
        setState(() {
          isLoading = false;
        });
      }
      catch (err) {
        setState(() {
          isLoading = false;
        });
        printError(err);
      }
    }
    else {
      /*showToast(
          fToast: _fToast,
          message: NOT_INTERNET_ACCESS_MESSAGE,
          color: Colors.yellow,
          duration: 5,
        );*/
    }
    return voucher;
    //}
  }
}
