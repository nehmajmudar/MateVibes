import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/screens/chat_screen.dart';
import 'package:matevibes/screens/create_account.dart';
import 'package:matevibes/screens/create_post_screen.dart';
import 'package:matevibes/screens/home_page_screen.dart';
import 'package:matevibes/screens/member_account_screen.dart';
import 'package:matevibes/screens/notification_screen.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  //
  // // var userData={};
  // String profilePicUrl="";
  // final FirebaseAuth _auth=FirebaseAuth.instance;
  // final FirebaseStorage _storage=FirebaseStorage.instance;
  //
  //
  // // Future<String> getProfilePicUrl()async{
  // //   String userId=_auth.currentUser!.uid;
  // //   String getDownloadUrl=await _storage.ref('profilePics/$userId').getDownloadURL();
  // //   return getDownloadUrl;
  // // }
  // void getProfilePic()async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //
  //   setState(() {
  //     profilePicUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
  //   });
  //   print(profilePicUrl);
  // }
  //
  // @override
  // void initState(){
  //   super.initState();
  //   getProfilePic();
  // }


  int selectedIndex=0;
  screenOptions(int index){
    switch(index){
      case 0:
        return HomePageScreen();          ///Home screen
      case 1:
        return NotificationScreen();          ///Notification screen
      case 2:
        return CreatePost();          ///Add post/story screen
      case 3:
        return ChatScreen();          ///Add post/story screen
      case 4:
        return MemberAccountScreen();          ///Profile screen
      default:
        return HomePageScreen();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenOptions(selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          boxShadow: [BoxShadow(color: AppColors.colorTimeOfPost,blurRadius: 10)]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.colorBackgroundColor,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.colorSelectedItemNavBar,
            unselectedItemColor: AppColors.colorTimeOfPost,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.wysiwyg_sharp),label: "___"),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_none_sharp),label:  "___"),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_sharp),label: "___"),
              BottomNavigationBarItem(icon: Icon(Icons.messenger_outline_sharp),label: "___"),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp),label: "___"),
              ],
            currentIndex: selectedIndex,
            onTap: (index){
              setState(() {
                selectedIndex=index;
              });
            },
          ),
        ),
      ),

    );
  }
}
