import 'package:flutter/material.dart';

class FrienageDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' FreinageDetails')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Chip(label: Text('Date')), Text('20/2/2020')],
            ),
            Chip(label: Text('DiscFrien')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Chip(label: Text('km')), Text('20')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Chip(label: Text('Front/Av')),
                    Text('Yes')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Chip(label: Text('Rear/Ar')),
                    Text('No'),
                  ],
                )
              ],
            ),
            Chip(label: Text('Plaquette')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Chip(label: Text('km')), Text('20')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Chip(label: Text('Front/Av')),
                    Text('Yes')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Chip(label: Text('Rear/Ar')),
                    Text('No'),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(label: Text('Note')),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.red)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                        'loremjcjkbjkbc jkbxkjcb kjbxckj bjkxcb kjbxc jkbdssdvsdvsdvsdvdsvsdvdsvdsvsdvsdvsdvsdvvsdvdsvdsdjkxc bkjx ckjkjx cbkjbcjx k'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
