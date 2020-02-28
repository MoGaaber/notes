import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  TextInputType textInputType;
  TextEditingController textEditingController;
  List<TextInputFormatter> inputFormatters;
  MyTextField(
      {this.textInputType = TextInputType.number,
      @required this.textEditingController,
      this.inputFormatters});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (x) {
        if (x.isEmpty) {
          return '';
        }
      },
      inputFormatters: this.inputFormatters,
      controller: this.textEditingController,
      keyboardType: this.textInputType,
    );
  }
}
