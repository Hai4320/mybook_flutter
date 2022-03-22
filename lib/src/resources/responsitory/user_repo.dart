
import 'dart:convert';

import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";

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
  Future<bool> isLogined() async{
    final prefs = await SharedPreferences.getInstance();
    final bool? data = prefs.getBool('isLogined');
    return data ?? false;
  }
  Future<String> getUserID() async{
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('userID');
    return data?? "";
  }
  Future<UserModel> getUserData() async{
    final prefs = await SharedPreferences.getInstance();
    return UserModel(
      id: prefs.getString('userID')?? "", 
      avatar: prefs.getString('userAvatar')?? "",
      email: prefs.getString('userEmail')?? "",
      name: prefs.getString('userName')?? "",
      role: prefs.getString('userRole')?? "",
      );
  }
  Future<void> setLoginData(bool isLogined, UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogined", isLogined);
    await prefs.setString("userID", user.id);
    await prefs.setString("userName", user.name);
    await prefs.setString("userEmail", user.email);
    await prefs.setString("userAvatar", user.avatar);
    await prefs.setString("userRole", user.role);
  }
  Future<void> updateUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userID", user.id);
    await prefs.setString("userName", user.name);
    await prefs.setString("userEmail", user.email);
    await prefs.setString("userAvatar", user.avatar);
    await prefs.setString("userRole", user.role);
  }
  Future<void> deleteLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogined", false);
    return;
  }
}