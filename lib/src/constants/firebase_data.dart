import 'package:firebase_storage/firebase_storage.dart';

class FirebaseData{
  static Future<String> getUrl(String path) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      var url = await ref.getDownloadURL();
      return url;
    } catch (error){
      print(error);
      return "";
    }
    
  }
}