import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/ui/text_fields_ui.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.colorRed,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              margin: EdgeInsets.only(bottom: 64),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/12,right: MediaQuery.of(context).size.width/10,bottom: MediaQuery.of(context).size.height/18.75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(AppString.txtWelcome,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,fontFamily: 'Manrope'),),
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/168),
                  ),
                  Container(
                    child: Text(AppString.txtSignInToContinue,style: TextStyle(color: AppColors.colorSignInToContinue,fontSize: 14,fontWeight: FontWeight.w800,fontFamily: 'Manrope'),),
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/18,),
                  ),
                  TextFieldsUi(textFieldItem: AppString.txtEmailAddress),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/33.76,
                  ),
                  TextFieldsUi(textFieldItem: AppString.txtPassword),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      child: Text(AppString.txtForgotPassword,style: TextStyle(fontSize: 12,color: AppColors.colorForgotPassword,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),),
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/22.2,bottom: MediaQuery.of(context).size.height/11.1,),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.68,
                        height: MediaQuery.of(context).size.height/18.75,
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/9.27,),
                        decoration: BoxDecoration(
                          color: AppColors.colorSignInButton,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        alignment: Alignment.center,
                        child: Text(AppString.txtSignIn.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColors.colorWhite,fontWeight: FontWeight.w700,fontFamily: 'Manrope'),),
                      ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppString.txtDontHaveAnAccount,
                            style: TextStyle(fontSize: 14,color: AppColors.colorForgotPassword,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),),
                          TextSpan(
                            text: AppString.txtSignUp,
                            style: TextStyle(fontSize: 14,color: AppColors.colorSignInButton,fontWeight: FontWeight.w800,fontFamily: 'Manrope'),
                            recognizer: TapGestureRecognizer()
                                        ..onTap=(){}
                          )
                        ]
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
}
