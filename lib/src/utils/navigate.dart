import 'package:flutter/material.dart';
import 'package:uas/src/models/anggreks.dart';
import 'package:uas/src/ui/detail.dart';

class Navigate {
  static void gotoLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/login');
  }
  static void gotoRegis(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/regis');
  }
  static void gotoHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }
  static void gotoProfile(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/profile');
  }
  // static void gotoDetail(BuildContext context) {
  //   Navigator.of(context).pushReplacementNamed('/detail');
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     fullscreenDialog: true,
  //   //     builder: (BuildContext context) => Detail(
  //   //       anggreks: anggrek,
  //   //     ),
  //   //   ),

  //   //   // MaterialPageRoute(builder: (context) => Detail()),
  //   // );
  // }
  
}