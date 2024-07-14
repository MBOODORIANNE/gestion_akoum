import 'package:flutter/material.dart';
import 'package:gestion_akoum/constants/color_app.dart';

class Produits extends StatefulWidget {
  const Produits({super.key});

  @override
  State<Produits> createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primary,
            title: Text("produits"),
            centerTitle: true,
          ),
      body: SingleChildScrollView(
          child:Column(
            children: [
              SizedBox(height: 400,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.green,
                      child: ListTile(


                        trailing: Icon(Icons.edit),
                        subtitle: Text("dorianne"),
                        title: Text("orlys"),
                        leading: Container(color: Colors.black,width: 50,),
                      ),
                    ),
                  );
                },
              ),
              )
            ],
          ) ,
      ),
    );
  }
}
