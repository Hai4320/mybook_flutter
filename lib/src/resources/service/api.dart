class AppApis {
  static String API = "https://mybooksv.herokuapp.com";
  static String login_API = API + "/users/login";
  static String notification_API = API + "/users/getnotify";

  static String getBook_API = API + "/books";
  static String getBookHistory_API = API + "/books/getBookHistorys";
  static String viewBook_API = API + "/books/view";
  static String likeBook_API = API + "/books/like";
  static String saveBook_API = API + "/books/save";
  
  static String getComments_API = API + "/comments/get";
  static String addComments_API = API + "/comments/add";
}
