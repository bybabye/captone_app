class Api {
  static const String api = "http://10.0.2.2:4000";
  // apiHome
  static const String listHome = "$api/home/list?page=1";
  //api user
  static const String signUp = "$api/user/add";
  static const String login = "$api/user/login";
  static const String updateProfile = "$api/user/update";
  //apisocket
  static const String apiSocket = "http://10.0.2.2:8800";
  //apichat
  static const String chatAdd = "$api/chat/add";
  static const String sendMess = "$api/chat/message/send";
  static const String getMessage = "$api/chat/message/list";
  static const String getChats = "$api/chat/list";
  static const String unsubcribeMessages = "$api/chat/messages/unsub";
  //api notification
  static const String getListNotification = "$api/notification/list";
  static const String addNotification = "$api/notification/add";
  static const String readNotification = "$api/notification/read";
  //api rental
  static const String addRental = "$api/rental/add";
  static const String getRentalForId = "$api/rental/get";
  static const String rentalConfirm = "$api/rental/confirm";
}
