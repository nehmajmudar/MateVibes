import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class PostsCard extends StatefulWidget {
  const PostsCard({Key? key}) : super(key: key);

  @override
  _PostsCardState createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      color: AppColors.colorWhite,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/26,right: MediaQuery.of(context).size.width/26,bottom: MediaQuery.of(context).size.height/76.72),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width/26,horizontal: MediaQuery.of(context).size.height/56.26),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/images/user_profile_img.png'),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
                      child: Text(AppString.txtUsername,style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorLetsGetStarted,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Manrope'),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
                      child: Text(AppString.txtTimeExample,style: TextStyle(
                          fontSize: 11,
                          color: AppColors.colorTimeOfPost,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Manrope'),),
                    )
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/64.92,bottom: MediaQuery.of(context).size.height/31.25),
              child: Text(AppString.txtLoremIpsum,softWrap:true,maxLines:10,style: TextStyle(
                  fontSize: 11,
                  color: AppColors.colorBlack,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope'),),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/65.57),
              width: MediaQuery.of(context).size.width/1.25,
              color: AppColors.colorHintText,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_sharp),color: AppColors.colorTimeOfPost,iconSize: 12,),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/65.32,right: MediaQuery.of(context).size.width/17.83),
                  child: Text("1.2k",style: TextStyle(
                          fontSize: 12,
                          color: AppColors.colorTimeOfPost,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Manrope'),),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline_sharp),color: AppColors.colorTimeOfPost,iconSize: 12),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/65.32,right: MediaQuery.of(context).size.width/4.875),
                  child: Text("80",style: TextStyle(
                      fontSize: 12,
                      color: AppColors.colorTimeOfPost,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Manrope'),),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.star_border_sharp),color: AppColors.colorTimeOfPost,iconSize: 12),
                IconButton(onPressed: (){}, icon: Icon(Icons.share_sharp),color: AppColors.colorTimeOfPost,iconSize: 12),
              ],
            )
          ],
        ),
      ),
    );
  }
}
