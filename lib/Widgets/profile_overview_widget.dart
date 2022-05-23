import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/profile_screen_buttons.dart';
import 'package:matevibes/Widgets/row_details_userprofile.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/res/pick_image.dart';

class ProfileOverviewWidget extends StatefulWidget {
  const ProfileOverviewWidget({Key? key}) : super(key: key);

  @override
  _ProfileOverviewWidgetState createState() => _ProfileOverviewWidgetState();
}

class _ProfileOverviewWidgetState extends State<ProfileOverviewWidget> {
  String username="";
  String uid="";
  String displayName="";
  String bio="";
  String coverPhoto="";
  String profilePhoto="";
  int userFollowers=0;
  int userFollowing=0;
  int postLen=0;
  bool isFollowing=false;

  ScrollController scrollController=ScrollController();

  void getUserDetails()async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        username=snap.data()!['username'];
        uid=snap.data()!['uid'];
        displayName = snap.data()!['displayName'];
        bio = snap.data()!['bio'];
        coverPhoto = snap.data()!['coverPhotoUrl'];
        profilePhoto = snap.data()!['photoUrl'];
        userFollowers = snap.data()!['followers']!=null?snap.data()!['followers'].length:0;
        userFollowing = snap.data()!['following']!=null?snap.data()!['following'].length:0;
        isFollowing = snap.data()!['followers']!=null?snap.data()!['followers'].contains(
            FirebaseAuth.instance.currentUser!.uid):false;
        postLen = postSnap.docs.length;
      });
    }catch(e){
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void initState(){
    super.initState();
    getUserDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/0.2,
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
              child: Text(username,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.colorLetsGetStarted,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w800
                  )),
            ),
            Center(
              child: Container(
                // padding: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.width / 19.5,
                //     right: MediaQuery.of(context).size.width / 19.5),
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: Text("@$displayName",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.colorToday,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Center(
              child: Container(
                // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5,right: MediaQuery.of(context).size.width/19.5),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/33.76),
                child: Text(bio,softWrap: true,maxLines: 10,style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorToday,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400)
                ),
              ),
            ),
            RowOfUserProfile(noOfPosts: postLen, noOfMedia: postLen, noOfFollowing: userFollowing, noOfFollowers: userFollowers),
            ProfileScreenButtons(uid: FirebaseAuth.instance.currentUser!.uid,textFirstButton: AppString.txtEditProfile,textSecondButton: AppString.txtSignOut, userDocumentSnapshot: {},),
          ],
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

}
