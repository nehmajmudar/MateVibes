import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/Widgets/bottom_navbar.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/sign_up.dart';
import 'package:matevibes/res/Methods/check_Internet_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();

    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);

    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print("User is signed out!");
      } else {
        print("User is signed in.");
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    user.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: FirebaseAuth.instance.currentUser == null
          ? FutureBuilder(
              future: _initializeFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SignInScreenWidget();
                }
                return const Center(child: CircularProgressIndicator());
              })
          : BottomNavBar(),
    );
  }
}

class SignInScreenWidget extends StatefulWidget {
  SignInScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignInScreenWidget> createState() => _SignInScreenWidgetState();
}

class _SignInScreenWidgetState extends State<SignInScreenWidget> {
  late SharedPreferences _prefs;

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
            msg: AppString.txtnoUserFoundFromThisMail,
            textColor: AppColors.colorWhite,
            backgroundColor: AppColors.colorBlack);
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/login_bgimage.png'),
                          fit: BoxFit.cover)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  // margin: EdgeInsets.only(bottom: 64),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2.6,
                        right: MediaQuery.of(context).size.width / 2.6,
                        top: 50),
                    width: MediaQuery.of(context).size.width / 4.28,
                    height: MediaQuery.of(context).size.height / 13.39,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/MateVibes_logo.png'),
                            fit: BoxFit.cover)),
                  ),
                  right: 0.0,
                  left: 0.0,
                  top: 0.0,
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.65),
              decoration: BoxDecoration(
                color: AppColors.colorBackgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(53)),
              ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 16.54,
                left: MediaQuery.of(context).size.width / 12,
                right: MediaQuery.of(context).size.width / 10,
              ),
              //bottom: MediaQuery.of(context).size.height / 18.75),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            AppString.txtWelcome,
                            style: TextStyle(
                              color: AppColors.colorLetsGetStarted,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 168),
                        ),
                        Container(
                          child: Text(
                            AppString.txtSignInToContinue,
                            style: TextStyle(
                              color: AppColors.colorCreateAccountToConnect,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 18,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height / 33.76),
                          decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.colorSkipforNow,
                                  blurRadius: 15,
                                )
                              ]),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 18.75,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(13),
                                hintText: AppString.txtEmailAddress,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50)),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.colorHintText,
                                ),
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
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.colorSkipforNow,
                                  blurRadius: 15,
                                )
                              ]),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 18.75,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(13),
                                hintText: AppString.txtPassword,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50)),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.colorHintText,
                                ),
                              ),
                              validator: (value) {
                                if (value!.length <= 6 || value.isEmpty) {
                                  return AppString.txtPasswordLengthMoreThan6;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/forgot_password");
                          },
                          child: Container(
                            child: Text(
                              AppString.txtForgotPassword,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.colorForgotPassword,
                                  fontWeight: FontWeight.w900,
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
                              if (user != null) {
                                await _prefs.setString(
                                    AppString.userIDKey, user.uid);
                                print("LoggedIn UserIs ${user.uid}");
                              }
                              final result =
                                  await Connectivity().checkConnectivity();
                              showConnectivityToastOnPress(result);
                              print(user);
                              if (user != null &&
                                      ConnectivityResult.mobile == true ||
                                  ConnectivityResult.wifi == true) {
                                Navigator.pushNamed(context, "/navbar");
                              } else if (ConnectivityResult.none == true) {
                                showConnectivityToastOnPress(result);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.68,
                              height:
                                  MediaQuery.of(context).size.height / 18.75,
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 9.27,
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
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 0.0,
                    right: 0.0,
                    //alignment: Alignment.bottomCenter,
                    child: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppString.txtDontHaveAnAccount,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.colorForgotPassword,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                              text: AppString.txtSignUp,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorSignInButton,
                                fontWeight: FontWeight.w900,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                })
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      _prefs = sharedPref;
    });
  }
}
