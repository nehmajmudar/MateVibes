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

  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColors.colorBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('lib/assets/images/login_bgimage.png'),fit: BoxFit.cover)
                ),
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
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderOnForeground: false,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(13),
                          hintText: AppString.txtEmailAddress,
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
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
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderOnForeground: false,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(13),
                          hintText: AppString.txtPassword,
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
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
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: Text(AppString.txtForgotPassword,style: TextStyle(fontSize: 12,color: AppColors.colorForgotPassword,fontWeight: FontWeight.w400,fontFamily: 'Manrope'),),
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/22.2,bottom: MediaQuery.of(context).size.height/11.1,),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            print("Everything looks good.");
                          }
                        },
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
      ),
    );
  }
}
