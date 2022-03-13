import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool checkboxTAndC=false;
  bool showErrorMessage=false;
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/12,right: MediaQuery.of(context).size.width/10,bottom: MediaQuery.of(context).size.height/18.75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/7.96,bottom: 5),
                  child: Text(AppString.txtLetsGetStarted,style: TextStyle(color: AppColors.colorLetsGetStarted,fontSize: 24,fontWeight: FontWeight.w800,fontFamily: 'Manrope'),),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/16.88),
                  child: Text(AppString.txtCreateAccountToConnect,style: TextStyle(color: AppColors.colorLetsGetStarted,fontSize: 14,fontWeight: FontWeight.w800,fontFamily: 'Manrope'),),
                ),
                Material(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtUsername,
                      hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return AppString.txtEnterValidEmailId;
                      }
                      return null;
                    },
                  ),
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/33.76,
                ),
                Material(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtEmailAddress,
                      hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                        return AppString.txtEnterValidEmailId;
                      }
                      return null;
                    },
                  ),
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/33.76,
                ),
                Material(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtPhoneNumber,
                      hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r"^[0-9]{10}$").hasMatch(value)){
                        return AppString.txtEnterValidPhoneNo;
                      }
                      return null;
                    },
                  ),
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/33.76,
                ),
                Material(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtPassword,
                      hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value){
                      if(value!.length<=6 || value.isEmpty){
                        return AppString.txtPasswordLengthMoreThan6;
                      }
                      return null;
                    },
                  ),
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/33.76,
                ),
                Material(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      hintText: AppString.txtConfirmPassword,
                      hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value){
                      if(value!.length<=6 || value.isEmpty){
                        return AppString.txtPasswordLengthMoreThan6;
                      }
                      return null;
                    },
                  ),
                  shadowColor: AppColors.colorHintText,
                  elevation: 4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/33.76,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: checkboxTAndC,
                      onChanged: (value){
                        setState(() {
                          checkboxTAndC=value!;
                        });
                      }
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: AppString.txtByCreatingAccount,
                              style: TextStyle(fontSize: 12,color: AppColors.colorForgotPassword,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),),
                            TextSpan(
                                text: AppString.txtTAndC,
                                style: TextStyle(fontSize: 12,color: AppColors.colorSignInButton,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),
                                recognizer: TapGestureRecognizer()
                                  ..onTap=(){}
                            ),
                            TextSpan(
                              text: AppString.txtAnd,
                              style: TextStyle(fontSize: 12,color: AppColors.colorForgotPassword,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),),
                            TextSpan(
                                text: AppString.txtPrivacyPolicy,
                                style: TextStyle(fontSize: 12,color: AppColors.colorSignInButton,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),
                                recognizer: TapGestureRecognizer()
                                  ..onTap=(){}
                            ),
                          ]
                        )
                      ),
                    ),
                  ],
                ),
                showErrorMessage ?
                    Container(
                      child: Text(AppString.txtPleaseSelectCheckBox,style: TextStyle(color: AppColors.colorRed),),
                    )
                : Container(),
                Center(
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/12.98),
                      width: MediaQuery.of(context).size.width/1.68,
                      height: MediaQuery.of(context).size.height/18.75,
                      decoration: BoxDecoration(
                          color: AppColors.colorSignInButton,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      alignment: Alignment.center,
                      child: Text(AppString.txtCreateAccount.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColors.colorWhite,fontWeight: FontWeight.w700,fontFamily: 'Manrope'),),
                    ),
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        if(checkboxTAndC != true){
                          setState(() {
                            showErrorMessage=true;
                          });
                        }
                        else{
                          setState(() {
                            showErrorMessage=false;
                          });
                        }
                      }
                    },
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppString.txtContinueTo,
                          style: TextStyle(fontSize: 14,color: AppColors.colorForgotPassword,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),),
                        TextSpan(
                            text: AppString.txtSignIn,
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
        ),
      ),
    );
  }
}
