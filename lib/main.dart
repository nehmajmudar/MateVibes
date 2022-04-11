import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/screens/chat_screen.dart';
import 'package:matevibes/screens/create_account.dart';
import 'package:matevibes/screens/forgot_password.dart';
import 'package:matevibes/screens/home_screen.dart';
import 'package:matevibes/screens/notification_screen.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:matevibes/screens/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SignIn(),
        "/home": (context) => HomeScreen(),
        "/signUp": (context) => SignUp(),
        '/forgotPassword': (context) => ForgotPassword(),
        '/createAccount': ((context) => CreateAccount())
      },
    );
  }
}
