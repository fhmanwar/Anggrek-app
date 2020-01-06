import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uas/src/app.dart';
import 'package:uas/src/models/anggreks.dart';
import 'package:uas/src/services/service_locator.dart';
import 'package:uas/src/ui/detail.dart';
import 'package:uas/src/ui/home.dart';
import 'package:uas/src/ui/login.dart';
import 'package:uas/src/ui/profile.dart';
import 'package:uas/src/ui/register.dart';

var route = <String, WidgetBuilder> {
  "/login": (BuildContext context) => new Login(),
  "/regis": (BuildContext context) => new Register(),
  "/home": (BuildContext context) => new Home(),
  "/profile": (BuildContext context) => new Profile(),
  // "/detail": (BuildContext context) => new Detail(),
};

void main() {
  setupLocator();
  runApp(
  new MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.pink[200],
      accentColor: Colors.pinkAccent[100]
    ),
    // debugShowCheckedModeBanner: false,
    home: new App(),
    routes: route,
  )
);
}

// void main() => runApp(
//   new MaterialApp(
//     theme: ThemeData(
//       primaryColor: Colors.purpleAccent,
//       accentColor: Colors.pinkAccent[100]
//     ),
//     // debugShowCheckedModeBanner: false,
//     home: new App(),
//     routes: route,
//   )
// );

// void main() {
//   runApp(new MaterialApp(
//     home: new SplashScreen(),
//     routes: <String, WidgetBuilder>{
//       '/App': (BuildContext context) => new App()
//     },
//   ));
// }


