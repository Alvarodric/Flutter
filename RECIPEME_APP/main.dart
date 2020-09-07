import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:recipeme2/screens/CreateRecipe.dart';
import 'package:recipeme2/screens/ListContainers.dart';
import 'components/bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: BottomBar(),
        routes: {

    '/first': (context) => BottomBar(),
    }
    );
  }
}
        //routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
//          '/first': (context) => CreateRecipe(),
//          '/second': (context) => ScreenByTitle(),
//          '/third': (context) => ListContainers(),
//          '/forth': (context) => ScreenByDesc(),
//
//          // When navigating to the "/second" route, build the SecondScreen widget.
//        }
//    );
//  }
//  }
