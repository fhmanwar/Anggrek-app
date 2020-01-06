import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:uas/src/models/anggreks.dart';
import 'package:uas/src/services/api_services.dart';
import 'package:uas/src/services/callmsgservice.dart';
import 'package:uas/src/services/service_locator.dart';
import 'package:uas/src/ui/checkout.dart';
import 'package:uas/src/ui/item_layout.dart';
import 'package:uas/src/ui/profile.dart';
import 'package:uas/src/utils/maps.dart';
import 'package:uas/src/utils/navigate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home() : super();
  final String title = "Kampung Anggrek";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var url = "http://127.0.0.1:8000/api/apianggrek";
  // var url = "http://http://36.80.199.85/api/apianggrek";
  var url = "http://36.80.199.85/ppb-web/api/product/data/";
  Anggreks anggrek;
  ApiServices _apiServices;
  StreamController<int> streamController = new StreamController<int>();

  final CallMsgService _service = locator<CallMsgService>();
  
  // final String phoneUrl = "tel:+628123456789";
  // final String smsUrl = "sms:+628123456789";
  final String number = "+62 812 3456 7890";
  final String email = "dancamdev@example.com";

  int total = 0;  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _apiServices = ApiServices();
    showAllData();
    // print("2nd work");
  }

  showAllData() async {
    // var res = await http.get(
    //   Uri.encodeFull(url),
    //   headers: {"Accept": "application/json"}
    // );
    // var convertDataToJson = jsonDecode(res.body);
    // print(convertDataToJson['response']);

    // var res = await http.get(url);
    // print(res.body);
    // var decodeJon = jsonDecode(res.body);
    // anggrek = Anggreks.fromJson(decodeJon);
  }

  gridview(AsyncSnapshot<List<Anggreks>> list){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: list.data.map(
          (anggrek){
            return GestureDetector(
              child: GridTile(
                child: ItemLayout(anggrek),
              ),
              onTap: () {
                setState(() {
                  total += anggrek.price;
                });
              },
            );
          },
        ).toList(),
      ),
    );
  }

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kampung Anggrek"),
        backgroundColor: Colors.pink[300],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            // child: Icon(Icons.menu),
            child: new IconButton(
              icon: Icon(
                Icons.more_vert,
              ),
              onPressed: () => _onBottomPressed(),
            )
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: CustomPaint(
          child: Container(),
          foregroundPainter: FloatingPainter(),
        ),
        backgroundColor: Colors.white,
        onPressed: () {},
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: FutureBuilder<List<Anggreks>>(
              future: ApiServices.getList(),
              builder: (context, snapshot) {
                // not setstate here
                //
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                //
                if (snapshot.hasData) {
                  streamController.sink.add(snapshot.data.length);
                  // gridview
                  return gridview(snapshot);
                }

                return circularProgress();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: new Container(
        height: 60.0,
        color: Colors.pink[100],
        child: new Container(
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Total Harga : ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Rp $total',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => Checkout(anggreks: anggrek, total: total,),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    streamController.close();
    super.dispose();
  }

  void _onBottomPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black54,
          height: 300,
          child: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Call Center'),
                  onTap: () => _service.call(number),
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('SMS Center'),
                  onTap: () => _service.msg(number),
                ),
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Maps/Lokasi'),
                  onTap: () => MapsLauncher.launchCoordinates(-6.9829, 110.4091),
                  // onTap: () => Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(
                  //     builder: (context) => MapsLoc(),
                  //   ),
                  // ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  // onTap: () => Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(
                  //     builder: (context) => Profile(),
                  //   ),
                  // ),
                  onTap: () => Navigate.gotoProfile(context),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(30),
                topLeft: const Radius.circular(30),
              )
            ),
          )
        );
      }
    );
  }

  // _telURL() async {
  //   const url = 'tel:+1 555 010 999';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

}

class FloatingPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint amberPaint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 5;
      
    Paint greenPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 5;

    Paint bluePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5;

    Paint redPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5;

    canvas.drawLine(
      Offset(size.width*0.27, size.height*0.5), 
      Offset(size.width*0.5, size.height*0.5), 
      amberPaint
    );
    canvas.drawLine(
      Offset(size.width*0.5, size.height*0.5), 
      Offset(size.width*0.5, size.height - (size.height*0.27)), 
      greenPaint
    );
    canvas.drawLine(
      Offset(size.width*0.5, size.height*0.5), 
      Offset(size.width - (size.width*0.27), size.height*0.5), 
      bluePaint
    );
    canvas.drawLine(
      Offset(size.width*0.5, size.height*0.5), 
      Offset(size.width*0.5, size.height*0.27), 
      redPaint
    );
  }

  @override
  bool shouldRepaint(FloatingPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(FloatingPainter oldDelegate) => false;
}

