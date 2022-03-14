import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

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

  @override
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
        print("No User Found For that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    //textFieldController
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: AppColors.colorRed,
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
                Text(
                  AppString.txtWelcome,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Manrope'),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  AppString.txtSignInToContinue,
                  style: TextStyle(
                      color: AppColors.colorSignInToContinue,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Manrope'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                ),
                Material(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtEmailAddress,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                          fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
                ),
                Material(
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtPassword,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                          fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 22.2,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    AppString.txtForgotPassword,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.colorForgotPassword,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Manrope'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 11.1,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      User? user = await loginUsingEmailPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                      print(user);
                      if (user != null) {
                        Navigator.pushNamed(context, "/home");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.68,
                      height: MediaQuery.of(context).size.height / 18.75,
                      decoration: BoxDecoration(
                          color: AppColors.colorSignInButton,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9.27,
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
    );
  }
}
