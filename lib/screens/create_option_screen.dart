import 'dart:ui';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/story_type_selection_dialogue.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/create_post_screen.dart';

class CreateOptionScreen extends StatefulWidget {
  const CreateOptionScreen({Key? key}) : super(key: key);

  @override
  _CreateOptionScreenState createState() => _CreateOptionScreenState();
}

class _CreateOptionScreenState extends State<CreateOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.colorBackgroundColor,
      appBar: AppBar(
        title: Text(AppString.txtSharePostOrStory,style: TextStyle(color: AppColors.colorLetsGetStarted,fontSize: 24,fontWeight: FontWeight.w900),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorWhite,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreatePost()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorTimeOfPost
                ),
                alignment: Alignment.center,
                child: Text(AppString.txtPost, style: TextStyle(color: AppColors.colorLetsGetStarted,fontSize: 16,fontWeight: FontWeight.w700)),
              ),
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context)=>StoryTypeSelectionDialogue()
                  );
              },
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorTimeOfPost
                ),
                alignment: Alignment.center,
                child: Text(AppString.txtStory, style: TextStyle(color: AppColors.colorLetsGetStarted,fontSize: 16,fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(20.0),
      //   child: Center(
      //     child: Row(
      //       children: [
      //         GestureDetector(
      //           onTap: (){
      //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreatePost()));
      //           },
      //           child: Container(
      //             height: MediaQuery.of(context).size.height / 18.75,
      //             decoration: BoxDecoration(
      //                 color: AppColors.colorSignInButton,
      //                 borderRadius:
      //                 BorderRadius.all(Radius.circular(5))),
      //             alignment: Alignment.center,
      //             child: Text(
      //               AppString.txtPost.toUpperCase(),
      //               style: TextStyle(
      //                 fontSize: 14,
      //                 color: AppColors.colorWhite,
      //                 fontWeight: FontWeight.w800,),
      //             ),
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: (){
      //             showDialog(
      //               context: context,
      //               builder: (BuildContext context)=>StoryTypeSelectionDialogue()
      //             );
      //           },
      //           child: Container(
      //             height: MediaQuery.of(context).size.height / 18.75,
      //             decoration: BoxDecoration(
      //                 color: AppColors.colorSignInButton,
      //                 borderRadius:
      //                 BorderRadius.all(Radius.circular(5))),
      //             alignment: Alignment.center,
      //             child: Text(
      //               AppString.txtStory.toUpperCase(),
      //               style: TextStyle(
      //                 fontSize: 14,
      //                 color: AppColors.colorWhite,
      //                 fontWeight: FontWeight.w800,),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
