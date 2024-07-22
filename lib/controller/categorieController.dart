import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Categorie.dart';


class CategorieService {
  final CollectionReference categorieCollection =
  FirebaseFirestore.instance.collection('categories');

  // Ajouter une catégorie
// Ajouter une catégorie
  Future<void> ajouterCategorie(Categorie categorie) {
    final docRef = categorieCollection.doc();
    categorie.docId= docRef.id; // Assigner l'ID généré automatiquement
    return docRef
        .set(categorie.toMap())
        .then((value) => print("Categorie ajoutée"))
        .catchError((error) => print("Échec de l'ajout de la catégorie: $error"));
  }


  // Modifier une catégorie
// Modifier une catégorie
// Modifier une catégorie
  Future<void> modifierCategorie(Categorie categorie) {
    if (categorie.docId == null) {
      return Future.error("Document ID is null");
    }
    return categorieCollection
        .doc(categorie.docId)
        .update(categorie.toMap())
        .then((value) => print("Categorie modifiée"))
        .catchError((error) => print("Échec de la modification de la catégorie: $error"));
  }

// Supprimer une catégorie
  Future<void> supprimerCategorie(String docId) {
    return categorieCollection
        .doc(docId)
        .delete()
        .then((value) => print("Categorie supprimée"))
        .catchError((error) => print("Échec de la suppression de la catégorie: $error"));
  }


  // Supprimer une catégorie


  // Récupérer toutes les catégories
  // Récupérer toutes les catégories
  Future<List<Categorie>> recupererCategories() async {
    QuerySnapshot querySnapshot = await categorieCollection.get();
    return querySnapshot.docs
        .map((doc) => Categorie.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

}
