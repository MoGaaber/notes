import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  TextInputType textInputType;
  TextEditingController textEditingController;
  List<TextInputFormatter> inputFormatters;
  bool isRequired;
  MyTextField(
      {this.textInputType = TextInputType.number,
      @required this.textEditingController,
      this.inputFormatters,
      this.isRequired = true});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: isRequired
          ? (x) {
              if (x.isEmpty) {
                return '';
              }
            }
          : null,
      inputFormatters: this.inputFormatters,
      controller: this.textEditingController,
      keyboardType: this.textInputType,
    );
  }
}
