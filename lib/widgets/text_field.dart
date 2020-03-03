import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  TextInputType textInputType;
  TextEditingController textEditingController;
  List<TextInputFormatter> inputFormatters;
  String label;
  bool isRequired;
  MyTextField(
      {this.textInputType = TextInputType.number,
      @required this.textEditingController,
      this.inputFormatters,
      this.isRequired = true,
      this.label = ''});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextFormField(
        maxLines: this.textInputType == TextInputType.text ? null : 1,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          contentPadding: EdgeInsets.all(20),
          labelText: this.label,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        validator: isRequired
            ? (x) {
                if (x.isEmpty) {
                  return 'This filled must be not empty';
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
