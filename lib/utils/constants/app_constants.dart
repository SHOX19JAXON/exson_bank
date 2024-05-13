import 'dart:ffi';

class AppConstants {

  static  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static  RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  static  RegExp textRegExp = RegExp("[a-zA-Z]");
  static  RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static  RegExp number = RegExp(r'(^[0-9]+$)');




  static String userst ="";
  static String cardst ="";
  static String users = "users";
  static String cards = "cards";
  static String history45 = "history45";
  static String history2 = "history2";
  static String histories = "histories";

  static String cards_database ="cards_database";
  static String cardsDatabase = "cards_database";

  // static String clientID = "699471060311-boktfei0alnfbjc140gako8vvncn4opj.apps.googleusercontent.com";

  static String categories = "categories";
  static String products = "products";

  static bool malumot = true;

}


