import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_akoum/composants/textfield_with_icon.dart';
import 'package:gestion_akoum/constants/color_app.dart';
import 'package:gestion_akoum/pages/point_de_vente/AddPointOfSale.dart';
import 'package:gestion_akoum/pages/point_de_vente/EditePointofSale.dart';
import 'package:get/get.dart';

class ListPoinTofSales extends StatefulWidget {
  const ListPoinTofSales({super.key});

  @override
  State<ListPoinTofSales> createState() => _ListPoinTofSalesState();
}

class _ListPoinTofSalesState extends State<ListPoinTofSales> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Point de vente",
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: textFieldWith_icon(
                textEditingController: searchController,
                title: "search",
                icon: Icons.search),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('points_de_vente').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final pointsOfSale = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final nom = data['nom'].toString().toLowerCase();
                  final ville = data['ville'].toString().toLowerCase();
                  final quartier = data['quartier'].toString().toLowerCase();
                  final query = searchQuery.toLowerCase();

                  return nom.contains(query) || ville.contains(query) || quartier.contains(query);
                }).toList();

                if (pointsOfSale.isEmpty) {
                  return Center(child: Text("Aucun point de vente trouvé"));
                }

                return ListView.builder(
                  itemCount: pointsOfSale.length,
                  itemBuilder: (context, index) {
                    final pointOfSale = pointsOfSale[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.primary,
                        ),
                        child: ListTile(
                          title: Text(
                            pointOfSale['nom'],
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${pointOfSale['ville']}, ${pointOfSale['quartier']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColor.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditPointOfSale(pointOfSale.id, pointOfSale),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColor.white,
                                ),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('points_de_vente')
                                      .doc(pointOfSale.id)
                                      .delete();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        onPressed: () {
          Get.to(AddPointOfSale());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
