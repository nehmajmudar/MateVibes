import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/bottom_navbar.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/create_account.dart';
import 'package:matevibes/screens/sign_in.dart';

class SignUpConfirmDialogue extends StatelessWidget {
  const SignUpConfirmDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3.71,
            width: MediaQuery.of(context).size.width/1.25,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11.2,right: MediaQuery.of(context).size.width/9),
                child: Column(
                  children: [
                    Text(
                      AppString.txtAccountCreatedSuccessfully,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(fontSize: 18,color: AppColors.colorLetsGetStarted,fontFamily: 'Manrope',fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/40),
                        height: MediaQuery.of(context).size.height/18.75,
                        width: MediaQuery.of(context).size.width/1.68,
                        decoration: BoxDecoration(
                            color: AppColors.colorSignInButton,
                            borderRadius: BorderRadius.all(
                                Radius.circular(50))),
                        alignment: Alignment.center,
                        child: Text(
                          AppString.txtContinue.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width/3.9,
            right: MediaQuery.of(context).size.width/3.9,
            bottom: MediaQuery.of(context).size.height/5.24,
            child: Image(image: AssetImage('lib/assets/images/Ellipse 1.png'))
          ),
          Positioned(
              left: MediaQuery.of(context).size.width/3.45,
              right: MediaQuery.of(context).size.width/3.45,
              bottom: MediaQuery.of(context).size.height/4.62,
              child: Image(image: AssetImage('lib/assets/images/Ellipse 2.png'))
          ),
          Positioned(
              left: MediaQuery.of(context).size.width/3.04,
              right: MediaQuery.of(context).size.width/3.04,
              bottom: MediaQuery.of(context).size.height/4.2,
              child: Image(image: AssetImage('lib/assets/images/Ellipse 3.png'))
          ),
          Positioned(
              left: MediaQuery.of(context).size.width/2.63,
              right: MediaQuery.of(context).size.width/2.63,
              bottom: MediaQuery.of(context).size.height/3.94,
              child: Image(image: AssetImage('lib/assets/images/checkmark.png'))
          ),
        ],
      ),
    );
  }
}
