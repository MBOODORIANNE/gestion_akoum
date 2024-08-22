import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_akoum/admi/Producteur.dart';
import 'package:gestion_akoum/admi/database.dart';
import 'package:gestion_akoum/constants/color_app.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  // Déclaration des contrôleurs
  TextEditingController nomcontroller = TextEditingController();
  TextEditingController prenomcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController telephonecontroller = TextEditingController();
  TextEditingController villecontroller = TextEditingController();
  TextEditingController quartiercontroller = TextEditingController();
  TextEditingController sexecontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool _obscurePassword = true; // Booléen pour masquer/afficher le mot de passe
  bool _isPasswordVisible = false;

  Stream? ProducteurStream;

  // Chargement des détails des producteurs
  getontheload() async {
    ProducteurStream = await DatabaseMethods().getProducteurDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  // Méthode pour afficher les détails des producteurs
  Widget allProducteurDetails() {
    return StreamBuilder(
      stream: ProducteurStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Card(
              elevation: 3.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Nom", ds["Nom"], Icons.person),
                    _buildDetailRow("Prénom", ds["Prénom"], Icons.person_outline),
                    _buildDetailRow("Email", ds["Email"], Icons.email),
                    _buildDetailRow("Téléphone", ds["Téléphone"], Icons.phone),
                    _buildDetailRow("Ville", ds["Ville"], Icons.location_city),
                    _buildDetailRow("Quartier", ds["Quartier"], Icons.home),
                    _buildDetailRow("Sexe", ds["Sexe"], Icons.person_pin),
                    _buildDetailRow("Username", ds["Username"], Icons.account_circle),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: AppColor.primary),
                          onPressed: () {
                            nomcontroller.text = ds["Nom"];
                            prenomcontroller.text = ds["Prénom"];
                            emailcontroller.text = ds["Email"];
                            telephonecontroller.text = ds["Téléphone"];
                            villecontroller.text = ds["Ville"];
                            quartiercontroller.text = ds["Quartier"];
                            sexecontroller.text = ds["Sexe"];
                            usernamecontroller.text = ds["Username"];
                            passwordcontroller.text = ds["Password"];
                            EditProducteurDetails(ds["id"]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            final id = ds["id"].toString();
                            await DatabaseMethods().deleteProducteurDetails(id);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Méthode pour créer une ligne de détail
  Widget _buildDetailRow(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color:  AppColor.primary),
          SizedBox(width: 10.0),
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Producteur()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Liste Producteurs",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor:  AppColor.primary,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: [
            Expanded(child: allProducteurDetails()),
          ],
        ),
      ),
    );
  }

  Future EditProducteurDetails(String id) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Row(
        children: [
          Icon(Icons.edit, color: AppColor.primary),
          SizedBox(width: 10.0),
          Text(
            "Modifier les détails",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField("Nom", nomcontroller),
            buildTextField("Prénom", prenomcontroller),
            buildTextField("Email", emailcontroller),
            buildTextField("Téléphone", telephonecontroller),
            buildTextField("Ville", villecontroller),
            buildTextField("Quartier", quartiercontroller),
            buildTextField("Sexe", sexecontroller),
            buildTextField("Username", usernamecontroller),

          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Annuler",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Map<String, dynamic> updateInfo = {
              "Nom": nomcontroller.text,
              "Prénom": prenomcontroller.text,
              "Email": emailcontroller.text,
              "Téléphone": telephonecontroller.text,
              "Ville": villecontroller.text,
              "Quartier": quartiercontroller.text,
              "Sexe": sexecontroller.text,
              "Username": usernamecontroller.text,

            };
            await DatabaseMethods()
                .updateProducteurDetails(id, updateInfo)
                .then((value) {
              Navigator.pop(context);
            });
          },
          child: Text("Mettre à jour"),
        ),
      ],
    ),
  );

  // Méthode pour créer un champ de texte avec du style
  Widget buildTextField(String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: obscureText,
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  // Méthode pour créer un champ de texte pour le mot de passe
  Widget buildPasswordTextField(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: controller,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color:  AppColor.primary,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
