import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/sign_in.dart';

class ProfileScreenButtons extends StatefulWidget {
  const ProfileScreenButtons({Key? key}) : super(key: key);

  @override
  _ProfileScreenButtonsState createState() => _ProfileScreenButtonsState();
}

class _ProfileScreenButtonsState extends State<ProfileScreenButtons> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> onTapActivity(String userButtonName)async{
    print('sign out working?');
    if(userButtonName==AppString.txtSignOut){
      await _auth.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/12.18,right: MediaQuery.of(context).size.width/12.18,bottom: MediaQuery.of(context).size.height/50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){},
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/2.76,
              height: MediaQuery.of(context).size.height/28.13,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: AppColors.colorBlack)
              ),
              child: Text(AppString.txtEditProfile,style: TextStyle(color: AppColors.colorSelectedItemNavBar,fontSize: 12,fontWeight: FontWeight.bold),),
            ),
          ),
          GestureDetector(
            // onTap: onTapActivity(AppString.txtSignOut),
            onTap: () async =>onTapActivity(AppString.txtSignOut),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/2.76,
              height: MediaQuery.of(context).size.height/28.13,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: AppColors.colorBlack)
              ),
              child: Text(AppString.txtSignOut,style: TextStyle(color: AppColors.colorSelectedItemNavBar,fontSize: 12,fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }
}
