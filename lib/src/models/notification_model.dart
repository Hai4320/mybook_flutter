import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';

class NotificationModel {
  String postID;
  String postName;
  String userID;
  String message;
  String type;
  int data;
  bool readed;
  String createdAt;

  NotificationModel(
      {
      required this.postID,
      required this.postName,
      required this.userID,
      required this.type,
      required this.data,
      required this.readed,
      required this.createdAt,
      required this.message
      }
  );
  factory NotificationModel.fromJSON(Map<String, dynamic> json) => NotificationModel(
    postID: json["postID"]??"",
    postName: json["postName"]??"",
    userID: json["userID"]??"",
    type: json["type"]??"",
    data: json["data"]??"",
    readed: json["readed"]??"",
    message: json["message"]??"",
    createdAt: json["createdAt"]??"",
  );
  Widget showNotification() {
    DateFormat formatter = DateFormat('LLL dd, yyyy  HH:mm aa');
    switch (type) {
      case '1': return ListTile(
        leading: const Icon(Icons.admin_panel_settings),
        title: Text("Admin: "+message),
        subtitle: Text(formatter.format(DateTime.parse(createdAt))),
      );
     
       case '2': return ListTile(
        leading: Icon(message == "accept"? Icons.check : Icons.clear),
        title: Text("Post ${postName} has been ${message+'ed'}"),
        subtitle: Text(formatter.format(DateTime.parse(createdAt))),
        textColor: readed == true? AppColors.black33: AppColors.blue,
      );
      case '3': return ListTile(
        leading: const Icon(Icons.favorite),
        title: Text("Post ${postName} has been ${message+'d'} by ${data} people"),
        subtitle: Text(formatter.format(DateTime.parse(createdAt))),
      );
       case '4': return ListTile(
        leading: const Icon(Icons.comment),
        title: Text("Post ${postName} has been ${message+'ed'} by ${data} people"),
        subtitle: Text(formatter.format(DateTime.parse(createdAt))),
      );
      default: return ListTile(
        leading: const Icon(Icons.admin_panel_settings),
        title: Text("Error ${type}"),
        subtitle: Text(formatter.format(DateTime.parse(createdAt))),
      );
    }
  }

}
