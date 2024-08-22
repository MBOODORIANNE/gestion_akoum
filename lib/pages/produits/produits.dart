import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gestion_akoum/pages/produits/producDetail.dart';

import '../../constants/color_app.dart';
import '../produit/addProductWithimage.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String? selectedCategory;
  List<String> categories = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    // Récupérer les catégories depuis Firebase
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();
    setState(() {
      categories = snapshot.docs.map((doc) => doc['nomCategorie'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des produits'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barre de recherche pour filtrer les produits par nom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Rechercher un produit',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // DropdownButton pour sélectionner la catégorie
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: Text('Sélectionnez une catégorie'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: selectedCategory == null
                  ? FirebaseFirestore.instance.collection('products').snapshots()
                  : FirebaseFirestore.instance
                  .collection('products')
                  .where('categorie', isEqualTo: selectedCategory)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var products = snapshot.data!.docs;

                // Filtrer les produits par le nom recherché
                var filteredProducts = products.where((product) {
                  var productName = product['name'].toString().toLowerCase();
                  return productName.contains(searchQuery);
                }).toList();

                if (filteredProducts.isEmpty) {
                  return Center(
                    child: Text(
                      'Aucun produit trouvé',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.all(10),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    var product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailScreen(
                          name: product['name'],
                          description: product['description'],
                          category: product['categorie']!,
                          price: product['price'],
                          imageUrl: product['imageUrl'],
                        ));
                      },
                      child: ProductCard(
                        name: product['name'],
                        description: product['description'],
                        category: product['categorie']!,
                        price: product['price'],
                        imageUrl: product['imageUrl'],
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
          Get.to(ProductRegistrationScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String category;
  final double price;
  final String imageUrl;

  const ProductCard({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600]),
                  maxLines: 2,
                ),
                SizedBox(height: 4),
                Text(
                  'Category: $category',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  '${price.toStringAsFixed(2)} XAF',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
