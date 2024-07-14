import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_akoum/pages/Login_signup/welcome_screen.dart';
import 'package:gestion_akoum/pages/home.dart';
import 'package:gestion_akoum/pages/splashScreen/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gestion_akoum/pages/produit/product.dart';
import 'package:gestion_akoum/pages/produit/product_list_screen.dart';
import 'package:gestion_akoum/pages/produit/doctor_list.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => GetMaterialApp(
        title: 'Akom',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ProductListScreen(),
        debugShowCheckedModeBanner: false,
      ),
      designSize: Size(360, 690),
    );
  }
}
