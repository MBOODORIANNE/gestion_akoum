import 'package:flutter/material.dart';
import 'package:gestion_akoum/admi/database.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/color_app.dart';

class Producteur extends StatefulWidget {
  const Producteur({super.key});

  @override
  State<Producteur> createState() => _ProducteurState();
}

class _ProducteurState extends State<Producteur> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  final TextEditingController quartierController = TextEditingController();
  final TextEditingController sexeController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Ajouter un Producteur ",
          style: TextStyle(
            color:AppColor.primary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light().copyWith(primary: AppColor.primary),
        ),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 3) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              _submitForm();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              children: <Widget>[
                if (_currentStep < 3)
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Continuer'),
                  ),
                if (_currentStep == 3)
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Terminé'),
                  ),
                const SizedBox(width: 8),
                if (_currentStep > 0)
                  ElevatedButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Retour'),
                  ),
              ],
            );
          },
          steps: [
            Step(
              title: const Text("Information Personnelle"),
              content: Column(
                children: [
                  buildTextField("Nom", nomController),
                  buildTextField("Prénom", prenomController),
                  buildTextField("Sexe", sexeController),
                ],
              ),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text("Contact"),
              content: Column(
                children: [
                  buildTextField("Email", emailController),
                  buildTextField("Téléphone", telephoneController),
                  buildTextField("Ville", villeController),
                  buildTextField("Quartier", quartierController),
                ],
              ),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text("Compte"),
              content: Column(
                children: [
                  buildTextField("Username", usernameController),
                  buildPasswordTextField("Password", passwordController),
                ],
              ),
              isActive: _currentStep >= 2,
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text("Confirmation"),
              content: const Text(
                "Cliquez sur 'Terminé' pour terminer l'enregistrement.",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              isActive: _currentStep >= 3,
              state: _currentStep == 3 ? StepState.complete : StepState.indexed,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    String id = randomAlphaNumeric(10);
    Map<String, dynamic> producteurInfoMap = {
      "Nom": nomController.text,
      "Prénom": prenomController.text,
      "Email": emailController.text,
      "Téléphone": telephoneController.text,
      "Ville": villeController.text,
      "Quartier": quartierController.text,
      "Sexe": sexeController.text,
      "Username": usernameController.text,

    };
    await DatabaseMethods()
        .addProducteurDetails(producteurInfoMap, id)
        .then((value) {
      Fluttertoast.showToast(
        msg: "Les détails du producteur ont été téléchargés avec succès",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }

  Widget buildPasswordTextField(
      String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        obscureText: !_isPasswordVisible,
      ),
    );
  }
}
