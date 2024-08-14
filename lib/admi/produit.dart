import 'dart:io'; // Import pour gérer les fichiers
import 'package:flutter/material.dart';
import 'package:gestion_akoum/admi/database.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import pour Firebase Storage
import 'package:path/path.dart'
    as path; // Import pour manipuler les chemins de fichiers
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart'; // Import pour sélectionner les images
import 'package:flutter/foundation.dart'
    show kIsWeb; // Import pour vérifier si l'application est en mode web

class Produit extends StatefulWidget {
  const Produit({super.key});

  @override
  State<Produit> createState() => _ProduitState();
}

class _ProduitState extends State<Produit> {
  final TextEditingController libelleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  File? _image; // Variable pour stocker l'image sélectionnée
  String?
      _imageURL; // Variable pour stocker l'URL de l'image si stockée en ligne
  final picker = ImagePicker(); // Instance pour choisir les images

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // Choisir l'image depuis la galerie
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile
            .path); // Mettre à jour l'état avec le fichier sélectionné
      });
      if (kIsWeb) {
        // Pour le Web, vous pourriez devoir utiliser l'URL de l'image plutôt que le fichier local
        // Intégrer le code pour uploader l'image et obtenir l'URL si nécessaire
        // Exemple d'URL fictive pour le Web
        _imageURL = 'https://example.com/image.jpg';
      } else {
        await _uploadImage(
            _image!); // Pour mobile, uploader l'image et obtenir l'URL
      }
    }
  }
  //POUR OBTENIR LURL DUNE IMAGE EN LIGNE

  Future<void> _uploadImage(File image) async {
    final fileName = path.basename(image.path);
    final storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    final uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => null);
    final downloadURL = await storageReference.getDownloadURL();
    setState(() {
      _imageURL = downloadURL; // Stocker l'URL pour utilisation ultérieure
    });
  }

  Future<void> _ajouterProduit() async {
    String id = randomAlphaNumeric(10);
    Map<String, dynamic> produitInfoMap = {
      "Libelle": libelleController.text,
      "Description": descriptionController.text,
      "Prix": prixController.text,
      "Photo": _imageURL, // URL ou chemin de l'image
      "id": id,
    };

    await DatabaseMethods().addProduitdetails(produitInfoMap, id).then((value) {
      Fluttertoast.showToast(
        msg: "Le produit a été enregistré avec succès",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Produit",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " form",
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _getImage,
              child: const Text("Choisir une Photo"),
            ),
            _image == null
                ? const Text("Aucune image sélectionnée.")
                : kIsWeb
                    ? Image.network(
                        _imageURL!) // Utilisez Image.network pour le web
                    : Image.file(
                        _image!), // Utilisez Image.file pour les plateformes mobiles
            buildTextField("Libellé", libelleController),
            buildTextField("Description", descriptionController),
            buildTextField("Prix", prixController),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: _ajouterProduit,
                child: const Text(
                  "Ajouter",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: InputBorder.none),
            obscureText: obscureText,
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
