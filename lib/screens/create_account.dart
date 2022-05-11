import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matevibes/Widgets/bottom_navbar.dart';
import 'package:matevibes/Widgets/firestore_methods.dart';
import 'package:matevibes/res/Methods/check_Internet_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/models/user_model.dart';
import 'package:matevibes/res/pick_image.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username="";
  String phoneNum="";
  Uint8List? userCoverImage;
  Uint8List? userProfileImage;
  TextEditingController displayNameController=TextEditingController();
  TextEditingController userBioController=TextEditingController();
  TextEditingController userGenderController=TextEditingController();

  @override
  void initState(){
    super.initState();
    getUsername();
    getPhoneNumber();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
  }

  void getUsername()async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }
  late StreamSubscription subscription;

  void getPhoneNumber()async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      phoneNum = (snap.data() as Map<String, dynamic>)['phoneNumber'];
    });
  }

  void insertUserDetails()async{
    String res=await FireStoreMethods().insertMoreUserDetails(
      displayName: displayNameController.text,
      userName: username,
      phoneNumber: phoneNum,
      userBio: userBioController.text,
      userGender: userGenderController.text,
      coverImage: userCoverImage!,
      profileImage: userProfileImage!,
    );
    if(res==AppString.txtSuccess){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
    }
    else{
      showSnackBar(res, context);
    }
  }


  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
    displayNameController.dispose();
    userBioController.dispose();
    userGenderController.dispose();
  }

  selectCoverImage()async{
    Uint8List coverImg=await pickImage(ImageSource.gallery);
    setState(() {
      userCoverImage=coverImg;
    });
  }

  selectProfileImage()async{
    Uint8List profileImg=await pickImage(ImageSource.gallery);
    setState(() {
      userProfileImage=profileImg;
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Form(
        child: Scaffold(
            backgroundColor: AppColors.colorBackgroundColor,
            body: SingleChildScrollView(
              child: Stack(clipBehavior: Clip.none, children: [
                buildCoverImage(),
                Positioned(
                    top: MediaQuery.of(context).size.height / 5.6,
                    left: MediaQuery.of(context).size.width / 11.81,
                    right: MediaQuery.of(context).size.width / 1.4,
                    child: buildProfileImage()),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 12,
                      right: MediaQuery.of(context).size.width / 10,
                      top: MediaQuery.of(context).size.height / 3.29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Hi $username",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,),
                        ),
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 168),
                      ),
                      Container(
                        child: Text(
                          AppString.txtLetsCompleteProfile,
                          style: TextStyle(
                              color: AppColors.colorSignInToContinue,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,),
                        ),
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 18,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 33.76),
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.colorSkipforNow,
                                blurRadius: 25,
                              )
                            ]
                        ),
                        child: TextFormField(
                          controller: displayNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(13),
                            hintText: AppString.txtDisplayName,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorHintText,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 6.9,
                        width: MediaQuery.of(context).size.height / 1.22,
                        decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.colorSkipforNow,
                              blurRadius: 25,
                            )
                          ]
                        ),
                        child: TextFormField(
                          controller: userBioController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(13),
                            hintText: AppString.txtWhatDescribesYouBetter,
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
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 33.76),
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.colorSkipforNow,
                                blurRadius: 25,
                              )
                            ]
                        ),
                        child: TextFormField(
                          controller: userGenderController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(13),
                            hintText: AppString.txtGender,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorHintText,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 6.54,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final result =
                                      await Connectivity().checkConnectivity();
                                  showConnectivityToastOnPress(result);
                                  insertUserDetails();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.68,
                                  height: MediaQuery.of(context).size.height /
                                      18.75,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorSignInButton,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppString.txtContinue.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.colorWhite,
                                        fontWeight: FontWeight.w700,),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height /
                                      49.64,
                                  bottom: MediaQuery.of(context).size.height /
                                      23.44,
                                ),
                                child: Text(
                                  AppString.txtSkipForNow,
                                  style: TextStyle(
                                      color: AppColors.colorSignInToContinue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Manrope'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }

  Widget buildCoverImage() => GestureDetector(
    onTap: selectCoverImage,
    child: userCoverImage!=null
      ?Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(userCoverImage!),
                  fit: BoxFit.cover)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4.3,
        )
    :Container(
      child: Icon(Icons.photo,color: AppColors.colorIcon,size: 70,),
      alignment: Alignment.center,
      decoration: BoxDecoration(
            color: AppColors.colorBgIconOfCreateProfile,),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4.3,
        ),
  );

  Widget buildProfileImage() => GestureDetector(
    onTap: selectProfileImage,
    child: userProfileImage!=null
      ?Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
              image: MemoryImage(userProfileImage!),
              fit: BoxFit.cover)),
      width: MediaQuery.of(context).size.width / 9.3,
      height: MediaQuery.of(context).size.height / 9.3,
    )
          :Container(
          child: Icon(Icons.account_circle_outlined,color: AppColors.colorIcon,size: 50,),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.colorBgIconOfCreateProfile,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
          width: MediaQuery.of(context).size.width / 9.3,
          height: MediaQuery.of(context).size.height / 9.3,
        ),
  );
}