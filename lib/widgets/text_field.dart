import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/logic/globals.dart';
import 'package:provider/provider.dart';

enum TextFieldType { text, number, price }

class MyTextField extends StatelessWidget {
  TextInputType textInputType;
  TextEditingController textEditingController;
  String label;
  TextFieldType textFieldType;
  MyTextField(
      {@required this.textFieldType,
      @required this.label,
      @required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    Globals globals = Provider.of<Globals>(context, listen: false);
    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;

    return Padding(
      padding: textFieldType == TextFieldType.price
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(vertical: globals.screen.convert(15, height)),
      child: SizedBox(
        width: 280 / width * width,
        child: TextFormField(
          style: TextStyle(fontSize: globals.screen.convert(18, aspectRatio)),
          maxLines: this.textFieldType == TextFieldType.text ? null : 1,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          decoration: textFieldType == TextFieldType.price
              ? InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orange, width: 3 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.orange.withOpacity(0.8),
                          width: 2 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(5))))
              : InputDecoration(
                  contentPadding:
                      EdgeInsets.all(20 / aspectRatio * aspectRatio),
                  labelText: this.label,
                  labelStyle: TextStyle(
                    fontSize: globals.screen.convert(16, aspectRatio),
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.w600,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orange, width: 3 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.orange.withOpacity(0.3),
                          width: 2 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
          inputFormatters: textFieldType == TextFieldType.text
              ? null
              : [WhitelistingTextInputFormatter.digitsOnly],
          controller: this.textEditingController,
          keyboardType: textFieldType == TextFieldType.text
              ? TextInputType.text
              : TextInputType.number,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (v) {
            FocusScope.of(context).nextFocus();
          },
        ),
      ),
    );
  }
}
/*


          validator: this.textFieldType == TextFieldType.price || this.label =='Note'
              ? null : (x) {
                  if (x.isEmpty) {
                    return 'Must be not empty .';
                  }
                },

 */
