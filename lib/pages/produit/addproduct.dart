import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/color_app.dart';
import 'addProductWithimage.dart';

class YourAppScreen extends StatefulWidget {
  @override
  _YourAppScreenState createState() => _YourAppScreenState();
}

class _YourAppScreenState extends State<YourAppScreen> {
  TextEditingController nomProduit= TextEditingController();

  List<String> categories = [];
  String? selectedCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('categories').get();
    setState(() {
      categories = snapshot.docs.map((doc) => doc['nomCategorie'] as String).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un produit'),
        centerTitle: true,

      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: Text('Sélectionnez une catégorie'),
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedCategory != null) {
                  // Enregistrer le produit avec la catégorie sélectionnée
                } else {
                  // Afficher un message d'erreur ou demander à l'utilisateur de sélectionner une catégorie
                }
              },
              child: Text('Enregistrer le produit'),
            ),
          ],
        ),
      ),

    );
  }
}
