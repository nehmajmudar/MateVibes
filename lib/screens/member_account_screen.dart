import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/posts_card.dart';
import 'package:matevibes/Widgets/row_details_userprofile.dart';
import 'package:matevibes/Widgets/user_profile_button.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/create_account.dart';

class MemberAccountScreen extends StatefulWidget {
  const MemberAccountScreen({Key? key}) : super(key: key);

  @override
  _MemberAccountScreenState createState() => _MemberAccountScreenState();
}

class _MemberAccountScreenState extends State<MemberAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/4.22,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/16.23),
            ),
            Center(
              child: Text(AppString.txtUsername,style: TextStyle(
                  fontSize: 20,
                  color: AppColors.colorLetsGetStarted,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope')
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5,right: MediaQuery.of(context).size.width/19.5),
                margin: EdgeInsets.only(top: 5,bottom: 5),
                child: Text(AppString.txtDisplayName,style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorToday,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5,right: MediaQuery.of(context).size.width/19.5),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/33.76),
                child: Text(AppString.txtLoremIpsum,softWrap: true,maxLines: 10,style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorToday,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
              ),
            ),
            RowOfUserProfile(noOfPosts: 100, noOfMedia: 100, noOfFollowing: 100, noOfFollowers: 100),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8.86,right: MediaQuery.of(context).size.width/8.86,bottom: MediaQuery.of(context).size.height/50),
              child: Row(
                children: [
                  UserProfileButton(userButtonName: AppString.txtEditProfile),
                  SizedBox(width: MediaQuery.of(context).size.width/19.5),
                  UserProfileButton(userButtonName: AppString.txtSignOut),
                ],
              ),
            ),
            PostsCard()
          ],
        ),
      ),
    );
  }
}
