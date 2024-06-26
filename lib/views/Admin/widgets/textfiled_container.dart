
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextfieldContainer extends StatelessWidget {
   TextfieldContainer({
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    super.key,
  });
TextEditingController controller = TextEditingController();
String hintText;
TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: 350,
      height: 60,
      child: TextField(controller: controller,keyboardType:keyboardType,
        decoration: InputDecoration(hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).primaryColor,
            
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
      ),
    );
  }
}