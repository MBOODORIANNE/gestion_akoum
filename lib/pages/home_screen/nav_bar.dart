import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


import '../../constants/color_app.dart';
import '../../controller/navBar_controller.dart';
import '../categorie/categoriePage.dart';
import '../point_de_vente/List_point_of_sale.dart';
import '../produits/produits.dart';
import 'home_screen.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller= Get.put(NavbarController());

  @override

  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (context){
      return Scaffold(
        body:IndexedStack(
          index: controller.tabIndex,
          children:  [
             HomeScreen(),
            ProductsPage(),
            CategoriePage(),
            ListPoinTofSales()


          ],

        ) ,
//navabar working
        bottomNavigationBar:  BottomNavigationBar(
          currentIndex: controller.tabIndex,
          onTap: controller.changeTabIndex,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: Colors.grey,

          items: [
            _bottombarItem(IconlyBold.home, "Accueil"),
            _bottombarItem(IconlyBold.calendar, "produits"),

            _bottombarItem(IconlyLight.message, "chat"),

            _bottombarItem(IconlyBold.user2, "profile"),



          ],
        ),
      );
    });
  }
}
_bottombarItem(IconData icon,String lable){
  return BottomNavigationBarItem(icon: Icon(icon),label: lable);
}