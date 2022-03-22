import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseData{
  static Future<String> getUrl(String path) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      var url = await ref.getDownloadURL();
      return url;
    } catch (error){
      return "";
    }
    
  }
  static Future<String> upLoadImage(File image, String userID)async {
    try{
      var name = image.path.split("/").last;
      final ref = FirebaseStorage.instance.ref().child("users/$userID/$name");
      var x = await ref.putFile(image);
      return "users/$userID/$name";
    }catch (error) {
      print(error);
      return "";
    }

  }
}