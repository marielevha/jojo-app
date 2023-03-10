import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/inscription.dart';
import 'package:jojo/pages/home.dart';
import 'package:jojo/pages/widgets/signup.form.global.dart';
import 'package:jojo/utils/global.colors.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.bluecolor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image(
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
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Mot de passe oubli???',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                          color: GlobalColors.Whitecolor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ))),
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
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: GlobalColors.Orangecolor,
                          ),
                          child: Text("CONNEXION",
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
                                return Inscription();
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
                              return HomePage();
                            }));
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
                const Text.rich(
                  TextSpan(
                      text: 'En continuant, jaccepte les',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' conditions du service',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.amber,
                                fontSize: 12)),
                        TextSpan(
                            text: ' et les',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            )),
                        TextSpan(
                            text: ' regles de la communaut??',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.amber,
                                fontSize: 12)),
                        TextSpan(
                            text: ' et jai lu la',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12)),
                        TextSpan(
                            text: ' politique de confidentialit??',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.amber,
                                fontSize: 12)),
                        TextSpan(
                            text: '  de vzit.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12)),
                      ]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
        )

        /*Center(
        child: Image(
          image: AssetImage('assets/logos/jojoblancorange.png'),
          height: 50,
        )
      ),*/
        );
  }
}
