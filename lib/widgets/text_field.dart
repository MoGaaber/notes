import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/logic/globals.dart';
import 'package:provider/provider.dart';

enum TextFieldType { text, number, price }

class MyTextField extends StatelessWidget {
  TextInputType textInputType;
  TextEditingController textEditingController;
  String label;
  Map<String, dynamic> fields;
  TextFieldType textFieldType;
  MyTextField(
      {@required this.fields,
      @required this.textFieldType,
      @required this.label,
      @required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    Globals globals = Provider.of<Globals>(context, listen: false);
    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: globals.screen.convert(10, height)),
      child: SizedBox(
        width: 280 / width * width,
        child: TextFormField(
          maxLines: this.textFieldType == TextFieldType.text ? null : 1,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          decoration: textFieldType == TextFieldType.price
              ? InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orange, width: 2 / width * width)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orange, width: 2 / width * width)))
              : InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red, width: 2 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding:
                      EdgeInsets.all(20 / aspectRatio * aspectRatio),
                  labelText: this.label,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orange, width: 2 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orange, width: 2 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
          validator: this.textFieldType != TextFieldType.price
              ? (x) {
                  if (x.isEmpty) {
                    return 'Must be not empty .';
                  }
                }
              : null,
          inputFormatters: textFieldType == TextFieldType.number
              ? [WhitelistingTextInputFormatter.digitsOnly]
              : null,
          controller: this.textEditingController,
          keyboardType: textFieldType == TextFieldType.number
              ? TextInputType.number
              : TextInputType.text,
        ),
      ),
    );
  }
}
