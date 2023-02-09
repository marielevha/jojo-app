import 'dart:async';
import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/models/user/user.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/pages/widgets/signup.form.global.dart';
import 'package:jojo/services/api/user.api.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:jojo/utils/locator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';




class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final UserApi userApi = locator<UserApi>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  bool isHiddenPassword2 = true;
  Icon visibility = Icon(Icons.visibility_off);
  Icon visibility2 = Icon(Icons.visibility_off);

  bool isChecked = false;

  late String countryValue;
  late String stateValue;
  late String cityValue;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  //final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.text = 'sass@jojo.com';
    firstNameController.text = 'Main';
    lastNameController.text = 'JOjo';
    phoneController.text = '070000041';
    addressController.text = '52 Bd Abdelmoumen';
    passwordController.text = 'password';
    confirmPasswordController.text = 'password';
    countryValue = "Cote D'Ivoire";
    stateValue = "";
    cityValue = "";
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: lastNameController,
                        decoration: InputDecoration(hintText: 'Nom', hintStyle: GoogleFonts.poppins(),),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Veuillez saisir votre nom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: firstNameController,
                        decoration: InputDecoration(hintText: 'Prenom', hintStyle: GoogleFonts.poppins()),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Veuillez saisir votre prénom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: addressController,
                        decoration: InputDecoration(hintText: 'Adresse', hintStyle: GoogleFonts.poppins()),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                          ),
                        ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Veuillez saisir votre adresse';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CSCPicker(
                        layout: Layout.vertical,
                        flagState: CountryFlag.ENABLE,
                        onCountryChanged: (country) {
                          setState(() {
                            countryValue = country;
                            printWarning(countryValue);
                          });
                        },
                        onStateChanged: (state) {
                          /*setState(() {
                            stateValue = state!;
                            printWarning(stateValue);
                          });*/
                        },
                        onCityChanged: (city) {
                          /*setState(() {
                            cityValue = city!;
                            printWarning(cityValue);
                          });*/
                        },
                        countryDropdownLabel: "Pays",
                        stateDropdownLabel: "Region",
                        cityDropdownLabel: "Ville",
                        currentCountry: countryValue,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Numero de telephone', hintStyle: GoogleFonts.poppins()),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Veuillez saisir votre numéro';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: 'Email', hintStyle: GoogleFonts.poppins()),
                        validator: (String? email) {
                          if (email!.isEmpty) {
                            return 'Veuillez saisir votre e-mail';
                          }
                          else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(email)) {
                            return "Ceci n'est pas un e-mail valid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        obscureText: isHiddenPassword,
                        decoration: InputDecoration(
                            hintText: 'Mot de passe',
                            hintStyle: GoogleFonts.poppins(),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: visibility,
                            )),
                        validator: (String? password) {
                          if (password!.isEmpty) {
                            return 'Veuillez saisir votre mot de passe';
                          }
                          else if (password.length < 8) {
                            return "Mot de passe incorrect";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: confirmPasswordController,
                        obscureText: isHiddenPassword2,
                        decoration: InputDecoration(
                            hintText: 'Repetez le mot de passe',
                            hintStyle: GoogleFonts.poppins(),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView2,
                              child: visibility2,
                            )),
                        validator: (String? password) {
                          if (password!.isEmpty) {
                            return 'Veuillez saisir à nouveau votre mot de passe';
                          }
                          else {
                            if (password.length < 8) {
                              return "Mot de passe incorrect";
                            }
                            else if (password != passwordController.text) {
                              return "Le mot de passe doit être identique";
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? newValue){
                            setState(() {
                              isChecked = newValue!;
                            });
                          }
                        ),
                        Text(
                          "j'ai lu et j'accepte la politique de confidentialité",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                            color: Colors.teal,
                            fontSize: 12,
                            ),)
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: !isChecked ? null : (isLoading ? null : register),
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
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
    if (isHiddenPassword == true) {
      visibility = const Icon(Icons.visibility_off);
    } else {
      visibility = const Icon(Icons.visibility);
    }
  }

  void _togglePasswordView2() {
    setState(() {
      isHiddenPassword2 = !isHiddenPassword2;
    });
    if (isHiddenPassword2 == true) {
      visibility2 = const Icon(Icons.visibility_off);
    } else {
      visibility2 = const Icon(Icons.visibility);
    }
  }

  Future register() async {
    var isConnected = await checkInternetAccess();
    if (_formKey.currentState!.validate()) {
      if(isConnected) {
        setState(() {
          //isChecked = false;
          isLoading = true;
        });
        User user = User.init();
        user.email = emailController.text;
        user.firstName = firstNameController.text;
        user.lastName = lastNameController.text;
        user.phone = phoneController.text;
        user.country = countryValue;//countryController.text;
        //user.region = stateValue;
        //user.city = cityValue;
        user.password = passwordController.text;
        user.confirmPassword = confirmPasswordController.text;
        user.profile = defaultProfile;

        try {
          printWarning("USER: ${user.email}, ${user.firstName}, ${user.lastName}, ${user.phone}, ${user.country}");
          var response = await userApi.register(user: user);
          if (response.statusCode == 201) {
            setState(() {
              isLoading = false;
            });

            Timer(const Duration(seconds: 0), () {
              Get.to(LoginView());
              QuickAlert.show(
                context: context,
                text:
                "Nous vous remercions de s'être inscrit sur JOjo. Email vous a été envoyé pour activer votre compte.",
                type: QuickAlertType.success,
                confirmBtnText: "Ok",
                confirmBtnColor: GlobalColors.bluecolor,
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                },
              );
            });
          }
          else if (response.statusCode == 401) {
            setState(() {
              isLoading = false;
            });
            var respStr = jsonDecode(await response.stream.bytesToString());
            if (respStr.containsKey("errors")) {
              if (respStr['errors'].containsKey("email")) {
                //printError(respStr['errors'].containsKey("email"));
                openDialog(
                  context: context,
                  title: "Erreur",
                  message: "Cet email est déjà utilisé.",
                  btnText: "Réessayer",
                  function: () {
                    Navigator.of(context).pop(false);
                  }
                );
              }
            }
            //var rep = jsonDecode(respStr);
            //printError(respStr['errors'].containsKey("email"));
          }
        }
        catch (err) {
          printWarning("0.4");
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
    }
  }

  openDialog({required BuildContext context, required String title, required String message, String btnText = 'Ok', dynamic function}) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:Text(title, style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold)),) ,
            content: Text(message, style: GoogleFonts.poppins(),),
            actions: [
              TextButton(
                  onPressed: function,
                  child: Text(btnText, style: GoogleFonts.poppins(),)
              ),
            ],
          );
        }
    );
  }
}
