import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matevibes/Widgets/firestore_methods.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/screens/member_account_screen.dart';

class PostsCard extends StatefulWidget {
  final snap;
  const PostsCard({Key? key,required this.snap}) : super(key: key);

  @override
  _PostsCardState createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> {


  int commentLen=0;
  bool isLikeAnimating=false;


  @override
  Widget build(BuildContext context) {
    print("profile image  >>> ${widget.snap['profImage']}");
    print("post image  >>> ${widget.snap['postUrl']}");

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // color: AppColors.colorWhite,
      // shape: ShapeBorder.,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/26,right: MediaQuery.of(context).size.width/26,bottom: MediaQuery.of(context).size.height/76.72),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.colorWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.colorSkipforNow,
              blurRadius: 15,
            )
          ]
        ),
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width/26,horizontal: MediaQuery.of(context).size.height/56.26),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MemberAccountScreen(uid: widget.snap['uid'])));
                  },
                  child: (widget.snap['profImage'] == "") ? CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_profile_img.png'),
                  ) : CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap['profImage']),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
                      child: Text(widget.snap['username'].toString(),style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorLetsGetStarted,
                          fontWeight: FontWeight.w600,),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
                      child: Text(DateFormat.yMMMMd().format(widget.snap['datePublished'].toDate()),style: TextStyle(
                          fontSize: 11,
                          color: AppColors.colorTimeOfPost,
                          fontWeight: FontWeight.w300,),),
                    )
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/64.92,bottom: MediaQuery.of(context).size.height/31.25),
              child: Text(widget.snap['description'].toString(),softWrap:true,maxLines:10,style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorBlack,
                  fontWeight: FontWeight.w800,),),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.snap['postUrl'].toString()),
                      fit: BoxFit.cover),
                  // image: Image(image: NetworkImage(widget.snap['postUrl'].toString())),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.colorSkipforNow,
                      blurRadius: 15,
                    )
                  ]
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
              ),
            ),
            Container(                                                 //Divider
              height: 1,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/31.25,bottom: MediaQuery.of(context).size.height/65.57),
              width: MediaQuery.of(context).size.width/1.25,
              color: AppColors.colorHintText,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(onPressed: () => FireStoreMethods().likePost(
                          widget.snap['postId'].toString(),
                          FirebaseAuth.instance.currentUser!.uid.toString(),
                          widget.snap['likes']), icon: Icon(Icons.favorite_border_sharp),color: AppColors.colorTimeOfPost,iconSize: 15,),
                      Container(
                        child: Text('${widget.snap['likes'].length}',style: TextStyle(
                          fontSize: 15,
                          color: AppColors.colorTimeOfPost,
                          fontWeight: FontWeight.w300,),),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline_sharp),color: AppColors.colorTimeOfPost,iconSize: 15),
                      Container(
                        child: Text("80",style: TextStyle(
                          fontSize: 15,
                          color: AppColors.colorTimeOfPost,
                          fontWeight: FontWeight.w300,),),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.star_border_sharp),color: AppColors.colorTimeOfPost,iconSize: 15),
                      IconButton(onPressed: (){}, icon: Icon(Icons.share_sharp),color: AppColors.colorTimeOfPost,iconSize: 15),
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
