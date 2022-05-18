import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matevibes/Widgets/firestore_methods.dart';
import 'package:matevibes/Widgets/storage_methods.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/res/pick_image.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Uint8List? _file;
  String _photoUrl="";
  String username="";
  String uid="";
  final TextEditingController postCaptionController=TextEditingController();

  @override
  void initState(){
    super.initState();
    getUserphoto();
    getUsername();
    getUserid();
  }


  void getUsername()async{
    DocumentSnapshot snap= await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      username=(snap.data() as Map<String, dynamic>)['username'];
    });
  }

  void getUserid()async{
    DocumentSnapshot snap= await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      uid=(snap.data() as Map<String, dynamic>)['uid'];
    });
  }

  void getUserphoto()async{
    DocumentSnapshot snap= await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      _photoUrl=(snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  void sharePost(
      String uid,
      String username,
      String profImage
      )async{
    try{
      String res=await FireStoreMethods().uploadPost(postCaptionController.text, _file!, uid, username, profImage);
      if(res==AppString.txtSuccess){
        showSnackBar('Posted!', context);
        clearImage();
      }
      else{
        showSnackBar(res, context);
      }
    }catch(e){
      showSnackBar(e.toString(), context);
    }
  }

  selectImage(BuildContext context)async{
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: Text(AppString.txtCreatePost),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text(AppString.takeAPhoto),
            onPressed: ()async{
              Navigator.of(context).pop();
              Uint8List file=await pickImage(ImageSource.camera);
              setState(() {
                _file=file;
              });
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text(AppString.txtChooseFromGallery),
            onPressed: ()async{
              Navigator.of(context).pop();
              Uint8List file=await pickImage(ImageSource.gallery);
              setState(() {
                _file=file;
              });
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text(AppString.txtCancel),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  void clearImage(){
    setState(() {
      _file=null;
    });
  }

  @override
  void dispose() {
    postCaptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _file==null?
        Scaffold(
          body: Center(
            child: IconButton(onPressed: ()=>selectImage(context), icon: Icon(Icons.upload_sharp)),
          ),
        )
    :Scaffold(
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
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Manrope'),
                    ),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 5),
                  ),
                  Text(
                    AppString.txtCreatePost,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Manrope'),
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
                      controller: postCaptionController,
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
                                image: MemoryImage(_file!),
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
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Manrope'),
                          ),
                        ),
                      ],
                    )
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: ()=>sharePost("${uid}","${username}","${_photoUrl}"),
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
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope'),
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
