import 'dart:ffi';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../composants/image_string.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List dataCart=[
    {
      "image":c1,
      "description":"doctor",
    },
    {
      "image":c2,
      "description":"Pharmacy",
    },
    {
      "image":c3,
      "description":"hospital",
    },
    {
      "image":c4,
      "description":"Ambulance",
    }
  ];

  List DoctorCard=[
    {
      "name":"Dr. Marcus Horizon",
      "location":"800m away",
      "desc":"Psychologist",
      "image":"assets/image/Avatar.png",
    },
    {
      "name":"Dr. Maria Elena",
      "location":"1,5km away",
      "desc":"Chardiologist",
      "image":"assets/image/a2.png",
    },
    {
      "name":"Dr. Stevi Jessi",
      "location":"2km away",
      "image":"assets/image/a3.png",
      "desc":"Orthopedist",
    },
  ];

  TextEditingController TxtSearch=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(



    );
  }



}
