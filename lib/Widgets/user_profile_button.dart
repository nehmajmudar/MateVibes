import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileButton extends StatefulWidget {

  final String userButtonName;
  const UserProfileButton({Key? key,required this.userButtonName}) : super(key: key);

  @override
  _UserProfileButtonState createState() => _UserProfileButtonState();
}

class _UserProfileButtonState extends State<UserProfileButton> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onTapActivity(String userButtonName)async{
    if(userButtonName==AppString.txtSignOut){
      await _auth.signOut();
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.remove('userId');
      print('userId key removed? ${prefs.getString('userId')}');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTapActivity(widget.userButtonName),
      child: Container(
        width: MediaQuery.of(context).size.width/2.76,
        height: MediaQuery.of(context).size.height/28.13,
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(widget.userButtonName,style: TextStyle(color: AppColors.colorSelectedItemNavBar,fontSize: 12),),
      ),
    );
  }
}
