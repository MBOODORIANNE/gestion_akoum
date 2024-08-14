import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_akoum/composants/RoundedButton.dart';

class EditPointOfSale extends StatefulWidget {
  final String id;
  final DocumentSnapshot pointOfSale;

  EditPointOfSale(this.id, this.pointOfSale);

  @override
  _EditPointOfSaleState createState() => _EditPointOfSaleState();
}

class _EditPointOfSaleState extends State<EditPointOfSale> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late TextEditingController _quarterController;
  late TextEditingController _openingHourController;
  late TextEditingController _closingHourController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pointOfSale['nom']);
    _cityController = TextEditingController(text: widget.pointOfSale['ville']);
    _quarterController = TextEditingController(text: widget.pointOfSale['quartier']);
    _openingHourController = TextEditingController(text: widget.pointOfSale['heure_ouverture']);
    _closingHourController = TextEditingController(text: widget.pointOfSale['heure_fermeture']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Éditer un Point de Vente'),
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
              round_button(title: "Editer", onPressed:(){
                if (_formKey.currentState!.validate()) {
                  FirebaseFirestore.instance.collection('points_de_vente').doc(widget.id).update({
                    'nom': _nameController.text,
                    'ville': _cityController.text,
                    'quartier': _quarterController.text,
                    'heure_ouverture': _openingHourController.text,
                    'heure_fermeture': _closingHourController.text,
                  });
                  Navigator.pop(context);
                }
              })

            ],
          ),
        ),
      ),
    );
  }
}
