import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nhsurveys_feedback/models/question.dart';
import 'package:nhsurveys_feedback/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:nhsurveys_feedback/widgets/notification_text.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {

  Status _status = Status.Uninitialized;
  String _token;
  bool _error;
  NotificationText _notification;

  Status get status => _status;
  String get token => _token;
  NotificationText get notification => _notification;

  //final String api = 'https://laravelreact.com/api/v1/auth';
  final String api = 'http://nhsurveys.com/api/';

  initAuthProvider() async {

    print("sudhanshu_login");
    String token = await getToken();

    print("2");
    if (token != null) {
      _token = token;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _status = Status.Authenticating;
    _notification = null;

    notifyListeners();

    final url = "$api/v1/login";


    Map<String, String> body = {
      'user_name': email,
      'password': password,
      'user_type': '1',
      'device_name': 'Samsung A50s',
      'device_id': 'affsdfadsaf'

    };
    final response = await http.post("http://10.0.2.2/nhsurveys/api/v1/login", body: body,headers: {
              'Accept': 'application/json',
              "api-key": "c5ebcee3af05a5ae1b6a09c668ba798c"});
    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(utf8.decode(response.bodyBytes));
      print(apiResponse);
      _status = Status.Authenticated;
      _error = apiResponse['error'];
      _token = apiResponse['user_login_key'];
      //print(getToken());
      await storeUserData(apiResponse);
      notifyListeners();
      return true;
    }

    if (response.statusCode == 401) {
      _status = Status.Unauthenticated;
      _notification = NotificationText('Invalid email or password.');
      notifyListeners();
      return false;
    }

    _status = Status.Unauthenticated;
    _notification = NotificationText('Server error.');
    notifyListeners();
    return false;
  }


  Future<Map> register(String name, String email, String password, String passwordConfirm) async {
    final url = "$api/register";

    Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm,
    };

    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error.'
    };

    final response = await http.post( url, body: body, );

    if (response.statusCode == 200) {
      _notification = NotificationText('Registration successful, please log in.', type: 'info');
      notifyListeners();
      result['success'] = true;
      return result;
    }

    Map apiResponse = json.decode(response.body);

    if (response.statusCode == 422) {
      if (apiResponse['errors'].containsKey('email')) {
        result['message'] = apiResponse['errors']['email'][0];
        return result;
      }

      if (apiResponse['errors'].containsKey('password')) {
        result['message'] = apiResponse['errors']['password'][0];
        return result;
      }

      return result;
    }

    return result;
  }

  Future<bool> sendResponseToServer(String name, String mobile, String answer_ids, String response_rating, String rating, String comment, String device_id, String device_name) async {
    final url = "$api/register";

    Map<String, String> body = {
      'name': name,
      'mobile': mobile,
      'answer_ids': answer_ids,
      'response_rating': response_rating,
      'rating': rating,
      'comment': comment,
      'device_id': device_id,
      'device_name': device_name
    };
    print(body);
    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error.'
    };

    final response = await http.post("http://10.0.2.2/nhsurveys/api/v1/submit_response", body: body,headers: {
              'Accept': 'application/json',
              "api-key": Constant.api_key,
              "user-login-key": token});
  

    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(utf8.decode(response.bodyBytes));
      _status = Status.Authenticated;
      print(apiResponse);
      //print(getToken());
      notifyListeners();
      return true;
    }

    if (response.statusCode == 401) {
      _status = Status.Unauthenticated;
      _notification = NotificationText('Invalid email or password.');
      notifyListeners();
      return false;
    }

    _status = Status.Unauthenticated;
    _notification = NotificationText('Server error.');
    notifyListeners();
    return false;
  }


  Future<List<Question>> initApplication() async {
    List<Question> list = List();
    _status = Status.Authenticating;
    _notification = null;

    //notifyListeners();

    final url = "$api/v1/login";

    final response = await http.get("http://10.0.2.2/nhsurveys/api/v1/init",headers: {
              'Accept': 'application/json',
              "api-key": "c5ebcee3af05a5ae1b6a09c668ba798c"});

    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error.'
    };
    
     if (response.statusCode == 200) {
       Map<String, dynamic> apiResponse = json.decode(utf8.decode(response.bodyBytes));
       list = (apiResponse['questions'] as List)
          .map((data) => new Question.fromJson (data))
          .toList();
        print(list[0].question_english);
        return list;
     }
    
    return list;
  }

  Future<bool> passwordReset(String email) async {
    final url = "$api/forgot-password";

    Map<String, String> body = {
      'email': email,
    };

    final response = await http.post( url, body: body, );

    if (response.statusCode == 200) {
      _notification = NotificationText('Reset sent. Please check your inbox.', type: 'info');
      notifyListeners();
      return true;
    }

    return false;
  }

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setInt('user_id', apiResponse['user_id']);
    await storage.setString('user_name', apiResponse['user_name']);
    await storage.setString('user_restaurant_name', apiResponse['user_restaurant_name']);
    await storage.setString('user_username', apiResponse['user_username']);
    await storage.setString('user_email', apiResponse['user_email']);
    await storage.setString('user_mobile', apiResponse['user_mobile']);
    await storage.setString('user_login_key', apiResponse['user_login_key']);
  }

  Future<String> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    print("1");
    String token = storage.getString('user_login_key');
    return token;
  }

  logOut([bool tokenExpired = false]) async {
    _status = Status.Unauthenticated;
    if (tokenExpired == true) {
      _notification = NotificationText('Session expired. Please log in again.', type: 'info');
    }
    notifyListeners();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }

}