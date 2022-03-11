import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';

class TextFieldsUi extends StatefulWidget {
  final String textFieldItem;

  const TextFieldsUi({Key? key,required this.textFieldItem}) : super(key: key);

  @override
  _TextFieldsUiState createState() => _TextFieldsUiState();
}

class _TextFieldsUiState extends State<TextFieldsUi> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(13),
          hintText: widget.textFieldItem,
          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.colorHintText,fontFamily: 'Manrope'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
      shadowColor: AppColors.colorHintText,
      elevation: 4,
    );
  }
}
