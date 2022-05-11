import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matevibes/Widgets/firestore_methods.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

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
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['profImage'].toString()),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
                      child: Text(widget.snap['username'].toString(),style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorLetsGetStarted,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Manrope'),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/19.5),
                      child: Text(DateFormat.yMMMMd().format(widget.snap['datePublished'].toDate()),style: TextStyle(
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
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/64.92,bottom: MediaQuery.of(context).size.height/31.25),
              child: Text(widget.snap['description'].toString(),softWrap:true,maxLines:10,style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorBlack,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope'),),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.colorSkipforNow,
                      blurRadius: 15,
                    )
                  ]
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap['postUrl'].toString(),
                  fit: BoxFit.cover,)
              ),
            ),
            Container(                                                 //Divider
              height: 1,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/31.25,bottom: MediaQuery.of(context).size.height/65.57),
              width: MediaQuery.of(context).size.width/1.25,
              color: AppColors.colorHintText,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () => FireStoreMethods().likePost(
                    widget.snap['postId'].toString(),
                    FirebaseAuth.instance.currentUser!.uid.toString(),
                    widget.snap['likes']), icon: Icon(Icons.favorite_border_sharp),color: AppColors.colorTimeOfPost,iconSize: 12,),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/65.32,right: MediaQuery.of(context).size.width/17.83),
                  child: Text('${widget.snap['likes'].length} likes',style: TextStyle(
                          fontSize: 12,
                          color: AppColors.colorTimeOfPost,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Manrope'),),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline_sharp),color: AppColors.colorTimeOfPost,iconSize: 12),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/65.32,right: MediaQuery.of(context).size.width/6.5),
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
