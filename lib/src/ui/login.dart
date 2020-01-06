import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uas/src/services/api_services.dart';
import 'package:uas/src/utils/navigate.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
enum LoginStatus{
  notSignIn,
  signIn
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  ApiServices _apiServices = new ApiServices();
  String msgStatus = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;
  String email, pass; 
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key) ?? 0;
    final nameAPIkey = prefs.getString('name');
    final emailAPIkey = prefs.getString('email');
    final passAPIkey = prefs.getString('pass');
    print('read : $value, $nameAPIkey, $emailAPIkey, $passAPIkey');
    if (value != '0') {
      Navigate.gotoHome(context);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500)
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut
    );
    _animation.addListener(() => this.setState((){}));
    _animationController.forward();
    read();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return "Enter Your Email";
    } else if (!regex.hasMatch(value)){
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check(){
    setState(() {
      final form = _key.currentState;
      if(form.validate()){
        form.save();
        print('$email, $pass');
        // loginhome();
        _apiServices.loginData(email, pass).whenComplete((){
          if(_apiServices.status){
            Toast.show("Nof Found, You must Register", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }else{
                // _loginStatus = LoginStatus.signIn;
                // _apiServices.savePref(token);
              // Toast.show("login", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              Navigate.gotoHome(context);
          }
        });
      } else {
        Toast.show("email or password is wrong", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        print('error');
      }
      
    });
  }

  
  Future<FirebaseUser> _loginWithFacebook() async{
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    debugPrint(result.status.toString());

    // if (result.status == FacebookLoginStatus.loggedIn) {
    //   FirebaseUser user = await _auth.signInWithFacebook(accessToken: result.accessToken.token);
    //   return user;
    // }

    // return null;
  }

  @override
  Widget build(BuildContext context) {
    // switch (_loginStatus) {
    //   case LoginStatus.notSignIn:

        return new Scaffold(
          backgroundColor: Colors.pinkAccent,
          body: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Image(
                image: new AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                color: Colors.black38,
                colorBlendMode: BlendMode.darken,
              ),
              SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1,),),
                    new FlutterLogo(
                      size: _animation.value * 100,
                    ),
                    new Form(
                      key: _key,
                      child: new Theme(
                        data: new ThemeData(
                          brightness: Brightness.dark,
                          primarySwatch: Colors.pink,
                          inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                            )
                          )
                        ),
                        child: new Container(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: <Widget>[
                              new TextFormField(
                                validator: validateEmail,
                                onSaved: (e) => email = e,
                                controller: _emailController,
                                decoration: new InputDecoration(
                                  labelText: "Enter Email",
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              new TextFormField(
                                validator: (e){
                                  if (e.isEmpty) {
                                    return "Please enter password";
                                  }
                                },
                                obscureText: _secureText,
                                onSaved: (e) => pass = e,
                                controller: _passwordController,
                                decoration: new InputDecoration(
                                  labelText: "Enter Password",
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility ),
                                  )
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              new Padding(
                                padding: const EdgeInsets.only(top: 70.0),
                              ),
                              new MaterialButton(
                                height: 50.0,
                                minWidth: 160.0,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(15.0)
                                ),
                                color: Colors.pinkAccent,
                                textColor: Colors.white,
                                child: new Text('Login'),
                                onPressed: (){
                                  // _login();
                                  check();
                                },
                                splashColor: Colors.purpleAccent,
                              ),
                              // new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10.0),),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GoogleSignInButton(
                          onPressed: () {
                            // signInGoogle();
                          },
                        ),
                        Text(
                          "or ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),
                        ),
                        FacebookSignInButton(
                          onPressed: _loginWithFacebook,
                        ),
                        new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20.0),),
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Don't have an account ? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                "Register ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                                ),
                              ),
                              onTap: () => Navigate.gotoRegis(context),
                            )
                          ],
                        ),
                      ],
                    ),  
                    
                  ],
                ),
              ),
            ],
          ),
        );

    //     break;
    //   case LoginStatus.signIn:
    //     Navigate.gotoHome(context);
    //     break;
    // }
    
  }

  // void _showDialog() {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text(validateEmail(value)),
  //         content: new Text("You can't login"),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<List> _login() async {
  //   final res = await http.post(
  //     "http://36.80.199.85/api/login",
  //     body: {
  //       'email' : _emailController.text,
  //       'password' : _passwordController.text,
  //     }
  //   );
  //   var dataKonsumen = json.decode(res.body);
  //   if (dataKonsumen.length == 0) {
  //       print("can't login");
  //     // setState(() {
  //     //   // _showDialog();
  //     // });
  //   } else {
  //     print(res.body);
  //     Navigate.gotoHome(context);
  //   }
  // }

  // loginhome() async {
  //   final res = await http.post(
  //     "http://36.80.199.85/api/login",
  //     body: {
  //       // 'email' : _emailController.text,
  //       // 'password' : _passwordController.text,
  //       'email' : email,
  //       'password' : pass,
  //     }
  //   );
  //   final data = jsonDecode(res.body);
  //   print(data);
  // }

  // final GoogleSignIn googleSignIn = new GoogleSignIn();
  // void signInGoogle() async {
  //   FirebaseUser user;
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //   user = await _auth.signInWithGoogle(
  //     idToken: googleSignInAuthentication.idToken, 
  //     accessToken: googleSignInAuthentication.accessToken
  //   );

  //   if (user !=null) {
  //     print('Signed Into Google Account');
  //   }

  // }

}