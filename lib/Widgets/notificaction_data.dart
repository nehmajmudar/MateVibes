import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class NotificationData extends StatefulWidget {
  NotificationData({Key? key}) : super(key: key);

  @override
  State<NotificationData> createState() => _NotificationDataState();
}

class _NotificationDataState extends State<NotificationData> {
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
          alignment: Alignment.center,
          child: ListTile(
            leading: CircleAvatar(
              radius: 18,
              backgroundImage:
                  AssetImage('lib/assets/images/forgot_password_img.png'),
            ),
            title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppString.txtDiana,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.colorLetsGetStarted,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Manrope'),
                    ),
                    TextSpan(
                        text: " commented on your post",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.colorLetsGetStarted,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Manrope'),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ],
                ),
              ),
              Text(
                "2 hour ago",
                style: TextStyle(
                    fontSize: 8,
                    color: AppColors.colorHintText,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Manrope'),
              )
      ]),
    ),
        ));
  }
}
