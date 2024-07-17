import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../composants/RoundedButton.dart';
import '../../composants/TextFieldwithObscureText.dart';

import '../../composants/image_string.dart';
import '../../composants/roundedButtonIcon.dart';
import '../../composants/textfield_with_icon.dart';
import '../../constants/color_app.dart';
import '../../models/User_Model.dart';
import '../home_screen/home_screen.dart';
import '../home_screen/nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nomUtilisateurController = TextEditingController();
  final _motDePasseController = TextEditingController();

  void _login() async {

    User? user = await connecterUtilisateur(
      _nomUtilisateurController.text,
      _motDePasseController.text,
    );
    if (user != null) {
      // Naviguer vers une autre page ou afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la connexion')),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: GoogleFonts.montserrat(
          fontWeight:FontWeight.bold
        ),),
        centerTitle: true,
        leading:  const Icon(IconlyLight.arrowLeft,color: Colors.black,size: 20,),
      ),
       body:SafeArea(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
             child: Padding(
               padding: const EdgeInsets.only(top: 30),
               child: Column(
                 children: [
                   Image.asset(login,height: 100, width: 100,),
                   SizedBox(height: 20,),
                   textFieldWith_icon(textEditingController:  _nomUtilisateurController, title: "nom d'utilisateur", icon: IconlyLight.message,),
                  const SizedBox(height: 10,),
                   textFieldWith_icon_ObscureText(textEditingController: _motDePasseController, title: 'mot de passe',),
                   /*Align(
                        alignment: Alignment.centerRight,
                       child: TextButton(onPressed: (){}, child: Text("Forget Password?",style: GoogleFonts.montserrat(
                          color:AppColor.primary,
                         fontWeight:FontWeight.w600

                       ),
                       )
                       )
                   ),*/
                   const SizedBox(height: 20,),
                   round_button(title: 'Login', onPressed:_login,
               /*   CustomDialog.showCustomDialog(
                      context, "Yeay! Welcome Back",
                      "Once again you login successfully \n into medidoc app",
                      "Go to home",
                          (){
                         );*/


                   ),
                   SizedBox(height: 10,),
                   Align(
                     alignment: Alignment.center,
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Don’\ t have an account?",style: GoogleFonts.montserrat(
                               color:AppColor.secondaryText,
                               fontSize:15

                           ),
                           ),
                           SizedBox(height: 20,),

                           TextButton(onPressed: (){}, child: Text("Sign Up",style: GoogleFonts.montserrat(
                               color:AppColor.primary,
                               fontWeight:FontWeight.w500,
                               fontSize:15
                           ),
                           )

                           ),
                         ],
                       )
                   ),
                  /* Rouded_buttonWitthIcon(title: 'Sign in with Google', image: googleIcon, onPressed: () {


                   },)*/
                 ],
               ),
             ),
           ),
         ),
       ),
    );
  }
}
