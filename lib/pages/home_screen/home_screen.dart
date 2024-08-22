
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_akoum/constants/color_app.dart';
import 'package:gestion_akoum/pages/categorie/allCategories.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../composants/image_string.dart';
import '../../controller/categorieController.dart';
import '../../models/Categorie.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategorieService categorieService = CategorieService();
  TextEditingController TxtSearch=TextEditingController();
  String? nomUtilisateur;
  @override
  void initState(){
    super.initState();
    _fetchUserData();
    categorieService.recupererCategories();

  }
  Future<void> _fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(currentUser.uid)
          .get();
      setState(() {
        nomUtilisateur = userDoc['nomUtilisateur'];
      });
    }
  }
  Widget build(BuildContext context) {
    return   Scaffold(

      body:
      FutureBuilder<List<Categorie>>(
        future: categorieService.recupererCategories(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Erreur : ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Center(child: Text('Aucune catégorie trouvée'));
    } else {
    List<Categorie> categories = snapshot.data!;

        return SingleChildScrollView(
        child: SafeArea(

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Icon(Icons.menu,color: Colors.black, size: 30,),
                    Icon(IconlyLight.notification,color: Colors.black,size: 22),
                  ],),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bienvenue",style: TextStyle(color: Colors.grey,fontSize:16),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nomUtilisateur != null
                            ? Text(
                          nomUtilisateur!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                            : CircularProgressIndicator(),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.primary,width: 1)
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColor.white,
                            child: Image.asset(Applogo),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(

                            children: [
                              Container(
                                height: 200,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(15),

                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    Center(child: Text("producteurs",style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold),),),
                                    SizedBox(height: 15,),
                                    const Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 100.0,
                                          height: 100.0,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            value: 0.7, // Valeur entre 0.0 et 1.0
                                            strokeWidth: 8.0, // Épaisseur de la barre de progression
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow), // Couleur de la barre de progression
                                          ),
                                        ),
                                        Text(
                                          '70%', // Texte à afficher au centre
                                          style: TextStyle(
                                            fontSize: 20.0, // Taille du texte
                                            fontWeight: FontWeight.bold, // Style du texte
                                            color: Colors.white, // Couleur du texte
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                height: 200,
                                width: 170,
                                decoration: BoxDecoration(
                                  border:Border.all(color: AppColor.primary,width: 1),
                                  borderRadius: BorderRadius.circular(15),

                                ),
                                child: Column(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("Produit local",style: TextStyle(color: AppColor.primary,fontWeight: FontWeight.bold,fontSize: 14),),
                                          Text("30",style: TextStyle(color: AppColor.primary,fontWeight: FontWeight.bold,fontSize: 14)),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    Container( height: 2,width: 140,color: AppColor.primary,),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: LinearProgressIndicator(
                                        borderRadius: BorderRadius.circular(10),
                                        value: 0.7, // Valeur entre 0.0 et 1.0. Enlever pour une barre de progression indéterminée
                                        backgroundColor: Colors.grey[200], // Couleur de fond de la barre de progression
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Couleur de la barre de progression
                                        minHeight: 10.0, // Hauteur de la barre de progression
                                      ),
                                    ),
                                    Text(
                                      '70%', // Texte à afficher en dessous de la barre de progression
                                      style: TextStyle(
                                        fontSize: 20.0, // Taille du texte
                                        fontWeight: FontWeight.bold, // Style du texte
                                        color: Colors.black, // Couleur du texte
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("categories",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                        TextButton(onPressed:(){
                          Get.to(CategoriePage());
                        }, child:Text("voir plus",style: TextStyle(color:AppColor.primary,fontWeight: FontWeight.bold,fontSize: 16),))

                      ],
                    ),
                    SizedBox(
                        height: 50,
                        child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              Categorie categorie = categories[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal:2),
                                child: Container(
                                  width: 110,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(13),

                                  ),
                                  child: Center(child: Text(categorie.nomCategorie.toString(),style: TextStyle( color: Colors.white),),),
                                ),
                              );
                            }
                        )
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("Produits local",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                        Text("(30)",style: TextStyle(color:AppColor.primary,fontWeight: FontWeight.bold,fontSize: 16),),

                      ],
                    ),

                    SizedBox(
                      height: 400,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .limit(5) // Limite à 5 produits
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Erreur : ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('Aucun produit trouvé'));
                          } else {
                            var products = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                var product = products[index];
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    height: 97,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          product['imageUrl'], // Assurez-vous que les images sont stockées dans Firestore
                                          width: 80, // Ajustez la taille de l'image
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 20),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product['name'], // Nom du produit
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                                                 
                                              Text(
                                                '${product['price']} FCFA', // Prix du produit
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    )

                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
    }
    )
    );
  }



}
