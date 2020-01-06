
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:uas/src/models/anggreks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/src/utils/navigate.dart';

class ApiServices {
  // static const String url = "http://127.0.0.1:8000/api/apianggrek";
  // static const String url = "http://127.0.0.1:8000/api";
  // static const String url = "http://192.168.100.4:80/api";
  static const String url = "http://36.80.199.85/api";
  // static const String url = "http://36.80.199.85/ppb-web/api";
  
  static Future<List<Anggreks>> getList() async {
    try {
      final response = await http.get('$url/apianggrek');
      if (response.statusCode == 200) {
        List<Anggreks> list = parseAnggrek(response.body);
        print(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
      
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Anggreks> parseAnggrek(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Anggreks>((json) => Anggreks.fromJson(json)).toList();
  }

  

  // static Future<List<Anggreks>> getList() async {
  //   var res = await http.get(
  //     Uri.encodeFull(url),
  //     headers: {"Accept": "application/json"}
  //   );
  //   var convertDataToJson = jsonDecode(res.body);
  //   print(convertDataToJson['response']);
  //   List<Anggreks> list = convertDataToJson['response'];
  //   return list;
  // }

  var status;
  var token;

  savePref(String token, String name, String email, String pass) async {
    final prefs = await SharedPreferences.getInstance();
    final nameApi = 'name';
    final emailApi = 'email';
    final passApi = 'pass';
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    prefs.setString(nameApi, name);
    prefs.setString(emailApi, email);
    prefs.setString(passApi, pass);
    prefs.commit();  
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }


  loginData(String email , String password) async{
    String loginUrl = "$url/login";
    final response = await http.post(loginUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "email": "$email",
          "password" : "$password"
        } ) ;
    status = response.body.contains('error');
    var data = json.decode(response.body);
    if(status){
      print('data : ${data["error"]}');
      // Toast.show("Not Found, You must Register", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }else{
      print('token : ${data["meta"]["token"]}');
      savePref(data["meta"]["token"], data["data"]["name"], data["data"]["email"], data["data"]["password"]);
    }
  }

  registerData(String name ,String email , String password) async{
    String registerUrl = "$url/register";
    final response = await http.post(registerUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name": "$name",
          "email": "$email",
          "password" : "$password"
        } ) ;
    status = response.body.contains('error');
    var data = json.decode(response.body);
    if(status){
      print('data : ${data["error"]}');
    }else{
      print('token : ${data["meta"]["token"]}');
      savePref(data["meta"]["token"], data["data"]["name"], data["data"]["email"], data["data"]["password"]);
    }

  }


}