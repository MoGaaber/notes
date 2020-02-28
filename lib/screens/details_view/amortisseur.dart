import 'package:flutter/material.dart';

class AmortisseurDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('Date'), Text('20/2/2020')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('km'), Text('20')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[Text('Front/Av'), Text('Yes')],
            ),
            Column(
              children: <Widget>[
                Text('Rear/Ar'),
                Text('No'),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('Note'), Text('hello')],
        ),
      ],
    );
  }
}
