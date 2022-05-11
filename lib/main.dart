import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/signup_confirm_dialogue.dart';
import 'package:matevibes/models/user_model.dart';
import 'package:matevibes/screens/chat_screen.dart';
import 'package:matevibes/screens/create_account.dart';
import 'package:matevibes/screens/create_post_screen.dart';
import 'package:matevibes/screens/forgot_password.dart';
import 'package:matevibes/Widgets/bottom_navbar.dart';
import 'package:matevibes/screens/home_page_screen.dart';
import 'package:matevibes/screens/notification_screen.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:matevibes/screens/sign_up.dart';
import 'package:matevibes/screens/splash_screen.dart';
import 'package:matevibes/res/Methods/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    @override
    void initState() {
      // checkUserLoginState();
      super.initState();
    }


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // initialRoute: FirebaseAuth.instance.currentUser==null?'/':'/navbar',
      // initialRoute: islogin!=null
      //                   ? '/navbar'
      //                   : '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/splash_screen': (context) => SplashScreen(),
        "/home": (context) => HomePageScreen(),
        '/navbar': (context) => BottomNavBar(),
        "/sign_up": (context) => SignUp(),
        "/sign_in": (context) => SignIn(),
        '/forgot_password': (context) => ForgotPassword(),
        '/notification_screen': (context) => NotificationScreen(),
        '/chat_screen': (context) => ChatScreen(),
        '/create_account_screen': (context) => CreateAccount(),
      },
    );
  }
}
