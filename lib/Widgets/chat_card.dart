import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
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
          height: MediaQuery.of(context).size.height / 14.55,
          alignment: Alignment.center,
          child: ListTile(
            leading: CircleAvatar(
              radius: 18,
              backgroundImage:
                  AssetImage('lib/assets/images/forgot_password_img.png'),
            ),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        "@diana",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.chatName,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Manrope'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          // right: MediaQuery.of(context).size.height / 39.0,
                          top: MediaQuery.of(context).size.height / 84.4),
                      child: Text(
                        "21/2/22",
                        style: TextStyle(
                            fontSize: 8,
                            color: AppColors.colorSearchIconInChat,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Manrope'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 422),
                      child: Text(
                        "Have you read'Think Like A Monk' book?",
                        style: TextStyle(
                            fontSize: 9,
                            color: AppColors.chatName,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Manrope'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    ));
  }
}
