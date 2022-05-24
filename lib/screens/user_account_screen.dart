import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/posts_card.dart';
import 'package:matevibes/Widgets/profile_overview_widget.dart';
import 'package:matevibes/Widgets/profile_screen_buttons.dart';
import 'package:matevibes/Widgets/row_details_userprofile.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/res/pick_image.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  _UserAccountScreenState createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsSelected){
          return <Widget>[
            SliverAppBar(
              backgroundColor: AppColors.colorWhite,
              expandedHeight: MediaQuery.of(context).size.height*0.575,
              flexibleSpace: FlexibleSpaceBar(
                background: ProfileOverviewWidget(),
              )
            )
          ];
        },
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!=null?snapshot.data!.docs.length:0,
                itemBuilder:(ctx,index)=>Container(
                  // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3.33,vertical: 15),
                  child: PostsCard(snap: snapshot.data!.docs[index].data()),
                ),
              );
            }),
      ),
    );
  }
}
