import 'package:flutter/material.dart';
import 'package:gestion_akoum/admi/database.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Producteur",
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
            buildTextField("Nom", nomController),
            buildTextField("Prénom", prenomController),
            buildTextField("Email", emailController),
            buildTextField("Téléphone", telephoneController),
            buildTextField("Ville", villeController),
            buildTextField("Quartier", quartierController),
            buildTextField("Sexe", sexeController),
            buildTextField("Username", usernameController),
            buildPasswordTextField("Password", passwordController),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
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
                    "Password": passwordController.text,
                    "id": id,
                  };
                  await DatabaseMethods()
                      .addProducteurDetails(producteurInfoMap, id)
                      .then((value) {
                    Fluttertoast.showToast(
                      msg: "Producteur details have been uploaded successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  });
                },
                child: const Text(
                  "Add",
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

  Widget buildPasswordTextField(
      String labelText, TextEditingController controller) {
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
            decoration: InputDecoration(
              border: InputBorder.none,
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
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
