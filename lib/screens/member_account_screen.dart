import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:matevibes/Widgets/posts_card.dart';
import 'package:matevibes/Widgets/profile_screen_buttons.dart';
import 'package:matevibes/Widgets/row_details_userprofile.dart';
import 'package:matevibes/Widgets/user_profile_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';


class MemberAccountScreen extends StatefulWidget {
  const MemberAccountScreen({Key? key}) : super(key: key);

  @override
  _MemberAccountScreenState createState() => _MemberAccountScreenState();
}

class _MemberAccountScreenState extends State<MemberAccountScreen> {
  String username="";
  String displayName="";
  String bio="";
  String coverPhoto="";
  String profilePhoto="";


  void getUserDetails()async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      displayName = (snap.data() as Map<String, dynamic>)['displayName'];
      bio = (snap.data() as Map<String, dynamic>)['bio'];
      coverPhoto = (snap.data() as Map<String, dynamic>)['coverPhotoUrl'];
      profilePhoto = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  @override
  void initState(){
    super.initState();
    getUserDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                coverProfileImage(),
                Positioned(
                  child: profileImage(),
                  top: MediaQuery.of(context).size.height/6.0,
                  right: MediaQuery.of(context).size.width/2.5,
                  left: MediaQuery.of(context).size.width/2.5,
                )
              ],
            ),
            Center(
              child: Text(username,style: TextStyle(
                  fontSize: 20,
                  color: AppColors.colorLetsGetStarted,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Manrope')
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5,right: MediaQuery.of(context).size.width/19.5),
                margin: EdgeInsets.only(top: 5,bottom: 5),
                child: Text("@$displayName",style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorToday,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Manrope')
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5,right: MediaQuery.of(context).size.width/19.5),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/33.76),
                child: Text(bio,softWrap: true,maxLines: 10,style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorToday,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Manrope')
                ),
              ),
            ),
            RowOfUserProfile(noOfPosts: 100, noOfMedia: 100, noOfFollowing: 100, noOfFollowers: 100),
            ProfileScreenButtons(),
            PostsCard()
          ],
        ),
      ),
    );
  }

  Widget coverProfileImage()=>
    Container(
      height: MediaQuery.of(context).size.height/4.22,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/16.23),
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(coverPhoto),fit: BoxFit.cover),
      ),
    );

  Widget profileImage()=>
    Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: AppColors.colorWhite,blurRadius: 2,spreadRadius: 2)
        ]
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(profilePhoto),
      ),
    );

    // Container(
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     borderRadius: BorderRadius.all(Radius.circular(50.0)),
    //     color: AppColors.colorBlack38,
    //     image: DecorationImage(
    //       image: NetworkImage(profilePhoto),
    //       fit: BoxFit.cover)
    //     ),
    //   // width: MediaQuery.of(context).size.height / 8.44,
    //   // height: MediaQuery.of(context).size.height / 8.44,
    // );
}
