import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:matevibes/ui/text_fields_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  //our form key
  final _formKey = GlobalKey<FormState>();
  bool checkboxTAndC = false;
  //editio Controller
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                TextFieldsUi(
                  textFieldItem: AppString.txtUsername,
                  controller: _usernameController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
                ),
                TextFieldsUi(
                  textFieldItem: AppString.txtEmailAddress,
                  controller: _emailController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
                ),
                TextFieldsUi(
                  textFieldItem: AppString.txtPhoneNumber,
                  controller: _phoneNumberController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
                ),
                TextFieldsUi(
                    textFieldItem: AppString.txtPassword,
                    controller: _passwordController),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 33.76,
                ),
                TextFieldsUi(
                  textFieldItem: AppString.txtConfirmPassword,
                  controller: _confirmPasswordController,
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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      signUp(_emailController.text, _passwordController.text);
                    },
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
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: AppString.txtContinueTo,
                        style: TextStyle(
                            fontSize: 14,
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
                          recognizer: TapGestureRecognizer()..onTap = () {})
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
          Fluttertoast.showToast(msg: e.message);
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

    userModel.username = _usernameController.text;
    userModel.phoneNumber = _phoneNumberController.text as int?;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
  }
}
