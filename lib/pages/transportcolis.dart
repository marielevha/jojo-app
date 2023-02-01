import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/pages/home.dart';
import 'package:jojo/services/api/delivery.api.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/locator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jojo/models/voucher/voucher.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/pages/maps/location.screen.dart';


class TransportColis extends StatefulWidget {
  const TransportColis({super.key});

  @override
  State<TransportColis> createState() => _TransportColisState();
}

class Voiture {
  String label;
  Color color;
  Voiture(this.label, this.color);
}

class _TransportColisState extends State<TransportColis> {

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
  final TextEditingController weightController = TextEditingController();
  final TextEditingController natureController = TextEditingController();
  final TextEditingController packagesController = TextEditingController();
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
    delivery.carType = "Baché";
    //delivery.house = '';
    //delivery.bedroomsNumber = 0;
    delivery.transactionType = kTransactionTypeTwo;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    //_lieuDepart = lieuDepartController.text.trim();
                    delivery.departCity = lieuDepartController.text.trim();
                  });

                  //printWarning("Lieu depart: $_lieuDepart");
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
                    //_lieuDestination = lieuDestinationController.text.trim();
                    delivery.destinationCity = lieuDestinationController.text.trim();
                  });

                  //printWarning("Lieu destination: $_lieuDestination");
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
                    //_lieuArret = lieuStopController.text;
                    delivery.stopCity = lieuStopController.text.trim();
                  });

                  //printWarning("Lieu stop: $_lieuArret");
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
              delivery.destinationDate = formatDate.toString();
              //delivery.departDate = formatDate.toString();
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
              //delivery.departHour = formatTime;
              delivery.destinationHour = formatTime;
            });
          } else {
            print('heure non definie');
          }
        },
      ),
    );
  }
///////////////////////////////////////////////////////////////////

//////////////////////////nature du colis////////////////////////
  late final String _natureColis;
  Widget _buildNatureColis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: natureController,
          decoration: InputDecoration(
            hintText: 'Nature du colis',
            hintStyle: GoogleFonts.poppins(),
          ),
          validator: (String? nature) {
            if (nature!.isEmpty) {
              return 'le champ est vide';
            }
            return null;
          },
          onSaved: (String? nature) {
            _natureColis = nature!;
            delivery.naturePackages = natureController.text;
          },
          onChanged: (String? nature) {
            _natureColis = nature!;
            delivery.naturePackages = natureController.text;
          },
        ),
      ],
    );
  }
//////////////////////////////////////////////////////////////////

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

  //////////////////////////Poids////////////////////////
  late final String _nbrePoid;
  Widget _buildPoids() {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(
                  hintText: 'poids',
                  hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 10)),
                ),
                onSaved: (String? poids) {
                  _nbrePoid = poids!;
                  delivery.weightPackages = weightController.text;
                },
                onChanged: (String? poids) {
                  delivery.weightPackages = weightController.text;
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Kg",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          )),
        ),
      ],
    );
  }
//////////////////////////////////////////////////////////////////

//////////////////////////liste des colis////////////////////////
  late final String _listeColis;
  Widget _buildListeColis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: packagesController,
          maxLines: 20,
          decoration: InputDecoration(
            hintText: 'liste des colis...',
            hintStyle: GoogleFonts.poppins(),
            border: OutlineInputBorder(),
          ),
          onSaved: (String? liste) {
            _listeColis = liste!;
            delivery.packages = packagesController.text.trim();
          },
          onChanged: (String? liste) {
            _listeColis = liste!;
            delivery.packages = packagesController.text.trim();
          },
        ),
      ],
    );
  }
//////////////////////////////////////////////////////////////////

//////////////////////////Type de vehicule////////////////////////

  List<bool> select = [true, false, false];
  List<String> _typeVoiture = ['Baché', 'Fourgonnette', 'Camion'];
  String? _voiture = "Baché";
  late List<Voiture> _chipsList = [
    Voiture(
      "Petit",
      Colors.blue,
    ),
    Voiture(
      "Moyen",
      Colors.blue,
    ),
    Voiture(
      "Grand",
      Colors.blue,
    ),
  ];

  Widget _buildTypeVehicule() {
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
                    Text(
                      _typeVoiture[0],
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      _typeVoiture[1],
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      _typeVoiture[2],
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
            onPressed: (int newIndex) {
              setState(() {
                for (int index = 0; index < select.length; index++) {
                  if (index == newIndex) {
                    select[index] = true;
                    _voiture = _typeVoiture[index];
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
          "Transport de colis volumineux",
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
                  _buildLieuArret(),
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
                  _buildNatureColis(),
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
                  _buildPoids(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildListeColis(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildTypeVehicule(),
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
                      width: 200,
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
    /*if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Remplissez les champs obligatoires"),
      ));
    }*/
    //else {
      //_formKey.currentState!.save();

      delivery.userId = currentUser.id;
      delivery.userEmail = currentUser.email;
      delivery.contactName = nameController.text;
      delivery.contactPhone = phoneController.text;
      delivery.naturePackages = natureController.text;
      delivery.weightPackages = weightController.text;
      delivery.packages = packagesController.text;
      printWarning("Depart: ${packagesController.text}, ${natureController.text}");

      createDelivery(delivery);
      /*print('Details du formulaire transport de colis volumineux');
      print("Lieu d'enlevement: " + _lieuDepart);
      print("Lieu de destination: " + _lieuDestination);
      print("Lieu d'arret: " + _lieuArret);
      print("Date: " + dateController.text);
      print("Heure: " + _heure.text);
      print("Nature du colis: " + _natureColis);
      print('Nombre de vehicule: ' '$_valueVehicule');
      print('Nombre de trajet: ' '$_valueTrajet');
      print("Poids: " + _nbrePoid + " kg");
      print("Liste des colis: " + _listeColis);
      print("Type de camion: " + _voiture!);
      print("Coupon: ");
      print("Personne à contacter: " + _nomPrenom);
      print("Numero de tel: " + _numero);*/
      
      Timer(const Duration(seconds: 3602), () {
        Get.to(HomePage());
        QuickAlert.show(
          context: context,
          text:
              "Nous vous remercions d'avoir validé votre commande. Le service client de Jojo vous recontactera dans les minutes qui suivent pour une meilleure prise en charge de votre commande.",
          type: QuickAlertType.success,
          confirmBtnText: "Ok",
          onConfirmBtnTap: () {
            Navigator.pop(context);
          },
        );
      });
    //}
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
        //printWarning("DELIVERY: $delivery");
        delivery = await deliveryApi.createDeliveryPackage(delivery: delivery);
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
