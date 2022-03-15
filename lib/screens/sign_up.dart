import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:matevibes/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  bool checkboxTAndC = false;
  bool showErrorMessage = false;
  final _formKey = GlobalKey<FormState>();
//editio Controller
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
                        fontFamily: 'Manrope'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 16.88),
                  child: Text(
                    AppString.txtCreateAccountToConnect,
                    style: TextStyle(
                        color: AppColors.colorLetsGetStarted,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Manrope'),
                  ),
                ),
                Material(
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtUsername,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                          fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
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
                  child: TextFormField(
                    controller: emailController,
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
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtPhoneNumber,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                          fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
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
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
                ),
                Material(
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtPassword,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                          fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
                ),
                Material(
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtConfirmPassword,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                          fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
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
                              fontFamily: 'Manrope'),
                        ),
                        TextSpan(
                            text: AppString.txtTAndC,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.colorSignInButton,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Manrope'),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        TextSpan(
                          text: AppString.txtAnd,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.colorForgotPassword,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Manrope'),
                        ),
                        TextSpan(
                            text: AppString.txtPrivacyPolicy,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.colorSignInButton,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Manrope'),
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
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Manrope'),
                      ),
                    ),
                    onTap: () {
                      print("hello");
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
                            fontFamily: 'Manrope'),
                      ),
                      TextSpan(
                          text: AppString.txtSignIn,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.colorSignInButton,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope'),
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
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;

    userModel.username = usernameController.text;
    userModel.phoneNumber = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
  }
}
