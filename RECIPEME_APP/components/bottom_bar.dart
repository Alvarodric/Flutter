import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipeme2/screens/ListContainers.dart';
import 'package:recipeme2/components/Database.dart';
import 'constants.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:recipeme2/screens/CreateRecipe.dart';
import 'package:recipeme2/screens/info.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ListContainers(),
    CreateRecipe(),
    Info(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('RECIPEME')),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {

              print('hola');
              // do something
            },
          )
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.pink[200],
        onTap: onTabTapped, // new
        height: 50.0,
        items: [
          //TabItem(icon: Icons.home, title: 'Home'),
          //TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.filter, title: 'All'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.info, title: 'Info'),

        ],
      ),
      //resizeToAvoidBottomPadding: false,
      body: _children[_currentIndex],

    );

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}