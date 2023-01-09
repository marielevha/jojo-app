import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
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




class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final UserApi userApi = locator<UserApi>();
  bool isHiddenPassword = true;
  bool isHiddenPassword2 = true;
  Icon visibility = Icon(Icons.visibility_off);
  Icon visibility2 = Icon(Icons.visibility_off);

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
    countryValue = "Côte D'Ivoire";
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
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(hintText: 'Nom', hintStyle: GoogleFonts.poppins(),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(hintText: 'Prenom', hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(hintText: 'Adresse', hintStyle: GoogleFonts.poppins()),
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
                          printWarning(countryValue);
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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          InputDecoration(hintText: 'Numero de telephone', hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Email', hintStyle: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
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
                    TextFormField(
                      controller: confirmPasswordController,
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
                    onPressed: isLoading ? null : () async {
                      register();
                      /*() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginView();
                      }));
                    }*/
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

  Future<void> register() async {
    var isConnected = await checkInternetAccess();
    //if (validate()) {
    if(isConnected) {
      setState(() {
        isLoading = true;
      });
      User user = User.init();
      user.email = emailController.text;
      user.firstName = firstNameController.text;
      user.lastName = lastNameController.text;
      user.phone = phoneController.text;
      user.country = countryValue;//countryController.text;
      user.password = passwordController.text;
      user.profile = defaultProfile;

      try {
        printWarning("USER: ${user.email}, ${user.firstName}, ${user.lastName}, ${user.phone}, ${user.country}");
        user = await userApi.register(user: user);
        if (user.accessToken != '' || user.accessToken != null) {
          setState(() {
            isLoading = false;
          });

          //Navigate to login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) { return const LoginView(); })
          );
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
    //}
  }
}
