import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/story_type_selection_dialogue.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/story_screen.dart';

class StoryButtonUser extends StatefulWidget {
  final snap;
  final int index;
  const StoryButtonUser({Key? key,required this.snap,required this.index}) : super(key: key);

  @override
  _StoryButtonUserState createState() => _StoryButtonUserState();
}

class _StoryButtonUserState extends State<StoryButtonUser> {
  String username="";
  String userId="";
  String profImage="";
  bool storyExists=true;
  bool viewedOnce=false;

  void getUserDetails()async{
    var storySnap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      if(widget.index==0){
        userId=storySnap.data()!['uid'];
        username=storySnap.data()!['username'];
        profImage=storySnap.data()!['photoUrl'];
        storyExists=storySnap.data()!['storyIds']!=null?true:false;
      }
      if(widget.index>=2){
        username=widget.snap.data()['username']!=null?widget.snap.data()['username']:"";
        userId=widget.snap.data()['uid'];
        profImage=widget.snap.data()['photoUrl']!=null?widget.snap.data()['photoUrl']:"";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return (storyExists)?Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                viewedOnce=true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoryScreen(userId: userId,index:widget.index,)));
            },
            child: Container(
              width: 67,
              height: 67,
              decoration: (viewedOnce==false)?BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                // border: Border.all(color: colors)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.colorsOfStories))
              :BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.colorWhite)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.colorWhite),
                      image: profImage==""?DecorationImage(
                        image: AssetImage('assets/images/profile_placeholder.jpg'),
                        fit: BoxFit.cover
                      ):DecorationImage(
                          image:NetworkImage(profImage),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(username,style: TextStyle(fontSize: 10,fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400),))
          )
        ],
      ),
    )
    :Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                viewedOnce=true;
                storyExists=true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoryTypeSelectionDialogue()));
            },
            child: Container(
              width: 67,
              height: 67,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.colorWhite)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.colorWhite),
                      image: profImage==""?DecorationImage(
                          image: AssetImage('assets/images/profile_placeholder.jpg'),
                          fit: BoxFit.cover
                      ):DecorationImage(
                          image:NetworkImage(profImage),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(AppString.txtYou,style: TextStyle(fontSize: 10,fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400),))
          )
        ],
      ),
    );
  }
}
