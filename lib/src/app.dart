import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uas/src/ui/login.dart';
import 'package:uas/src/utils/navigate.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  startTime() async {
    // var _duration = new Duration(seconds: 5);
    return new Timer(Duration(seconds: 3), () => Navigate.gotoLogin(context));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    // Timer(Duration(seconds: 5), () => Navigate.gotoLogin(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.pinkAccent[100],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Selamat Datang",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 75.0,
                        child: new Image.asset(
                          'assets/images/logoanggrek.png',
                          scale: 3.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Kampung Anggrek",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Online Store Anggrek",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

  // startTime() async {
  //   var _duration = new Duration(seconds: 5);
  //   return new Timer(_duration, navigationPage);
  // }
  // void navigationPage() {
  //   Navigator.of(context).pushReplacementNamed('/App');
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // Timer(Duration(seconds: 5), () => Navigate.goIntro(context));
  //   startTime();
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.purpleAccent[100],
//               // gradient: LinearGradient(
//               //   colors: [Colors.pinkAccent, Colors.purpleAccent], 
//               //   begin: Alignment.centerRight,
//               //   end: Alignment.centerLeft
//               // )
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "Selamat Datang",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18.0
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10.0),
//                       ),
//                       CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 75.0,
//                         // child: Icon(
//                         //   Icons.local_florist,
//                         //   color: Colors.greenAccent,
//                         //   size: 50.0,
//                         // ),
//                         child: new Image.asset(
//                           'images/logoanggrek.png',
//                           scale: 3.0,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10.0),
//                       ),
//                       Text(
//                         "Kampung Anggrek",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24.0
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     CircularProgressIndicator(),
//                     Padding(
//                       padding: EdgeInsets.only(top: 20.0),
//                     ),
//                     Text(
//                       "Online Store Anggrek",
//                       softWrap: true,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 18.0,
//                         color: Colors.white
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }