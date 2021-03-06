import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class RowOfUserProfile extends StatefulWidget {
  final int noOfPosts;
  final int noOfMedia;
  final int noOfFollowing;
  final int noOfFollowers;
  const RowOfUserProfile({Key? key,required this.noOfPosts,required this.noOfMedia,required this.noOfFollowing,required this.noOfFollowers,}) : super(key: key);

  @override
  _RowOfUserProfileState createState() => _RowOfUserProfileState();
}

class _RowOfUserProfileState extends State<RowOfUserProfile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/12.18,right: MediaQuery.of(context).size.width/12.18,bottom: MediaQuery.of(context).size.height/28.13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text("${widget.noOfPosts}",style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorLetsGetStarted,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800)
              ),
              Text(AppString.txtPosts,style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorTimeOfPost,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800)
              ),
            ],
          ),
          Column(
            children: [
              Text("${widget.noOfMedia}",style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorLetsGetStarted,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800)
              ),
              Text(AppString.txtMedia,style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorTimeOfPost,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800)
              ),
            ],
          ),
          Column(
            children: [
              Text("${widget.noOfFollowing}",style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorLetsGetStarted,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800)
              ),
              Text(AppString.txtFollowing,style: TextStyle(
                fontSize: 12,
                color: AppColors.colorTimeOfPost,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800,)
              ),
            ],
          ),
          Column(
            children: [
              Text("${widget.noOfFollowers}",style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorLetsGetStarted,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800)
              ),
              Text(AppString.txtFollowers,style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorTimeOfPost,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w800)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
