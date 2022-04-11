import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SignInScreenWidget();
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  void showConnectivityToast(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: AppString.txtnoInternetToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.colorRed,
          textColor: AppColors.colorWhite);
      // Got a new connectivity status!
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      Fluttertoast.showToast(
          msg: AppString.txtConnectedinternetToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.greenColor,
          textColor: AppColors.colorWhite);
    } else {
      print(result.toString());
    }
  }
}

class SignInScreenWidget extends StatefulWidget {
  SignInScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignInScreenWidget> createState() => _SignInScreenWidgetState();
}

class _SignInScreenWidgetState extends State<SignInScreenWidget> {
  //Login Function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(
            msg: "No User Found from this mail,Please Enter Correct Details",
            textColor: AppColors.colorHintText,
            backgroundColor: Colors.black);
        print("No User Found For that email");
      }
    }
    return user;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColors.colorBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('lib/assets/images/login_bgimage.png'),
                        fit: BoxFit.cover)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                margin: EdgeInsets.only(bottom: 64),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12,
                    right: MediaQuery.of(context).size.width / 10,
                    bottom: MediaQuery.of(context).size.height / 18.75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        AppString.txtWelcome,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Manrope'),
                      ),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 168),
                    ),
                    Container(
                      child: Text(
                        AppString.txtSignInToContinue,
                        style: TextStyle(
                            color: AppColors.colorSkipforNow,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Manrope'),
                      ),
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 18,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderOnForeground: false,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(13),
                          hintText: AppString.txtEmailAddress,
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorHintText,
                              fontFamily: 'Manrope'),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return AppString.txtEnterValidEmailId;
                          }
                          return null;
                        },
                      ),
                      shadowColor: AppColors.colorHintText,
                      elevation: 4,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 33.76,
                    ),
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderOnForeground: false,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(13),
                          hintText: AppString.txtPassword,
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorHintText,
                              fontFamily: 'Manrope'),
                        ),
                        validator: (value) {
                          if (value!.length <= 6 || value.isEmpty) {
                            return AppString.txtPasswordLengthMoreThan6;
                          }
                          return null;
                        },
                      ),
                      shadowColor: AppColors.colorHintText,
                      elevation: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgotPassword');
                      },
                      child: Container(
                        child: Text(
                          AppString.txtForgotPassword,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.colorForgotPassword,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Manrope'),
                        ),
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 22.2,
                          bottom: MediaQuery.of(context).size.height / 11.1,
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          User? user = await loginUsingEmailPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context);
                          final result =
                              await Connectivity().checkConnectivity();
                          showConnectivityToast(result);
                          print(user);
                          if (user != null) {
                            Navigator.pushNamed(context, "/createAccount");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.68,
                          height: MediaQuery.of(context).size.height / 18.75,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 9.27,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.colorSignInButton,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          alignment: Alignment.center,
                          child: Text(
                            AppString.txtSignIn.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Manrope'),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppString.txtDontHaveAnAccount,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorForgotPassword,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Manrope'),
                          ),
                          TextSpan(
                              text: AppString.txtSignUp,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.colorSignInButton,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Manrope'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, "/signUp");
                                })
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showConnectivityToast(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: AppString.txtnoInternetToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.colorRed,
          textColor: AppColors.colorWhite);
      // Got a new connectivity status!
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      Fluttertoast.showToast(
          msg: AppString.txtConnectedinternetToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.greenColor,
          textColor: AppColors.colorWhite);
    } else {
      print(result.toString());
    }
  }
}
