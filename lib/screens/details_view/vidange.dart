import 'package:flutter/material.dart';

class VidangeDetailsView extends StatelessWidget {
  Map<String, dynamic> data;
  VidangeDetailsView({@required this.data});
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
          children: <Widget>[Text('Filtre Ahuile'), Text('Yes'), Text('145')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('Filtre Ahuile'), Text('Yes'), Text('145')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('Filtre Ahuile'), Text('Yes'), Text('145')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('Filtre Ahuile'), Text('Yes'), Text('145')],
        ),
        Text('Note'),
        Text('')
      ],
    );
  }
}
