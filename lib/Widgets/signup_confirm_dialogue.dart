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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3.71,
              width: MediaQuery.of(context).size.width/1.25,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/11.2),
                  child: Column(
                    children: [
                      Text(
                        AppString.txtAccountCreatedSuccessfully,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18,color: AppColors.colorLetsGetStarted,fontFamily: 'Manrope',fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                              (context),
                              MaterialPageRoute(builder: (context) => CreateAccount()),
                                  (route) => false);
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
                                fontWeight: FontWeight.w700,
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
              top: -64.5,
              child: Image(image: AssetImage('assets/images/Ellipse 1.png'))
            ),
            Positioned(
              left: MediaQuery.of(context).size.width/3.45,
              right: MediaQuery.of(context).size.width/3.45,
              top: -50.5,
              child: Image(image: AssetImage('assets/images/Ellipse 2.png'))
            ),
            Positioned(
              left: MediaQuery.of(context).size.width/3.04,
              right: MediaQuery.of(context).size.width/3.04,
              top: -35.5,
              child: Image(image: AssetImage('assets/images/Ellipse 3.png'))
            ),
            Positioned(
              left: MediaQuery.of(context).size.width/2.73,
              right: MediaQuery.of(context).size.width/2.73,
              top: -20,
              child: Icon(Icons.check_sharp,color: AppColors.colorWhite,size: 40),
                // child: Image(image: AssetImage('lib/assets/images/checkmark.png'),width: MediaQuery.of(context).size.width/13.44,height: MediaQuery.of(context).size.height/42.2,)
            ),
          ],
        ),
      ),
    );
  }
}
