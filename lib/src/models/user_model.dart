import 'package:mybook_flutter/src/constants/firebase_data.dart';

class UserModel{
  late String id;
  late String email;
  late String name;
  late String avatar;
  late String role;
  String avatarURL ="";

  UserModel({required this.id, required this.email, required this.name, required this.avatar, required this.role});

  factory UserModel.createUndefined() => UserModel(id: "", email: "", name: "", avatar: "", role: "");
  
  Map<String, dynamic> toJSON(){
    Map<String, dynamic> map = {
      "id" : id,
      "email": email,
      "name": name,
      "avatar": avatar,
      "role": role
    };
    return map;
  }
  Future<void> getAvatarUrl() async {
    if (avatar=="") return;
    avatarURL = await FirebaseData.getUrl(avatar);
  }
  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    avatar: json["avatar"],
    role: json["role"],
  );
}