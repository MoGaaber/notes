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
  Map<String, dynamic> fields;
  TextFieldType textFieldType;
  VoidCallback onTab;
  MyTextField(
      {@required this.fields,
      @required this.textFieldType,
      @required this.label,
      this.onTab,
      @required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    Globals globals = Provider.of<Globals>(context, listen: false);
    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: globals.screen.convert(10, height)),
      child: SizedBox(
        width: 280 / width * width,
        child: TextFormField(
          onTap: this.onTab,
          style: TextStyle(fontSize: 14),
          maxLines: this.textFieldType == TextFieldType.text ? null : 1,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          decoration: textFieldType == TextFieldType.price
              ? InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orange, width: 3 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.orange.withOpacity(0.8),
                          width: 2 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(10))))
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
                          color: Colors.orange, width: 3 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.orange.withOpacity(0.8),
                          width: 2 / width * width),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
          inputFormatters: textFieldType == TextFieldType.text
              ? null
              : [WhitelistingTextInputFormatter.digitsOnly],
          controller: this.textEditingController,
          keyboardType: textFieldType == TextFieldType.text
              ? TextInputType.text
              : TextInputType.number,
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
