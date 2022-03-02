
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:mybook_flutter/src/resources/service/api.dart';

import '../../models/user_model.dart';

class UserRepository{
  // login
  Future<Map<String, dynamic>> login(String email, String password) async {
    var res = await http.post(
      Uri.parse(AppApis.login_API),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({ 
        "email": email, 
        "password": password
      })
    );
    
    var body = jsonDecode(res.body);
    if(res.statusCode == 200) {
      return {
        "statusCode": res.statusCode,
        "message": body["message"],
        "user": UserModel.fromJSON(body["data"])
      };
    }
    else{
      if (body["message"]!=null)
      {
        return {
        "statusCode": res.statusCode,
        "message": body["message"],
        };
      }
      else {
        throw Exception(body);
      }
      
    }
  }


  // data from shared_preferences
  bool isLogined() => false;

  Future<void> setLoginData(bool isLogined, UserModel user) async {
    return;
  }
  Future<void> deleteLoginData() async {
    return;
  }
}