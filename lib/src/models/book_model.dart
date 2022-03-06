List TypeBook = ["NOVEL","SELF HELP","CHILDREN'S BOOK","WORK STYLE","SCIENCE","OTHERS"];
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

  Future<String> loadImageUrl() async {
    return "";
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
  List<BookModel> findByType(String type){
    return [];
  }
} 