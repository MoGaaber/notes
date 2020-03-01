import 'package:flutter/material.dart';

class VidangeDetailsView extends StatelessWidget {
  Map<String, dynamic> data;
  VidangeDetailsView({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vindage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Chip(label: Text('Date')),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(label: Text('Filtre Ahuile')),
                Text('Yes'),
                Chip(label: Text('Price')),
                Text('145')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(label: Text('Filtre Ahuile')),
                Text('Yes'),
                Chip(label: Text('Price')),
                Text('145')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(label: Text('Filtre Ahuile')),
                Text('Yes'),
                Chip(label: Text('Price')),
                Text('145')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(label: Text('Filtre Ahuile')),
                Text('Yes'),
                Chip(label: Text('Price')),
                Text('145')
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
      ),
    );
  }
}
