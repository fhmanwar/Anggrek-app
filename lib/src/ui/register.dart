import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:uas/src/services/api_services.dart';
import 'package:uas/src/utils/navigate.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  ApiServices _apiServices = new ApiServices();
  String name, email, pass; 
  bool _secureText = true;
  final _key = new GlobalKey<FormState>();

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
        print('$name, $email, $pass');
        // _apiServices.registerData(name, email, pass);
        _apiServices.registerData(name, email, pass).whenComplete((){
          if(_apiServices.status){
            Toast.show("Email Already Use ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }else{
                // _loginStatus = LoginStatus.signIn;
                // _apiServices.savePref(token);
              Toast.show("success", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              // Navigate.gotoHome(context);
          }
        });
      } else {
        Toast.show("email or password is wrong", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        print('error');
      }
        // print(_apiServices.status);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                new Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2,),),
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
                            validator: (e){
                              if (e.isEmpty) {
                                return "Please enter Name";
                              }
                            },
                            onSaved: (e) => name = e,
                            decoration: new InputDecoration(
                              labelText: "Enter Your Name",
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          new TextFormField(
                            validator: validateEmail,
                            onSaved: (e) => email = e,
                            decoration: new InputDecoration(
                              labelText: "Enter email",
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
                            child: new Text('Register'),
                            onPressed: () {
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
                    new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20.0),),
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Already a member? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                            ),
                          ),
                          onTap: () => Navigate.gotoLogin(context),
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
  }
}