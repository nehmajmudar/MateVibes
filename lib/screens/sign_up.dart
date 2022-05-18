import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/Widgets/signup_confirm_dialogue.dart';
import 'package:matevibes/res/Methods/check_Internet_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:matevibes/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  bool checkboxTAndC = false;
  bool showErrorMessage = false;
  final _formKey = GlobalKey<FormState>();
  final usernameController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColors.colorBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 12,
                right: MediaQuery.of(context).size.width / 10,
                bottom: MediaQuery.of(context).size.height / 18.75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 7.96,
                      bottom: 5),
                  child: Text(
                    AppString.txtLetsGetStarted,
                    style: TextStyle(
                      color: AppColors.colorLetsGetStarted,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 16.88),
                  child: Text(
                    AppString.txtCreateAccountToConnect,
                    style: TextStyle(
                      color: AppColors.colorCreateAccountToConnect,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 33.76),
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorSkipforNow,
                          blurRadius: 15,
                        )
                      ]),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtUsername,
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
                      if (value!.isEmpty) {
                        return AppString.txtEnterValidEmailId;
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 33.76),
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorSkipforNow,
                          blurRadius: 15,
                        )
                      ]),
                  child: TextFormField(
                    controller: emailController,
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
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 33.76),
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorSkipforNow,
                          blurRadius: 15,
                        )
                      ]),
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtPhoneNumber,
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
                          !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                        return AppString.txtEnterValidPhoneNo;
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 33.76),
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorSkipforNow,
                          blurRadius: 15,
                        )
                      ]),
                  child: TextFormField(
                    controller: passwordController,
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
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 33.76),
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorSkipforNow,
                          blurRadius: 15,
                        )
                      ]),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtConfirmPassword,
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
                      if (confirmPasswordController.text !=
                          passwordController.text) {
                        return AppString.txtPassworddontmatch;
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: checkboxTAndC,
                        onChanged: (value) {
                          setState(() {
                            checkboxTAndC = value!;
                          });
                        }),
                    Center(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: AppString.txtByCreatingAccount,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.colorForgotPassword,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                            text: AppString.txtTAndC,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                              color: AppColors.colorSignInButton,
                              fontWeight: FontWeight.w900,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        TextSpan(
                          text: AppString.txtAnd,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.colorForgotPassword,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                            text: AppString.txtPrivacyPolicy,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                              color: AppColors.colorSignInButton,
                              fontWeight: FontWeight.w900,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ])),
                    ),
                  ],
                ),
                showErrorMessage
                    ? Container(
                        child: Text(
                          AppString.txtPleaseSelectCheckBox,
                          style: TextStyle(color: AppColors.colorRed),
                        ),
                      )
                    : Container(),
                Center(
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 12.98),
                      width: MediaQuery.of(context).size.width / 1.68,
                      height: MediaQuery.of(context).size.height / 18.75,
                      decoration: BoxDecoration(
                          color: AppColors.colorSignInButton,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      alignment: Alignment.center,
                      child: Text(
                        AppString.txtCreateAccount.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    onTap: () async {
                      final result = await Connectivity().checkConnectivity();
                      showConnectivityToastOnPress(result);

                      if (_formKey.currentState!.validate()) {
                        if (checkboxTAndC != true) {
                          setState(() {
                            showErrorMessage = true;
                          });
                        } else {
                          setState(() {
                            signUp(
                                emailController.text, passwordController.text);
                            showErrorMessage = false;
                          });
                        }
                      }
                    },
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: AppString.txtByCreatingAccount,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.colorForgotPassword,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                          text: AppString.txtSignIn,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorSignInButton,
                            fontWeight: FontWeight.w900,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()),
                                  (route) => false);
                            })
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    final prefs = await SharedPreferences.getInstance();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    prefs.setString(AppString.userIDKey, user.uid);
    print(prefs.getString(AppString.userIDKey));
    userModel.username = usernameController.text;
    userModel.phoneNumber = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: AppString.txtaccountCreatedSuccessfully);

    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => CreateAccount()),
    //     (route) => false);
    if (ConnectivityResult.mobile == true || ConnectivityResult.wifi == true) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SignUpConfirmDialogue());
    }
  }
}
