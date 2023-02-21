import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/pages/contrat.dart';
import 'package:jojo/pages/courses.dart';
import 'package:jojo/pages/editprofil.dart';
import 'package:jojo/pages/login.dart';
import 'package:jojo/pages/politique.dart';
import 'package:jojo/services/api/user.api.dart';
import 'package:jojo/utils/constants.dart';
import 'package:jojo/utils/functions.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/locator.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';


class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  //Init user api
  final UserApi userApi = locator<UserApi>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    printWarning('InitState');
  }

  @override
  void dispose() {
    super.dispose();
    printWarning('Dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: GlobalColors.bluecolor,
          centerTitle: true,
          excludeHeaderSemantics: true,
          title: Text(
            'Mon profil',
            style: GoogleFonts.poppins(),
          )),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  //currentUser != null ? currentUser.name : appDefaultUserName,
                  currentUser.id != 0 ? currentUser.name : appDefaultUserName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
                Text(
                  currentUser.id != 0 ? currentUser.email : appEmail,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontStyle: FontStyle.italic)),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return EditProfil();
                      }));

                      if (result != null) {
                        setState(() {
                          currentUser = result;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300)),
                      backgroundColor: GlobalColors.Orangecolor,
                      side: BorderSide.none,
                    ),
                    child: Text(
                      "modifier profil",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: "Historique des courses",
                  icons: FontAwesomeIcons.truckFront,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MesCourses();
                    }));
                  },
                  textColor: Colors.black,
                ),
                ProfileMenuWidget(
                  title: "Conditions generales",
                  icons: LineAwesomeIcons.file_contract,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Contrat(mdFileName: 'conditions_de_service.md',);
                    }));
                  },
                  textColor: Colors.black,
                ),
                ProfileMenuWidget(
                  title: "Politique de confidentialité",
                  icons: LineAwesomeIcons.balance_scale,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Politique(mdFileName: 'politique_de_confidentialite.md',);
                    }));
                  },
                  textColor: Colors.black,
                ),
                /*ProfileMenuWidget(
                  title: "Partenaires",
                  icons: LineAwesomeIcons.handshake,
                  onPress: () {},
                  textColor: Colors.black,
                ),*/
                const SizedBox(
                  height: 30,
                ),
                ProfileMenuWidget(
                  title: "Partager l'application",
                  icons: LineAwesomeIcons.share,
                  onPress: () async {
                    await Share.share("Partagez l'application");
                  },
                  textColor: Colors.black,
                ),
                ProfileMenuWidget(
                  title: "Deconnexion",
                  icons: LineAwesomeIcons.alternate_sign_out,
                  onPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Deconnexion"),
                        content: Text("Vous allez mettre fin à votre session."),
                        actions:[
                          TextButton(
                            onPressed: (){
                              setState(() {
                                isLoading = !isLoading;
                              });
                              logout(context);
                            }, 
                            child: Text("Oui")
                          ),
                          TextButton(onPressed: (){ Navigator.of(context).pop(false);}, child: Text("Non")),
                        ]
                      ),
                    );
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginView();
                    }));*/
                  },
                  textColor: Colors.red,
                ),
                const SizedBox(
                  height: 150,
                ),
                Text(
                      'Version 1.0.0',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12, color: Colors.grey)),
                    ),
                
              ],
            )),
      ),
    );
  }

  //Logout function
  void logout(context) async {
    try {
      int code = await userApi.logout();
      if (code == 200) {
        setState(() {
          isLoading = !isLoading;
        });

        //Navigate to login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) { return const LoginView(); })
        );
      }
    }
    catch (err) {
      /*showToast(
        fToast: _fToast,
        message: GLOBAL_ERROR_MESSAGE,
        color: DANGER_COLOR,
        duration: 3,
      );*/
      printError(err);
    }

  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icons,
    required this.onPress,
    required this.textColor,
  });

  final String title;
  final IconData icons;
  final VoidCallback onPress;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue.withOpacity(0.1),
        ),
        child: Icon(
          icons,
          color: Colors.blue,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 20,
          color: textColor,
        )),
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: GlobalColors.bluecolor.withOpacity(0.1)),
        child: Icon(
          LineAwesomeIcons.angle_right,
          size: 18.0,
          color: GlobalColors.bluecolor,
        ),
      ),
    );
  }
}
