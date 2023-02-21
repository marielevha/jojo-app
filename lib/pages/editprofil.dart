import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/models/user/user.dart';
import 'package:jojo/services/api/user.api.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/locator.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final UserApi userApi = locator<UserApi>();
  bool isObscurePassword = true;
  bool isLoading = false;
  late FToast _fToast;

  /*Validation Update*/
  final _formKey = GlobalKey<FormState>();
  validate() {
    printWarning("Validate: ${_formKey.currentState!.validate()}");
    return _formKey.currentState!.validate();
  }
  resetForm() {
    _formKey.currentState?.reset();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast.init(context);

    emailController.text = currentUser.email;
    firstNameController.text = currentUser.firstName;
    lastNameController.text = currentUser.lastName;
    phoneController.text = currentUser.phone;
    countryController.text = currentUser.country;
    //passwordController.text = currentUser.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text(
          'Modifier profil',
          style: GoogleFonts.poppins(),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          //Navigator.pop(context);
          printWarning("Pop app bar");
          Navigator.of(context).pop(currentUser);
        },),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30.0),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  buildTextField(labelText: "Nom", placeholder: currentUser.lastName, isPasswordTextField: false, controller: lastNameController),
                  buildTextField(labelText: "Prenom", placeholder: currentUser.firstName, isPasswordTextField: false, controller: firstNameController),
                  buildTextField(labelText: "Email", placeholder: currentUser.email, isPasswordTextField: false, controller: emailController),
                  buildTextField(labelText: "Numero", placeholder: currentUser.phone, isPasswordTextField: false, controller: phoneController),
                  buildTextField(labelText: "Pays", placeholder: currentUser.country, isPasswordTextField: false, controller: countryController),
                  buildTextField(labelText: "Mot de passe", placeholder: "********", isPasswordTextField: true, controller: passwordController),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).pop(currentUser);
                        },
                        child: Text(
                          "Annuler",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2,
                                  color: Colors.black
                              )
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          await updateUser();
                        },
                        child: Text(
                          "Modifier",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.white,
                              )
                          ),),
                        style: ElevatedButton.styleFrom(
                            primary: GlobalColors.bluecolor,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({required labelText, required placeholder, required isPasswordTextField, required controller}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField ?
            IconButton(
              onPressed: (){
                setState(() {
                  isObscurePassword = !isObscurePassword;
                });
              }, 
              icon: Icon(Icons.remove_red_eye, color: Colors.grey,)
            ) : null ,
        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 18,
            color: Colors.black
          )
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          )
        ),
        ),
      ),
    );
  }

  Future<void> updateUser() async {
    var isConnected = await checkInternetAccess();
    /*if (!_formKey.currentState!.validate()) {
    return;
    }*/
    if (_formKey.currentState!.validate()) {
      if(isConnected) {
        setState(() {
          isLoading = true;
        });

        User user = User.init();
        user.email = emailController.text;
        user.firstName = firstNameController.text;
        user.lastName = lastNameController.text;
        user.phone = phoneController.text;
        user.country = countryController.text;
        user.password = passwordController.text;
        //User user = await userApi.updateUser(user: user);

        if (user.password.isNotEmpty) {
          printWarning("Not empty");
        }

        try {
          user = await userApi.updateUser(user: user);
          if (user.country == countryController.text) {
            setState(() {
              isLoading = false;
              showToast(
                fToast: _fToast,
                message: 'Votre compte a été mis à jour',
                duration: 3,
                color: const Color(0xFF4CAF50),
                gravity: ToastGravity.TOP,
                icon: Icons.check_circle
              );
            });
          }
        }
        catch (err) {
          setState(() {
            isLoading = false;
          });
          showToast(
            fToast: _fToast,
            message: 'Error !',
            duration: 3,
            color: const Color(0xFFF44336),
            gravity: ToastGravity.TOP,
            icon: Icons.error
          );
          printError(err.toString());
        }
      }
      else {
        showToast(
          fToast: _fToast,
          message: 'Error !',
          duration: 3,
          color: const Color(0xFFFBC02D),
          gravity: ToastGravity.TOP,
          icon: Icons.info_outline_rounded
        );
      }
    }
  }

  void refreshCurrentUser({required User user}) {
    currentUser.firstName = user.firstName;
    currentUser.lastName = user.lastName;
    currentUser.phone = user.phone;
    currentUser.country = user.country;
  }
}