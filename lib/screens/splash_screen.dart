import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/Widgets/bottom_navbar.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    // String uid=checkUserStatus() as String;
    checkUserStatus();
  }

  void checkUserStatus()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var userStatus=prefs.getBool('isLoggedIn');
    print(userStatus);
    (userStatus!=null && userStatus==true)?Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                BottomNavBar()
            )
        )
    )
        :Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                SignIn()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/MateVibes_logo.png')),
            Text(AppString.txtMateVibes,style: TextStyle(fontSize: 36,fontFamily: 'Pacifico',foreground: Paint()..shader=AppColors.colorMateVibes),)
          ],
        ),
      ),
    );
  }
}
