import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/models/user/user.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/services/api/user.api.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/locator.dart';
import 'package:country_flags/country_flags.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/gestures.dart';
import 'package:jojo/pages/widgets/policy_dialog.dart';


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
  bool isLoading2 = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  //final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late String selectedCountryCode;
  String phoneNumber = '';
  List<Map<String, String>> countries = [
    {'name': 'Burkina Faso', 'code': 'BF'},
    {'name': 'Canada', 'code': 'CA'},
    {'name': "Côte d'Ivoire", 'code': 'CI'},
    {'name': 'France', 'code': 'FR'},
    {'name': 'United States', 'code': 'US'},
    // Add more countries here
  ];

  List<String> codes = ['BF', 'CA', 'CI', 'FR', 'US'];

  @override
  void initState() {
    super.initState();
    selectedCountryCode = 'CI';
    emailController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    phoneController.text = '';
    addressController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    countryValue = "CI";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text(
          "Inscription",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'BIENVENUE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: GlobalColors.bluecolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pour créer votre compte, veuillez remplir les champs ci-dessous avec les informations demandées.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: GlobalColors.bluecolor,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: lastNameController,
                        decoration: InputDecoration(
                          hintText: 'Nom',
                          hintStyle: GoogleFonts.poppins(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: GlobalColors.Orangecolor, width: 2)
                          )
                        ),
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
                        decoration: InputDecoration(
                            hintText: 'Prenom',
                            hintStyle: GoogleFonts.poppins(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: GlobalColors.Orangecolor, width: 2)
                            )
                          ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Veuillez saisir votre prénom';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 180,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: 'Pays',
                            labelStyle: GoogleFonts.poppins(), 
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalColors.Orangecolor, width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          
                          value: selectedCountryCode,
                          onChanged: (value) {
                            setState(() {
                              selectedCountryCode = value!;
                              countryValue = selectedCountryCode;
                            });
                          },
                          items: countries.map((country) {
                            return DropdownMenuItem(
                              value: country['code'],
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      child: CountryFlags.flag(country['code']!),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        country['name']!,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Veuillez selectionner votre pays';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber phoneNumber) {
                              phoneController.text = phoneNumber.phoneNumber as String;
                              print(phoneController.text);
                          },

                          initialValue: PhoneNumber(isoCode: 'CI'),
                          inputDecoration: InputDecoration(
                            labelText: 'Numero de telephone',
                            labelStyle: GoogleFonts.poppins(), 
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalColors.Orangecolor, width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG
                      
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          formatInput: true,
                          validator: (String? val) {
                              if (val!.isEmpty) {
                                return 'Veuillez saisir votre numéro';
                              }
                              return null;
                            },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: GoogleFonts.poppins(),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: GlobalColors.Orangecolor, width: 2)
                              ),
                        ),
                        validator: (String? email) {
                          if (email!.isEmpty) {
                            return 'Veuillez saisir votre e-mail';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                              .hasMatch(email)) {
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
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: GlobalColors.Orangecolor, width: 2)
                            ),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: visibility,
                            )),
                        validator: (String? password) {
                          if (password!.isEmpty) {
                            return 'Veuillez saisir votre mot de passe';
                          } else if (password.length < 8) {
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
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: GlobalColors.Orangecolor, width: 2)
                              ),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView2,
                              child: visibility2,
                            )),
                        validator: (String? password) {
                          if (password!.isEmpty) {
                            return 'Veuillez saisir à nouveau votre mot de passe';
                          } else {
                            if (password.length < 8) {
                              return "Mot de passe incorrect";
                            } else if (password != passwordController.text) {
                              return "Le mot de passe doit être identique";
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: isChecked,
                            activeColor: GlobalColors.Orangecolor,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue!;
                              });
                            }),
                          Text.rich(
                            TextSpan(
                                text: "j'ai lu et j'accepte la ",
                                style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.teal,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                children: [
                                  TextSpan(
                                      text: "politique de confidentialité.",
                                      recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                      showDialog(
                                        context: context,
                                        builder: (context){
                                          return PolicyDialog(
                                            mdFileName: 'politique_de_confidentialite.md',
                                          );
                                        },),
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.teal,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ),
                                ]),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed:
                          !isChecked ? null : (isLoading ? null : register),
                      style: ElevatedButton.styleFrom(
                        primary: GlobalColors.Orangecolor,
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : Text("S'inscrire",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: GlobalColors.Whitecolor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
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
      visibility = const Icon(Icons.visibility,);
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
      if (isConnected) {
        setState(() {
          //isChecked = false;
          isLoading = true;
        });
        User user = User.init();
        user.email = emailController.text;
        user.firstName = firstNameController.text;
        user.lastName = lastNameController.text;
        user.phone = phoneController.text;
        user.country = countryValue;
        user.password = passwordController.text;
        user.confirmPassword = confirmPasswordController.text;
        user.profile = defaultProfile;

        try {
          printWarning(
              "USER: ${user.email}, ${user.firstName}, ${user.lastName}, ${user.phone}, ${user.country}");
          var response = await userApi.register(user: user);
          if (response.statusCode == 201) {
            setState(() {
              isLoading = false;
            });

            Timer(const Duration(seconds: 1), () {
              Get.to(LoginView());
              openDialog(
                context: context,
                title: "Validation",
                message:
                    "Votre inscription a été prise en compte. Vous recevrez un mail de confirmation dans les minutes qui suivent.",
                btnText: "Ok",
                function: () {
                  Navigator.of(context).pop(false);
                },
              );
            });
          } else if (response.statusCode == 401) {
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
                    });
              }
            }
            //var rep = jsonDecode(respStr);
            //printError(respStr['errors'].containsKey("email"));
          }
        } catch (err) {
          printWarning("0.4");
          setState(() {
            isLoading = false;
          });
          printError(err);
        }
      } else {
        /*showToast(
            fToast: _fToast,
            message: NOT_INTERNET_ACCESS_MESSAGE,
            color: Colors.yellow,
            duration: 5,
          );*/
      }
    }
  }

  openDialog(
      {required BuildContext context,
      required String title,
      required String message,
      String btnText = 'Ok',
      dynamic function}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
            ),
            content: Text(
              message,
              style: GoogleFonts.poppins(),
            ),
            actions: [
              TextButton(
                  onPressed: function,
                  child: Text(
                    btnText,
                    style: GoogleFonts.poppins(),
                  )),
            ],
          );
        });
  }
}
