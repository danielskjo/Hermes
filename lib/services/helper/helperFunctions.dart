import 'package:shared_preferences/shared_preferences.dart';

/// The HelperFunctions class is used to
/// store local data regarding the current user
/// i.e. username, email, etc.

class HelperFunctions {
  static String userLoggedInKey = "is_logged_in";
  static String userEmailKey = "email_key";
  static String userNameKey = "name_key";
  static String userRoleKey = "role_key";

  /// saving data to sharedpreference
  Future<bool> saveUserName({String userName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, userName);
  }

  Future<bool> saveUserEmail({String userEmail}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, userEmail);
  }

  Future<bool> saveUserLoggedIn({bool isUserLoggedIn}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(userLoggedInKey, isUserLoggedIn);
  }

  Future<bool> saveUserRole({String userRole}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userRoleKey, userRole);
  }

  /// fetching data from sharedpreference
  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRoleKey);
  }

  Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }

  List<String> setSearchParam(String username) {
    List<String> userNameSearchList = [];
    String temp = "";
    for (int i = 0; i < username.length; i++) {
      temp = temp + username[i];
      userNameSearchList.add(temp);
    }
    return userNameSearchList;
  }

  List<String> setSearchParamRequest(String request) {
    List<String> requestSearchList = [];
    String temp = '';
    for (int i = 0; i < request.length; i++) {
      temp = temp + request[i];
      requestSearchList.add(temp);
    }
    return requestSearchList;
  }
}
