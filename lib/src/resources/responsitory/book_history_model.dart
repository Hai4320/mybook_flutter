class BookHistoryModel {
  String bookID;
  int like;
  int view; 
  int stars;
  int starsCount;
  BookHistoryModel({required this.bookID,required this.like,required this.view,required this.stars,required this.starsCount});
  factory BookHistoryModel.fromJSON(Map<String, dynamic> json) => BookHistoryModel(
    bookID: json["bookID"],
    like: json["like"] ?? 0,
    view: json["view"] ?? 0,
    stars: json["stars"]?? 0,
    starsCount: json["starsCount"]?? 0
  );


}
class MyBookHistoryModel {
  String id;
  String bookID; 
  String userID;
  String updatedAt;
  bool liked;
  bool saved;
  MyBookHistoryModel({required this.id,required this.bookID,required this.userID,required this.saved,required this.liked,required this.updatedAt});

  factory MyBookHistoryModel.fromJSON(Map<String, dynamic> json) =>MyBookHistoryModel(
    id: json["_id"],
    bookID: json["bookID"],
    userID: json["userID"],
    liked: json["liked"]?? false,
    saved: json["saved"]?? false,
    updatedAt: json["updatedAt"]??""


  );

}