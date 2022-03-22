import 'package:flutter/material.dart';
import 'package:matevibes/Widgets/chat_card.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 10.83,
                right: MediaQuery.of(context).size.width / 10.83),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 14.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 76.7,
                        ),
                        child: Text(
                          AppString.txtChat,
                          style: TextStyle(
                              color: AppColors.colorNotifacations,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Manrope'),
                        ),
                      ),
                      SizedBox(
                        // height: MediaQuery.of(context).size.height / 28.13,
                        width: MediaQuery.of(context).size.width / 28.13,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: new Icon(Icons.record_voice_over),
                          iconSize: MediaQuery.of(context).size.height / 54.4,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 23.44,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 7.09),
                  child: PhysicalModel(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 1,
                    color: Colors.white,
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.search_outlined),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height / 23.44),
                        hintText: AppString.txtSearch,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorHintText,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5.08),
                  child: Expanded(
                    child: SizedBox(
                      height: double.maxFinite,
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return ChatCard();
                          }),
                    ),
                  ),
                ),
              ],
            )));
  }
}
