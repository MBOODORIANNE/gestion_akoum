import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../composants/RoundedButton.dart';
import '../../composants/textfield_with_icon.dart';
import '../../controller/categorieController.dart';
import '../../models/Categorie.dart';
import 'package:random_string/random_string.dart';

class CategoriePage extends StatefulWidget {
  @override
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  final CategorieService categorieService = CategorieService();
  TextEditingController TextCategorieName=TextEditingController();

  void _ajouterCategorie() {
    String Id = randomAlphaNumeric(10);
    Categorie nouvelleCategorie = Categorie( nomCategorie:TextCategorieName.text);
    categorieService.ajouterCategorie(nouvelleCategorie);
    toastification.show(

      context: context, // optional if you use ToastificationWrapper
      title: Text('categorie ajouté avec succes!'),
      autoCloseDuration: const Duration(seconds: 5),
    );
    TextCategorieName.clear();
  }

  void _modifierCategorie(Categorie categorie) {
    categorie.nomCategorie = 'Catégorie Modifiée';
    categorieService.modifierCategorie(categorie);
  }

  void _supprimerCategorie(String id) {
    categorieService.supprimerCategorie(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuter une Catégories'),
        centerTitle: true,
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [

                  SizedBox(height: 20,),
                  textFieldWith_icon(textEditingController:  TextCategorieName, title: "Nom categorie", icon: Icons.add_box,),
                  const SizedBox(height: 10,),

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
                  round_button(title: 'ajouter', onPressed:_ajouterCategorie,
                  ),
                  SizedBox(height: 10,),

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
