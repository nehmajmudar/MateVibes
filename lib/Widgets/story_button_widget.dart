import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/storydata.dart';
import 'package:matevibes/pages/story_page.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/screens/story_screen.dart';

Widget storyButton(BuildContext context, QueryDocumentSnapshot<Map<String, dynamic>> snap,) {
  String username=snap.data()['username']!=null?snap.data()['username']:"";
  String userId=snap.data()['uid'];
  String profImage=snap.data()['photoUrl']!=null?snap.data()['photoUrl']:"";
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoryScreen(userId: userId,)));
          },
          child: Container(
            width: 67,
            height: 67,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.colorsOfStories)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.colorWhite),
                    image: DecorationImage(
                        image:
                            NetworkImage(profImage),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(username,style: TextStyle(fontSize: 10,fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400),)),
        )
      ],
    ),
  );
}
