import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  TextInputType textInputType;
  TextEditingController textEditingController;
  List<TextInputFormatter> inputFormatters;
  String label;
  bool isRequired;
  int isLong;
  MyTextField(
      {this.textInputType = TextInputType.number,
      @required this.textEditingController,
      this.inputFormatters,
      this.isLong = 1,
      this.isRequired = true,
      this.label = ''});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        maxLines: this.isLong,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          labelText: this.label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
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
      ),
    );
  }
}
