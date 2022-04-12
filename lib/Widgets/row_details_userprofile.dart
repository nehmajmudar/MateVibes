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
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8.3,right: MediaQuery.of(context).size.width/8.3,bottom: MediaQuery.of(context).size.height/28.13),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/5),
            child: Column(
              children: [
                Text(AppString.txtNoOfPosts,style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colorLetsGetStarted,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
                Text("${widget.noOfPosts}",style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorTimeOfPost,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/5),
            child: Column(
              children: [
                Text(AppString.txtMedia,style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colorLetsGetStarted,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
                Text("${widget.noOfMedia}",style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorTimeOfPost,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/5),
            child: Column(
              children: [
                Text(AppString.txtFollowing,style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colorLetsGetStarted,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
                Text("${widget.noOfFollowing}",style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorTimeOfPost,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Manrope')
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(AppString.txtFollowers,style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorLetsGetStarted,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope')
              ),
              Text("${widget.noOfFollowers}",style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorTimeOfPost,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope')
              ),
            ],
          ),
        ],
      ),
    );
  }
}
