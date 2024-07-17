import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_akoum/pages/home_screen/nav_bar.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../composants/RoundedButton.dart';
import '../../composants/TextFieldwithObscureText.dart';

import '../../composants/image_string.dart';
import '../../composants/modal_show.dart';
import '../../composants/textfield_with_icon.dart';
import '../../constants/color_app.dart';
import '../../models/User_Model.dart';
import 'login_screen.dart'; 


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _nomUtilisateurController = TextEditingController();
  final _numeroTelephoneController = TextEditingController();
  final _motDePasseController = TextEditingController();

  bool _isChecked = false;

  void _register() async {
    if (_motDePasseController.text.length < 6) {
      CustomDialog.showCustomDialog(
        context,
        "Error",
        "The password must be at least 6 characters long.",
        "OK",
            () {
          Navigator.of(context).pop();
        },
        Icons.error,
      );
      return;
    }
    showLoadingDialog(context);
        Utilisateur utilisateur = Utilisateur(
          nom: _nomController.text,
          prenom: _prenomController.text,
          nomUtilisateur: _nomUtilisateurController.text,
          numeroTelephone: _numeroTelephoneController.text,
          motDePasse: _motDePasseController.text,
        );

        User? user = await inscrireUtilisateur(utilisateur);
        if (user != null) {
          Get.to(NavBar());
        } else {
          // Afficher un message d'erreur
        }

    try {
    await inscrireUtilisateur(utilisateur);
    _nomController.clear();
    _prenomController.clear();
    _nomUtilisateurController.clear();
    _numeroTelephoneController.clear();
    _motDePasseController.clear();
      Navigator.of(context).pop(); // Fermer le dialogue de progression

      CustomDialog.showCustomDialog(
        context,
        "Success",
        "You have successfully created your account.",
        "Login",
            () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        Icons.check,
      );
    } catch (e) {
      Navigator.of(context).pop(); // Fermer le dialogue de progression

      CustomDialog.showCustomDialog(
        context,
        "Error",
        "An error occurred while creating your account. Please try again.",
        "OK",
            () {
          Navigator.of(context).pop();
        },
        Icons.error,
      );
    }

  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const Icon(IconlyLight.arrowLeft, color: Colors.black, size: 20),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                //==========================Text field input=======================================//
                Image.asset(login,height: 100, width: 100,),
                SizedBox(height: 20,),
                textFieldWith_icon(
                  textEditingController:_nomController,
                  title: 'Enter your name',
                  icon: IconlyLight.user2,
                ),
                const SizedBox(height: 10),
                textFieldWith_icon(
                  textEditingController:  _prenomController,
                  title: 'Enter your lasname',
                  icon: IconlyLight.user2,
                ),
                const SizedBox(height: 10),
                textFieldWith_icon(
                  textEditingController:_nomUtilisateurController,
                  title: "nom d'utilisateur ",
                  icon: IconlyLight.message,
                ),
                const SizedBox(height: 10),
                textFieldWith_icon(
                  textEditingController:_numeroTelephoneController,
                  title: 'numero de telephone',
                  icon: IconlyLight.message,
                ),
                const SizedBox(height: 10),
                textFieldWith_icon_ObscureText(
                  textEditingController: _motDePasseController,
                  title: 'mot de passe',
                ),
                //=================================================================//
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Checkbox(
                        splashRadius: 50,
                        focusColor: AppColor.primary,
                        activeColor: AppColor.primary,
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue ?? false;
                          });
                        },
                      ),
                      //==========================terme and privacy=======================================//
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree to the medidoc ',
                              style: GoogleFonts.montserrat(
                                  color: AppColor.primaryText, fontSize: 13),
                            ),
                            TextSpan(
                              text: 'Terms of Service ',
                              style: GoogleFonts.montserrat(
                                  color: AppColor.primary, fontSize: 13),
                            ),
                            TextSpan(
                              text: 'and',
                              style: GoogleFonts.montserrat(
                                  color: AppColor.secondaryText, fontSize: 13),
                            ),
                            TextSpan(
                              text: '\n Privacy Policy',
                              style: GoogleFonts.montserrat(
                                  color: AppColor.primary, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      //==========================terme and privacy=======================================//
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                round_button(
                  title: 'Sign Up',
                  onPressed: _register,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: GoogleFonts.montserrat(
                            color: AppColor.secondaryText, fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async{

                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.montserrat(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
