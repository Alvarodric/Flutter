import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                  'Recipeme is an app aimed to not forget never the master recipes you are making,so having them always with you.Also giving you the idea for those days when you really dont know what to cook'),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
