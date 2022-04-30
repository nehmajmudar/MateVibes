import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/Widgets/notificaction_data.dart';
import 'package:matevibes/res/Methods/check_Internet_button.dart';
import 'package:matevibes/res/app_string.dart';

import '../res/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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

  final List<Widget> items = List.generate(20, (index) => NotificationData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 10.83,
                right: MediaQuery.of(context).size.width / 10.83,
                top: MediaQuery.of(context).size.height / 14.06),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 76.7,
                    ),
                    child: Text(
                      AppString.txtNotifaications,
                      style: TextStyle(
                          color: AppColors.colorNotifacations,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Manrope'),
                    ),
                  ),
                  Container(
                    child: Text(
                      AppString.txtMarkAllAsRead,
                      style: TextStyle(
                          color: AppColors.colorMarkAllAsRead,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Manrope'),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 76.72),
                child: Text(
                  AppString.txtToday,
                  style: TextStyle(
                      color: AppColors.colorToday,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Manrope'),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: double.maxFinite,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        // var item = items[index];
                        return Dismissible(
                          child: NotificationData(),
                          key: UniqueKey(),
                          background: Container(
                            color: AppColors.colorRed,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.delete_forever_outlined),
                              ],
                            ),
                          ),
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            setState(() {
                              items.removeAt(index);
                            });
                          },
                        );
                      }),
                ),
              ),
            ])));
  }
}
