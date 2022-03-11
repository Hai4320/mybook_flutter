import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mybook_flutter/src/resources/responsitory/book_history_model.dart';
import 'package:mybook_flutter/src/resources/responsitory/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/book_model.dart';
import '../service/api.dart';

class BookRepository {
  bool success = false;
  String message = "Error when starting";
  BookData books = BookData(books: []);
  UserRepository user = UserRepository();
  Future<BookData?> getBooksByApi() async {
    try {
      String userID = await user.getUserID();
      print(userID);
      var res1 = await http.get(
        Uri.parse(AppApis.getBook_API),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var res2 = await http.post(Uri.parse(AppApis.getBookHistory_API),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"id": userID})
      );
      var body1 = jsonDecode(res1.body);
      var body2 = jsonDecode(res2.body);
      List<BookModel> data = [];
      if (res1.statusCode == 200) {
        if (body1 is List){
          data = (body1.map((e) => BookModel.fromJSON(e))).toList();
          books = BookData(books: data);
          success = true;
        }
      } else {
        success = false;
        message = body1.toString();
        return null;
      }
      books = BookData(books: data);

      if (res2.statusCode == 200) {
        List<dynamic> bookHistorys= body2["AllBookHistorys"].map((e) => BookHistoryModel.fromJSON(e)).toList();
        List<dynamic> userHistorys = body2["bookForUser"].map((e) => MyBookHistoryModel.fromJSON(e)).toList();
        for (int i = 0; i < data.length; i++) {
          BookHistoryModel history = bookHistorys.firstWhere((e) => (e is BookHistoryModel && e.bookID == data[i].id));
          MyBookHistoryModel? userHistory = userHistorys.firstWhere(
              (e) => (e is MyBookHistoryModel && e.bookID == data[i].id), 
              orElse: () => null
          );
          data[i].view = history.view;
          data[i].like = history.like;
          data[i].isLiked = userHistory == null ? false: userHistory.liked;
          data[i].isSaved = userHistory == null ? false: userHistory.saved;
          data[i].isViewed = userHistory == null;
        }
        success = true;
      } else {
        success = false;
        message = body2.toString();
        return books;
      }
      books = BookData(books: data);
      return books;
    } catch (error) {
      message = error.toString();
      throw Exception(error);
    }
  }
}
