import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_akoum/pages/Login_signup/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../composants/image_string.dart';
import '../../constants/color_app.dart';


class SplashScreen extends StatefulWidget {


  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    goWelcomePage();

  }

  void goWelcomePage()async{
    await Future.delayed(Duration(seconds: 5));
    welcompage();
  }

  void welcompage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        padding: EdgeInsets.only(top: 250.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Animate(
                    child:Image.asset(Applogo,height: 100, width: 100,),
                  ),
              SizedBox(height: 10.h,),
              Text("AKOM",style: GoogleFonts.montserrat(
                fontSize: 40,
                color:AppColor.primary,
                fontWeight:FontWeight.bold,
              ),).animate().fade(duration: 2.seconds).scale(duration: 3.seconds)

            ],
          ),
        ),
      ),
    );
  }
}
