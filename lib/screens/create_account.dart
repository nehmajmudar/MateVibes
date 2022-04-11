import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/user_model.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
                          "Hi " + user.displayName!,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope'),
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
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope'),
                        ),
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 18,
                        ),
                      ),
                      PhysicalModel(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 1,
                        color: Colors.white,
                        child: TextFormField(
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
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 33.76,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 6.9,
                        width: MediaQuery.of(context).size.height / 1.22,
                        child: PhysicalModel(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 1,
                          color: Colors.white,
                          child: TextFormField(
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
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 33.76,
                      ),
                      PhysicalModel(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 1,
                        color: Colors.white,
                        child: TextFormField(
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
                              fontFamily: 'Manrope',
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
                                    AppString.txtSignIn.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.colorWhite,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Manrope'),
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

  Widget buildCoverImage() => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/images/create_account_img.png'),
                fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.3,
      );
  Widget buildProfileImage() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            image: DecorationImage(
                image: AssetImage('lib/assets/images/profile_image.png'),
                fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width / 9.3,
        height: MediaQuery.of(context).size.height / 9.3,
      );
  void showConnectivityToast(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: AppString.txtnoInternetToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.colorRed,
          textColor: AppColors.colorWhite);
      // Got a new connectivity status!
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      Fluttertoast.showToast(
          msg: AppString.txtConnectedinternetToast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.greenColor,
          textColor: AppColors.colorWhite);
    } else {
      print(result.toString());
    }
  }
}
