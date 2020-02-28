import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  MyText({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
