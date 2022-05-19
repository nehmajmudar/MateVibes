import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/firestore_methods.dart';
import 'package:matevibes/models/story_model.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/res/pick_image.dart';

class CreateStoryScreen extends StatefulWidget {
  final Uint8List imageFile;
  const CreateStoryScreen({Key? key,required this.imageFile}) : super(key: key);

  @override
  _CreateStoryScreenState createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {

  TextEditingController storyCaptionController=TextEditingController();
  String uid="";

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId()async{
    DocumentSnapshot snap= await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      uid=(snap.data() as Map<String, dynamic>)['uid'];
    });
  }

  void shareStory(
      String uid
      )async{
    try{
      String res=await FireStoreMethods().uploadStory(uid: uid,file: widget.imageFile,storyCaption: storyCaptionController.text);
      if(res==AppString.txtSuccess){
        showSnackBar('Posted!', context);
      }
      else{
        showSnackBar(res, context);
      }
    }catch(e){
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    storyCaptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/6.25,
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15.6,top: MediaQuery.of(context).size.height/12.05),
              color: AppColors.colorWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      AppString.txtWhatIsInYourMind,
                      style: TextStyle(
                          color: AppColors.colorForgotPassword,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,),
                    ),
                    margin: EdgeInsets.only(bottom: 5),
                  ),
                  Text(
                    AppString.txtCreateStory,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15.6,right: MediaQuery.of(context).size.width/15.6,top: MediaQuery.of(context).size.height/13),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/4.41,
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 13),
                    decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.colorSkipforNow,
                            blurRadius: 15,
                          )
                        ]
                    ),
                    child: TextFormField(
                      controller: storyCaptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        hintText: AppString.txtWriteSomethingHere,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/11.1),
                      height: MediaQuery.of(context).size.height/12.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width/5.56,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: MemoryImage(widget.imageFile),
                                      alignment: FractionalOffset.topCenter
                                  )
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              AppString.txtAddPhotos,
                              style: TextStyle(
                                  color: AppColors.colorForgotPassword,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,),
                            ),
                          ),
                        ],
                      )
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: ()=>shareStory("${uid}"),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.68,
                        height: MediaQuery.of(context).size.height / 18.75,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 9.27,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.colorSignInButton,
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                        alignment: Alignment.center,
                        child: Text(
                          AppString.txtShare.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.w800,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
