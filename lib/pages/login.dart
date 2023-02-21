import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/models/user/user.dart';
import 'package:jojo/pages/home2.dart';
import 'package:jojo/pages/inscription.dart';
import 'package:jojo/pages/home.dart';
import 'package:jojo/pages/mot_de_passe_oublie.dart';
import 'package:jojo/pages/widgets/policy_dialog.dart';
import 'package:jojo/pages/widgets/signup.form.global.dart';
import 'package:jojo/services/api/user.api.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/locator.dart';
import 'package:flutter/gestures.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  final UserApi userApi = locator<UserApi>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final DocumentApi documentApi = locator<DocumentApi>();
  bool isLogin = true;
  bool isLoading = false;
  late Animation<double> containerSize;
  late AnimationController _animationController;
  
  Duration animationDuration = const Duration(milliseconds: 270);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: animationDuration);

    //emailController.text = 'jessica@jojo.com';
    //passwordController.text = 'password';

  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: GlobalColors.bluecolor,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Image(
                        image: AssetImage('assets/logos/sloganblancorange.png'),
                        height: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Connectez-vous',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                              color: GlobalColors.Whitecolor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))),
                        const SizedBox(
                          height: 15,
                        ),
                        ////Email input
                        SignupFormGlobal(
                          controller: emailController,
                          text: 'Email',
                          obscure: false,
                          textInputType: TextInputType.emailAddress,
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
                          height: 5,
                        ),
                        ////Password input
                        SignupFormGlobal(
                          controller: passwordController,
                          text: "Mot de passe",
                          textInputType: TextInputType.text,
                          obscure: true,
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
                          height: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const ForgotPasswordPage();
                                  }));
                          },
                          child: Text('Mot de passe oublié?',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                              color: GlobalColors.Whitecolor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            ))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 250,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: GlobalColors.Orangecolor,
                              ),
                              onPressed: isLoading ? null : login,
                              child: isLoading? SizedBox(
                                height: 15, 
                                width:15,
                                child: CircularProgressIndicator(color: Colors.white)) 
                                :Text("CONNEXION",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                  color: GlobalColors.Whitecolor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: 250,
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Inscription();
                                  }));
                                },
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 3, color: GlobalColors.Whitecolor)),
                                child: Text("INSCRIPTION",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      color: GlobalColors.Whitecolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePage2();})
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: GlobalColors.Whitecolor,
                              ),
                              child: Text("CONTINUER SANS CONNEXION",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                    color: GlobalColors.bluecolor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text.rich(
                            TextSpan(
                                text: "En continuant, j'accepte les",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                children: [
                                  TextSpan(
                                      text: " conditions generales",
                                      recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                      showDialog(
                                        context: context,
                                        builder: (context){
                                          return PolicyDialog(
                                            mdFileName: 'conditions_de_service.md',
                                          );
                                        },),
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: Colors.amber,
                                          fontSize: 12
                                      )
                                  ),
                                  TextSpan(
                                      text: ' et j\'ai lu la',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12)),
                                  TextSpan(
                                      text: ' politique de confidentialité',
                                      recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                      showDialog(
                                        context: context,
                                        builder: (context){
                                          return PolicyDialog(
                                            mdFileName: 'politique_de_confidentialite.md',
                                          );
                                        },),
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: Colors.amber,
                                          fontSize: 12)),
                                  TextSpan(
                                      text: '  de jojo.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12)),
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          )
    
          /*Center(
          child: Image(
            image: AssetImage('assets/logos/jojoblancorange.png'),
            height: 50,
          )
        ),*/
          ),
    );
  }
  
  Future login() async {
    var isConnected = await checkInternetAccess();
    if (_formKey.currentState!.validate()) {
      if(emailController.text.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(emailController.text)) {
      }
      else {
        if(isConnected) {
          setState(() {
            isLoading = true;
          });
          User user = User.init();
          user.email = emailController.text;
          user.password = passwordController.text;

          try {
            user = await userApi.login(user: user);
            if (user.accessToken != '' || user.accessToken != null) {
              setState(() {
                currentToken = user.accessToken;
                isLoading = false;
              });

              //Navigate to home
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) { return const HomePage(); })
              );
            }
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
    }
    else {
      printError("Not valid !");
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
