import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/res/Methods/check_Internet_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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

  @override
  final emailController = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 9.76,
              bottom: MediaQuery.of(context).size.height / 18.75),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.25,
                height: MediaQuery.of(context).size.height / 4.51,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 18.26,
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/forgot_password_img.png',
                        ),
                        fit: BoxFit.cover)),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 8.29, bottom: 5),
                child: Text(
                  AppString.txtForgotPassword,
                  style: TextStyle(
                    color: AppColors.colorLetsGetStarted,
                    fontSize: 24,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 8.29),
                  child: Text(
                    AppString.txtForgotPasswordText,
                    style: TextStyle(
                        color: AppColors.colorForgotPassword,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.colorSkipforNow,
                        blurRadius: 15,
                      )
                    ]
                ),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 27.22,
                    horizontal: MediaQuery.of(context).size.width / 10.83),
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
                        color: AppColors.colorHintText,),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 9.51,
                          right: MediaQuery.of(context).size.width / 32.5,
                          bottom: MediaQuery.of(context).size.height / 28.13),
                      child: Text(
                        AppString.txtOR,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                        ),
                      )),
                  Divider(
                    indent: MediaQuery.of(context).size.width / 6.61,
                    height: 20,
                    thickness: 20,
                    color: AppColors.colorRed,
                  ),
                ],
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
                    ]
                ),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 10.04,
                    right: MediaQuery.of(context).size.width / 10.83,
                    left: MediaQuery.of(context).size.width / 10.83),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(13),
                    hintText: AppString.txtPhoneNumber,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorHintText,),
                  ),
                ),
              ),
              Center(
                  child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 12.98),
                        width: MediaQuery.of(context).size.width / 1.68,
                        height: MediaQuery.of(context).size.height / 18.75,
                        decoration: BoxDecoration(
                            color: AppColors.colorSignInButton,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        alignment: Alignment.center,
                        child: Text(
                          AppString.txtContinue.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.w800,),
                        ),
                      ),
                      onTap: () async {
                        final result = await Connectivity().checkConnectivity();
                        showConnectivityToastOnPress(result);

                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: emailController.text)
                            .then((value) {
                          Navigator.pop(context);
                        });
                        Fluttertoast.showToast(
                            msg: AppString.txtpasswordLinkSentSuccessfully,
                            backgroundColor: AppColors.colorLetsGetStarted);
                      })),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: AppString.txtContinueTo,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorForgotPassword,
                          fontWeight: FontWeight.w400,),
                    ),
                    TextSpan(
                        text: AppString.txtSignIn,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorSignInButton,
                            fontWeight: FontWeight.w900,),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          })
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
