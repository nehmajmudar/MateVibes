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
  bool _usenameValidator = false;
  bool _emailValidator = false;
  bool _phoneValidator = false;
  bool _passwordValidator = false;
  bool _confirmPasswordValidator = false;
  bool isLoading = false;

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
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Manrope',
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
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
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
                    onChanged: (val) {
                      _usenameValidator = false;
                    },
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
                        fontFamily: 'Manrope',
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        _usenameValidator = true;
                        setState(() {});
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32),
                  child: Visibility(
                      visible: _usenameValidator,
                      child: Text(
                        AppString.txtEnterValidUsername,
                        style:
                            TextStyle(fontSize: 12, color: AppColors.colorRed),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Container(
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
                    onChanged: (val) {
                      if (_emailValidator) {
                        _emailValidator = false;
                        setState(() {});
                      }
                    },
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
                        fontFamily: 'Manrope',
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        _emailValidator = true;
                        setState(() {});
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32),
                  child: Visibility(
                      visible: _emailValidator,
                      child: Text(
                        AppString.txtEnterValidEmailId,
                        style:
                            TextStyle(fontSize: 12, color: AppColors.colorRed),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Container(
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
                    onChanged: (val) {
                      if (_phoneValidator) _phoneValidator = false;
                      setState(() {});
                    },
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
                        fontFamily: 'Manrope',
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                        _phoneValidator = true;
                        setState(() {});
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32),
                  child: Visibility(
                      visible: _phoneValidator,
                      child: Text(
                        AppString.txtEnterValidPhoneNo,
                        style:
                            TextStyle(fontSize: 12, color: AppColors.colorRed),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Container(
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
                    onChanged: (val) {
                      if (_passwordValidator) _passwordValidator = false;
                    },
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
                        fontFamily: 'Manrope',
                      ),
                    ),
                    validator: (value) {
                      if (value!.length <= 6 || value.isEmpty) {
                        _passwordValidator = true;
                        setState(() {});
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32),
                  child: Visibility(
                      visible: _passwordValidator,
                      child: Text(
                        AppString.txtPasswordLengthMoreThan6,
                        style:
                            TextStyle(fontSize: 12, color: AppColors.colorRed),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Container(
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
                    onChanged: (val) {
                      if (_confirmPasswordValidator)
                        _confirmPasswordValidator = false;
                    },
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
                        fontFamily: 'Manrope',
                      ),
                    ),
                    validator: (value) {
                      if (confirmPasswordController.text !=
                          passwordController.text) {
                        _confirmPasswordValidator = true;
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32),
                  child: Visibility(
                      visible: _confirmPasswordValidator,
                      child: Text(
                        AppString.txtPassworddontmatch,
                        style:
                            TextStyle(fontSize: 12, color: AppColors.colorRed),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
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
                            fontFamily: 'Manrope',
                          ),
                        ),
                        TextSpan(
                            text: AppString.txtTAndC,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                              color: AppColors.colorSignInButton,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Manrope',
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
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Manrope',
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
                      child: !isLoading
                          ? Text(
                              AppString.txtCreateAccount.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Manrope',
                              ),
                            )
                          : CircularProgressIndicator(),
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
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Manrope',
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
        setState(() {
          isLoading = true;
        });
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

    userModel.username = usernameController.text;
    userModel.phoneNumber = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: AppString.txtaccountCreatedSuccessfully);

    if (ConnectivityResult.none != true) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SignUpConfirmDialogue());
    }
  }
}
