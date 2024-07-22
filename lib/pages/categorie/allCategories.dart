import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_akoum/constants/color_app.dart';
import 'package:random_string/random_string.dart';
import '../../composants/RoundedButton.dart';
import '../../composants/textfield_with_icon.dart';
import '../../controller/categorieController.dart';
import '../../models/Categorie.dart';

class CategoriePage extends StatefulWidget {
  @override
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  final CategorieService categorieService = CategorieService();
  final TextEditingController _controller = TextEditingController();

  Future<void> _ajouterCategorie() async {
    String Id = randomAlphaNumeric(10);
    final nom = _controller.text;
    if (nom.isNotEmpty) {
      Categorie nouvelleCategorie = Categorie( nomCategorie: nom);
      await categorieService.ajouterCategorie(nouvelleCategorie);
      setState(() {});
      _controller.clear();
    }
  }

  Future<void> _modifierCategorie(Categorie categorie) async {
    _controller.text = categorie.nomCategorie;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Modifier Catégorie"),
          content: textFieldWith_icon(textEditingController:  _controller, title: "Nom categorie", icon: Icons.add_box,),
          actions: <Widget>[

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColor.white,
                backgroundColor: AppColor.primary,// Couleur du texte
              ),
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
                _controller.clear();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColor.white,
                backgroundColor: AppColor.primary,// Couleur du texte
              ),
              child: Text("Modifier"),
              onPressed: () async {
                categorie.nomCategorie = _controller.text;
                await categorieService.modifierCategorie(categorie);
                setState(() {});
                Navigator.of(context).pop();
                _controller.clear();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _supprimerCategorie(String id) async {
    bool? confirm = await _showConfirmationDialog();
    if (confirm == true) {
      await categorieService.supprimerCategorie(id);
      setState(() {});
    }
  }
  Future<bool?> _showConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette catégorie ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(false); // Retourne false si annulé
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary, // Couleur de fond du bouton de suppression
               foregroundColor: AppColor.white // Couleur du texte
              ),
              child: Text('Supprimer'),
              onPressed: () {
                Navigator.of(context).pop(true); // Retourne true si confirmé
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Categorie>>(
        future: categorieService.recupererCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune catégorie trouvée'));
          } else {
            List<Categorie> categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                Categorie categorie = categories[index];
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:AppColor.primary
                    ),
                    child: ListTile(
                      title: Text(categorie.nomCategorie,style: TextStyle(color: AppColor.white,fontSize: 14),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit,color: AppColor.white,),
                            onPressed: () => _modifierCategorie(categorie),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,color: AppColor.white,),
                            onPressed: () => _supprimerCategorie(categorie.docId!),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Ajouter Catégorie"),
                content: textFieldWith_icon(textEditingController:  _controller, title: "Nom categorie", icon: Icons.add_box,),

                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      backgroundColor: AppColor.primary,// Couleur du texte
                    ),
                    child: Text("Annuler"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _controller.clear();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      backgroundColor: AppColor.primary,// Couleur du texte
                    ),
                    child: Text("Ajouter"),
                    onPressed: () async {
                      await _ajouterCategorie();
                      Navigator.of(context).pop();
                    },
                  ),

                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
