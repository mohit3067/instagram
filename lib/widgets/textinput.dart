import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputFeild extends StatelessWidget {

final TextEditingController textEditingController;
bool ispass;
 final String hinttext; 
final TextInputType textInputType;

TextInputFeild({required this.textEditingController,required this.hinttext,required this.textInputType,this.ispass=false});

  @override
  Widget build(BuildContext context) {

final inputborder= OutlineInputBorder(
          borderSide: Divider.createBorderSide(context)
        );

    return TextField(
      controller: textEditingController, 
      decoration: InputDecoration(
        hintText: hinttext,
        border: inputborder,
        focusedBorder: inputborder,
        enabledBorder: inputborder,
        filled: true,
        contentPadding: EdgeInsets.all(10),
        ),
        keyboardType: textInputType,
        obscureText: ispass,
      );
  }
}