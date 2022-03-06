import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/book_model.dart';
import '../service/api.dart';

class BookRepository {
  bool success = false;
  String message = "Error when starting";
  BookData books = BookData(books: []);
  Future<BookData?> getBooksByApi() async {
    try {
      var res = await http.get(
        Uri.parse(AppApis.getBook_API),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (body is List) {
          List<BookModel> data =
              (body.map((e) => BookModel.fromJSON(e))).toList();
          books = BookData(books: data);
          success = true;
          return books;
        } else {
          success = false;
          message = "Can't find any book!";
          return null;
        }
      } else {
        message = body.toString();
        return null;
      }
    } catch (error) {
      message = error.toString();
      throw Exception(error);
    }
  }
}
