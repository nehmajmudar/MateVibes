import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';
import 'package:matevibes/res/pick_image.dart';
import 'package:matevibes/screens/create_story_screen.dart';
import 'package:matevibes/screens/create_text_story_screen.dart';

class StoryTypeSelectionDialogue extends StatefulWidget {
  const StoryTypeSelectionDialogue({Key? key}) : super(key: key);

  @override
  _StoryTypeSelectionDialogueState createState() => _StoryTypeSelectionDialogueState();
}

class _StoryTypeSelectionDialogueState extends State<StoryTypeSelectionDialogue> {

  Uint8List? _file;
  selectImage(BuildContext context)async{
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: Text(AppString.txtCreatePost),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text(AppString.takeAPhoto),
            onPressed: ()async{
              Uint8List file=await pickImage(ImageSource.camera);
              setState(() {
                _file=file;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateStoryScreen(imageFile: _file!)));
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text(AppString.txtChooseFromGallery),
            onPressed: ()async{
              Uint8List file=await pickImage(ImageSource.gallery);
              setState(() {
                _file=file;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateStoryScreen(imageFile: _file!)));
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text(AppString.txtCancel),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        height: MediaQuery.of(context).size.height/7.4,
        width: MediaQuery.of(context).size.width/1.25,
        child: Center(
          child: Column(
            children: [
              Text(AppString.txtSelectStoryType,softWrap: true,maxLines: 2,style: TextStyle(color: AppColors.colorLetsGetStarted,fontSize: 18,fontFamily: 'Manrope',fontWeight: FontWeight.w700),),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: ()=>selectImage(context),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.colorSignInButton,
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))),
                        alignment: Alignment.center,
                        child: Text(AppString.txtImage.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColors.colorWhite,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateTextStoryScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.colorSignInButton,
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))),
                        alignment: Alignment.center,
                        child: Text(AppString.txtText.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColors.colorWhite,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
