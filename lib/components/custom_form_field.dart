  import 'package:flutter/material.dart';

  typedef Myvalidator = String? Function(String?);

  class CustomFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  bool isPassword ;
  Myvalidator validator;
  TextInputType keyboardType ;
  int lines;
  CustomFormField({
    required this.label,
    required this.validator,
    required this.controller,
    this.isPassword=false,
   this.lines=1,
    this.keyboardType=TextInputType.text} );
    @override
    Widget build(BuildContext context) {
      return TextFormField(
        maxLines: lines,
        minLines: lines,
        validator:  validator,
        controller: controller,
        obscureText:isPassword ,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
        ),
      );
    }
  }
