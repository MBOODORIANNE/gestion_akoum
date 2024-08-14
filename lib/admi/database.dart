import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  //create
  Future addProducteurDetails(
      Map<String, dynamic> producteurInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Producteur")
        .doc(id)
        .set(producteurInfoMap);
  }
//read

  Future<Stream<QuerySnapshot>> getProducteurDetails() async {
    return await FirebaseFirestore.instance
        .collection("Producteur")
        .snapshots();
  }
//update

  Future updateProducteurDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Producteur")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteProducteurDetails(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Producteur")
          .doc(id)
          .delete();
    } catch (e) {
      print("Erreur lors de la suppression du document : $e");
    }
  }

  ///produit
  //create
  Future addProduitdetails(
      Map<String, dynamic> produitInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Produit")
        .doc(id)
        .set(produitInfoMap);
  }
}
