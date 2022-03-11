import 'package:mybook_flutter/src/constants/firebase_data.dart';

List<String> typeBook = ["NOVEL","SELF HELP","CHILDREN'S BOOK","WORK STYLE","SCIENCE","OTHERS"];
List<String> typeTab = ["ALL","NOVEL","SELF HELP","CHILDREN'S BOOK","WORK STYLE","SCIENCE","OTHERS"];
List<String> typeSort = ["None","Name A-Z", "Name Z-A", "View increase", "View decrease"];
class BookModel{
  String id;
  String title;
  String author;
  String type;
  String description;
  String company;
  String publishingCompany;
  String status;
  String image;
  String pdf;
  List<dynamic> audio;
  String imageUrl="";
  int view = 0;
  int like = 0;
  bool isSaved = false;
  bool isViewed = false;
  bool isLiked = false;
  
  BookModel({
    required this.id, 
    required this.title,
    required this.author, 
    required this.type, 
    required this.description, 
    required this.company, 
    required this.publishingCompany, 
    required this.status,
    required this.image,
    required this.pdf,
    required this.audio
  });

  Future<void> loadImageUrl() async {
    if (image=="") return;
    imageUrl = await FirebaseData.getUrl(image);
  }
  Future<String> loadAudioUrl(int index) async {
    return "";
  }
  Future<String> loadPDF() async {
    return "";
  }
  factory BookModel.fromJSON(Map<String, dynamic> json) => BookModel(
    id: json["_id"],
    title: json["Title"]??"",
    author: json["Author"]??"",
    type: json["Type"]??"OTHERS",
    description: json["Description"]??"",
    company: json["Company"]??"",
    publishingCompany: json["PublishingCompany"]??"",
    status: json["Status"]??"None",
    image: json["Image"]??"",
    pdf: json["PDF"]??"",
    audio: json["Audio"] is List ? json["Audio"]: [],

  );
}

class BookData{
  List<BookModel> books;
  BookData({required this.books});
  
  BookModel? findByID(String id){
    return null;
  } 
  List<BookModel> findByType(int type){
    if (type<0||type>=typeTab.length) return [];
    if (type == 0) return books; 
    String typeName = typeTab[type];
    return books.where((e) => e.type==typeName).toList();
  }
  List<BookModel> searchBooks(String query){
    return books.where((e) => e.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
   List<BookModel> likedBooks(){
    return books.where((e) => e.isLiked).toList();
  }
   List<BookModel> savedBooks(){
    return books.where((e) => e.isSaved).toList();
  }
  List<BookModel> findByTypeAndSort(int type,int sort){
    
    var result =  findByType(type);
    switch (sort){
       case 0: break;
       case 1: result.sort((a,b)=> (a.title.compareTo(b.title))); break;
       case 2: result.sort((a,b)=> (b.title.compareTo(a.title))); break;
       case 3: result.sort((a,b)=> (a.view.compareTo(b.view))); break;
       case 4: result.sort((a,b)=> (b.view.compareTo(a.view))); break;
       default: break;
    }
    return result;
  }
} 