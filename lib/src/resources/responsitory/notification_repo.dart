import 'dart:convert';

import 'package:mybook_flutter/src/models/notification_model.dart';
import 'package:mybook_flutter/src/resources/responsitory/user_repo.dart';
import 'package:mybook_flutter/src/resources/service/api.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  List<NotificationModel> notifications = [];

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      var userRepo = UserRepository();
      var userID = await userRepo.getUserID();
      var res = await http.post(Uri.parse(AppApis.notification_API),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"userID": userID}));
      var body = jsonDecode(res.body);
      if(res.statusCode == 200 && body is List) {
        List<NotificationModel> result = body.map((e) => NotificationModel.fromJSON(e)).toList();
        notifications = result;
        print(notifications.length);
        return result;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }
  List<NotificationModel> sortByTime(){
    notifications.sort((a,b)=> b.createdAt.compareTo(a.createdAt));
    return notifications;
  }

}
