import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../composants/RoundedButton.dart';
import '../../composants/textfield_with_icon.dart';

class ProductRegistrationScreen extends StatefulWidget {
  @override
  _ProductRegistrationScreenState createState() => _ProductRegistrationScreenState();
}

class _ProductRegistrationScreenState extends State<ProductRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  List<String> categories = [];
  String? selectedCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadProduct() async {
    if (_formKey.currentState!.validate() && _image != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        String imageUrl = await _uploadImage(_image!);
        await FirebaseFirestore.instance.collection('products').add({
          'name': _nameController.text,
          'description': _descriptionController.text,
          'categorie': selectedCategory,
          'price': double.parse(_priceController.text),
          'imageUrl': imageUrl,
        });

        setState(() {
          _isLoading = false;
        });
        _nameController.clear();
        _descriptionController.clear();
        _priceController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produit enregistré avec succès')),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'enregistrement du produit')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs et ajouter une photo')),
      );
    }
  }

  Future<String> _uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child('products/$fileName');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
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
        title: Text('Enregistrer un produit'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldWith_icon(textEditingController:  _nameController, title: "Libellé", icon: Icons.add_box,),
                SizedBox(height: 10,),
                textFieldWith_icon(textEditingController:  _descriptionController, title: "Description", icon: Icons.add_box,),
                SizedBox(height: 10,),
                textFieldWith_icon(textEditingController:  _priceController, title: "Prix", icon: Icons.add_box,),
                SizedBox(height: 10,),

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
                _image == null
                    ? Text('Aucune image sélectionnée')
                    : Image.file(_image!),
                SizedBox(height: 10),

                round_button(title: 'Sélectionner une image', onPressed:_pickImage,
                ),


                SizedBox(height: 20),
                round_button(title: 'ajouter', onPressed:_uploadProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
