import 'package:flutter/material.dart';

class BatterieDetailsView extends StatelessWidget {
  Map<String, dynamic> data;
  BatterieDetailsView({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Text('Date'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('Date'), Text('20/2/2020')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('km'), Text('20')],
        ),
        Text('Note'),
        Text('')
      ],
    );
  }
}
