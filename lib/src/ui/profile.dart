import 'package:flutter/material.dart';
import 'package:uas/src/services/api_services.dart';
import 'package:uas/src/utils/navigate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ApiServices _apiServices = new ApiServices();
  String name, email, pass;

  profilePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('name');
      email = pref.getString('email');
      pass = pref.getString('pass');
    });
  }

  @override
  void initState() { 
    super.initState();
    profilePref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.pink[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        title: new Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _apiServices.savePref('0',null,null,null);
              Navigate.gotoLogin(context);
            } 
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          // new Image(
          //   image: new AssetImage('images/background.jpg'),
          //   fit: BoxFit.cover,
          //   color: Colors.black38,
          //   colorBlendMode: BlendMode.darken,
          // ),
          new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.pink[200],Colors.pinkAccent]
              )
            ),
            height: 210.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  '',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                new Text(
                  '',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "django",
                    style:TextStyle(
                      fontSize: 25.0, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(padding: new EdgeInsets.only(bottom: 50.0),),
                  Container(
                    padding: new EdgeInsets.only(left: 40.0,right: 40.0, top: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: new InputDecoration(
                            labelText: "Nama",
                          ),
                          keyboardType: TextInputType.text,
                          // controller: _c,
                        ),
                        Text(
                          "$name",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        TextField(
                          decoration: new InputDecoration(
                            labelText: "Email",
                          ),
                          keyboardType: TextInputType.text,
                          // controller: _c,
                        ),
                        Text(
                          "$email",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        TextField(

                          decoration: new InputDecoration(
                            labelText: "Password",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        Text(
                          "$pass",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        // Text("prin input : $getbayar"),
                        // Text("prin bayar : $_bayar"),
                        Padding(padding: new EdgeInsets.only(bottom: 25.0),),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Text(
                        //       "Kembalian",
                        //       textAlign: TextAlign.left,
                        //       style: TextStyle(
                        //         fontSize: 18.0,
                        //       ),
                        //     ),
                        //     Text("Rp $_kembalian"),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: AssetImage('assets/images/default.png'),
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    fit: BoxFit.cover, 
                    image: AssetImage('assets/images/default.png')
                  )
                ),
              )
            ),
          ),

          new Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),),
                new MaterialButton(
                  height: 40.0,
                  minWidth: 150.0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)
                  ),
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  child: new Text(
                    'Submit',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  splashColor: Colors.purpleAccent,
                  onPressed: () => {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
