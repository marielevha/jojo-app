// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/services/api/user.api.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/locator.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final UserApi userApi = locator<UserApi>();
  //final DocumentApi documentApi = locator<DocumentApi>();
  bool isLoading = false;
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = '';
    super.initState();
  }

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Remplissez les champs obligatoires"),
      ));
    }
    else {
      if(_emailController.text.length <= 0 || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(_emailController.text)){
        openDialog(
          context: context,
          title: "Erreur",
          message: "Email incorrect ou inexistant.",
          btnText: "Réessayer",
          function: () {
            Navigator.of(context).pop(false);
          },
        );
      }
      else {
        await requestResetPassword();
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text(
          "Mot de passe oublié",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Entrez votre email et nous vous enverrons un lien de réinitialisation.",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: GlobalColors.Orangecolor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? email) {
                  if (email!.isEmpty) {
                    return 'Veuillez saisir votre e-mail';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: isLoading ? null : passwordReset,
                style: ElevatedButton.styleFrom(
                  primary: GlobalColors.Orangecolor,
                ),
                child: Text(
                    "Réinitialiser",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: GlobalColors.Whitecolor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),)
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<void> requestResetPassword() async {
    printWarning("requestResetPassword");
    var isConnected = await checkInternetAccess();
    if(isConnected) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await userApi.requestResetPassword(email: _emailController.text);
        printWarning(response);
        if(response['status'] == 200) {
          printInfo("Success");
          openDialog(
            context: context,
            title: "Valider",
            message: response['message'],
            btnText: "Ok",
            function: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return const LoginView();
                }));
            }
          );
        }
        else if(response['status'] == 404) {
          printInfo("Not found");
          openDialog(
            context: context,
            title: "Erreur",
            message: response['message'],
            btnText: "Réessayer",
            function: () {
              Navigator.of(context).pop(false);
            }
          );
        }
        setState(() {
          isLoading = false;
        });
        /*if (user.accessToken != '' || user.accessToken != null) {
        setState(() {
          currentToken = user.accessToken;
          isLoading = false;
        });

        //Navigate to home
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) { return const HomePage(); })
        );
      }*/
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