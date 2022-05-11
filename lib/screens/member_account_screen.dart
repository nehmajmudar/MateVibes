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
import 'package:matevibes/res/pick_image.dart';


class MemberAccountScreen extends StatefulWidget {
  final String uid;
  const MemberAccountScreen({Key? key,required this.uid}) : super(key: key);

  @override
  _MemberAccountScreenState createState() => _MemberAccountScreenState();
}

class _MemberAccountScreenState extends State<MemberAccountScreen> {
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

  void getUserDetails()async {
    try {
      var snap = await FirebaseFirestore.instance.collection('users')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance.collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        username = snap.data()!['username'];
        uid = snap.data()!['uid'];
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
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: Column(
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
                fontWeight: FontWeight.w900,)
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5,right: MediaQuery.of(context).size.width/19.5),
              margin: EdgeInsets.only(top: 5,bottom: 5),
              child: Text("@$displayName",style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorToday,
                  fontWeight: FontWeight.w900,)
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
                  fontWeight: FontWeight.w900,)
              ),
            ),
          ),
          RowOfUserProfile(noOfPosts: postLen, noOfMedia: postLen, noOfFollowing: userFollowing, noOfFollowers: userFollowers),
          isFollowing?ProfileScreenButtons(uid: widget.uid,textFirstButton: AppString.txtUnfollow,textSecondButton: AppString.txtMessage)
              :ProfileScreenButtons(uid: widget.uid,textFirstButton: AppString.txtFollow,textSecondButton: AppString.txtMessage),
          Expanded(
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: widget.uid).get(),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder:(ctx,index)=>Container(
                      // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3.33,vertical: 15),
                      child: PostsCard(snap: (snapshot.data! as dynamic).docs[index].data()),
                    ),
                  );
                }
            ),
          ),
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
