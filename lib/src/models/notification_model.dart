import 'package:flutter/material.dart';

class NotificationModel {
  String postID;
  String postName;
  String userID;
  String message;
  String type;
  int data;
  bool readed;
  String createAt;

  NotificationModel(
      {
      required this.postID,
      required this.postName,
      required this.userID,
      required this.type,
      required this.data,
      required this.readed,
      required this.createAt,
      required this.message
      }
  );
  factory NotificationModel.fromJSON(Map<String, dynamic> json) => NotificationModel(
    postID: json["postID"],
    postName: json["postName"],
    userID: json["userID"],
    type: json["type"],
    data: json["data"],
    readed: json["readed"],
    message: json["message"],
    createAt: json["createAt"],
  );
  Widget showNotification() {
    switch (type) {
      case '1': return ListTile(
        leading: Icon(Icons.admin_panel_settings),
        title: Text(message),
      );
     
       case '2': return ListTile(
        leading: Icon(Icons.check),
        title: Text("Post $postName has been ${message+'ed'}"),
      );
      case '3': return ListTile(
        leading: Icon(Icons.favorite),
        title: Text("Post $postName has been ${message+'ed'} by $data people"),
      );
       case '4': return ListTile(
        leading: Icon(Icons.favorite),
        title: Text("Post $postName has been ${message+'ed'} by $data people"),
      );
      default: return ListTile(
        leading: Icon(Icons.admin_panel_settings),
        title: Text("Error $type"),
      );
    }
  }
}
