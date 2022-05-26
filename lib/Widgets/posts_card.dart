import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matevibes/Widgets/firestore_methods.dart';
import 'package:matevibes/res/app_colors.dart';

import '../screens/member_account_screen.dart';

class PostsCard extends StatefulWidget {
  final snap;
  PostsCard({Key? key, required this.snap}) : super(key: key);

  @override
  _PostsCardState createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // color: AppColors.colorWhite,
      // shape: ShapeBorder.,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 168.8,
          left: MediaQuery.of(context).size.width / 26,
          right: MediaQuery.of(context).size.width / 26,
          bottom: MediaQuery.of(context).size.height / 168.8),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.colorWhite,
            boxShadow: [
              BoxShadow(
                color: AppColors.colorSkipforNow,
                blurRadius: 2,
              )
            ]),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 26,
            vertical: MediaQuery.of(context).size.height / 56.26),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Map<String, dynamic> userMap = Map();
                    userMap = widget.snap.data();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MemberAccountScreen(userData: userMap)));
                  },
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.snap['profImage'].toString()),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 39),
                      child: Text(
                        widget.snap['username'].toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorLetsGetStarted,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Manrope'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 39),
                      child: Text(
                        DateFormat.yMMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.colorTimeOfPost,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Manrope'),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 64.92,
                  bottom: MediaQuery.of(context).size.height / 31.25),
              child: Text(
                widget.snap['description'].toString(),
                softWrap: true,
                maxLines: 10,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colorBlack,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Manrope'),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: AppColors.colorSkipforNow,
                      blurRadius: 15,
                    )
                  ]),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: widget.snap['postUrl'] != null
                      ? Image.network(
                          widget.snap['postUrl'].toString(),
                          fit: BoxFit.cover,
                        )
                      : CircularProgressIndicator()),
            ),
            Container(
              //Divider
              height: 1,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 31.25,
                  bottom: MediaQuery.of(context).size.height / 65.57),
              width: MediaQuery.of(context).size.width / 1.25,
              color: AppColors.colorTimeOfPost,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => FireStoreMethods().likePost(
                            widget.snap['postId'].toString(),
                            FirebaseAuth.instance.currentUser!.uid.toString(),
                            widget.snap['likes']),
                        icon: Icon(Icons.favorite_border_sharp),
                        color: AppColors.colorTimeOfPost,
                        iconSize: 13,
                      ),
                      Container(
                        child: Text(
                          '${widget.snap['likes'].length}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.colorTimeOfPost,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.messenger_outline_sharp),
                          color: AppColors.colorTimeOfPost,
                          iconSize: 13),
                      Container(
                        child: Text(
                          "80",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.colorTimeOfPost,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.star_border_sharp),
                          color: AppColors.colorTimeOfPost,
                          iconSize: 13),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share_sharp),
                          color: AppColors.colorTimeOfPost,
                          iconSize: 13),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
