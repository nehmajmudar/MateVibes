import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/res/pick_image.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  TextEditingController commentController=TextEditingController();
  String username="";
  String uid="";
  String displayName="";
  String profilePhoto="";

  void getUserDetails()async{
    try{
      var snap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      setState(() {
        username=snap.data()!['username'];
        uid=snap.data()!['uid'];
        displayName=snap.data()!['displayName'];
        profilePhoto=snap.data()!['profilePhoto'];
      });
    }
    catch(e){
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      appBar: AppBar(
        title: Text(AppString.txtComments,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: AppColors.colorLetsGetStarted),),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: AppColors.colorWhite,
          height: kToolbarHeight,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(left: 10,right: 5),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePhoto),
                radius: 19,
              ),
              TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppString.txtAddAComment,
                  hintStyle: TextStyle(
                    color: AppColors.colorHintText,
                    fontSize: 12
                  )
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.comment))
            ],
          ),
        )
      ),
    );
  }
}
