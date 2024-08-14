import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_akoum/composants/RoundedButton.dart';

class AddPointOfSale extends StatefulWidget {
  @override
  _AddPointOfSaleState createState() => _AddPointOfSaleState();
}

class _AddPointOfSaleState extends State<AddPointOfSale> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _quarterController = TextEditingController();
  final _openingHourController = TextEditingController();
  final _closingHourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Point de Vente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Ville'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une ville';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quarterController,
                decoration: InputDecoration(labelText: 'Quartier'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un quartier';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _openingHourController,
                decoration: InputDecoration(labelText: 'Heure d\'ouverture'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une heure d\'ouverture';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _closingHourController,
                decoration: InputDecoration(labelText: 'Heure de fermeture'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une heure de fermeture';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              round_button(title: 'ajouter',      onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FirebaseFirestore.instance.collection('points_de_vente').add({
                    'nom': _nameController.text,
                    'ville': _cityController.text,
                    'quartier': _quarterController.text,
                    'heure_ouverture': _openingHourController.text,
                    'heure_fermeture': _closingHourController.text,
                  });

                }
              },)

            ],
          ),
        ),
      ),
    );
  }
}
