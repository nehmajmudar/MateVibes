import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/firestore_methods.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/chat_screen.dart';
import 'package:matevibes/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenButtons extends StatefulWidget {
  final String uid;
  final String textFirstButton;
  final String textSecondButton;
  final Map<String, dynamic> userDocumentSnapshot;
  const ProfileScreenButtons(
      {Key? key,
      required this.uid,
      required this.textFirstButton,
      required this.textSecondButton,
      required this.userDocumentSnapshot})
      : super(key: key);

  @override
  _ProfileScreenButtonsState createState() => _ProfileScreenButtonsState();
}

class _ProfileScreenButtonsState extends State<ProfileScreenButtons> {

  late SharedPreferences userLogin;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async{
    userLogin=await SharedPreferences.getInstance();
  }

  Future<void> onTapActivity(String buttonName)async{
  Future<void> onTapActivity(String buttonName) async {
    print('sign out working?');
    if (buttonName == AppString.txtSignOut) {
    if(buttonName==AppString.txtSignOut){
      userLogin.setBool('isLoggedIn', false);
      print(userLogin);
      await _auth.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
    }
    if(buttonName==AppString.txtFollow){
      await FireStoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, widget.uid);
    }
    if(buttonName==AppString.txtUnfollow){
      await FireStoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, widget.uid);
    }
    if (buttonName == AppString.txtMessage) {
      Map<String, dynamic> userMap = widget.userDocumentSnapshot;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    peerUserData: userMap,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 12.18,
          right: MediaQuery.of(context).size.width / 12.18,
          bottom: MediaQuery.of(context).size.height / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: ()async=>onTapActivity(widget.textFirstButton),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/2.76,
              height: MediaQuery.of(context).size.height/28.13,
              decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: AppColors.colorBlack)),
              child: Text(
                widget.textFirstButton,
                style: TextStyle(
                    color: AppColors.colorSelectedItemNavBar,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            // onTap: onTapActivity(AppString.txtSignOut),
            onTap: () async =>onTapActivity(widget.textSecondButton),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/2.76,
              height: MediaQuery.of(context).size.height/28.13,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: AppColors.colorBlack)
              ),
              child: Text(widget.textSecondButton,style: TextStyle(color: AppColors.colorSelectedItemNavBar,fontSize: 12,fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }
}
