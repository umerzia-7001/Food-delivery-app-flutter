import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String tokens;
  String userId;
  DateTime _expiresIn = DateTime.now();
  bool _isAuth = false;
  Timer _authTimer = Timer(Duration(seconds: 60), () {});

  Auth({required this.tokens, required this.userId});

  // bool get isAuthenticated {
  //   // getting token to see if user logged in or not
  //   if( _token != null){
  //     _isAuth = true;
  //     return true;
  //   }
  //   return false;
  // }
  bool get isAuthenticated => _isAuth;

  set isAuthenticated(bool isAuth) {
    if (tokens != null) {
      _isAuth = isAuth;
      notifyListeners();
    }
  }

  bool get authenticated {
    return tokens != null;
  }

  String get token {
    // checking if token is valid w.r.t date
    if (_expiresIn != null &&
        _expiresIn.isAfter(DateTime.now()) &&
        tokens != null) {
      return tokens;
    }
    return tokens;
  }

  // logout function
  Future<void> logout() async {
    isAuthenticated = false;
    tokens = '';
    userId = '';
    _expiresIn = DateTime.now();
    if (_authTimer != null) {
      _authTimer.cancel();
      // _authTimer = null;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlMethod) async {
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlMethod?key=AIzaSyDsDl18BsKzoFcaaxYo8qzO2rvs7nSGyQQ');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        print(responseData['error']['message'].toString());
        throw HttpException(responseData['error']['message']);
      }

      tokens = responseData['idToken'];
      userId = responseData['localId'];
      _expiresIn = DateTime.now().add(
        // response also has a expiry date for token
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      print('hello');
      print(userId);
      print(tokens);

      isAuthenticated = true;
      notifyListeners();

      //_autoLogout();

      //saving user auth state in preferences
      final pref = await SharedPreferences.getInstance();
      final user = json.encode(
        {
          'token': tokens,
          'userId': userId,
          'expiryDate': _expiresIn.toIso8601String(),
        },
      );
      pref.setString('user', user);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String? email, String? password) async {
    return _authenticate(email!, password!, 'signupNewUser');
  }

  Future<void> logIn(String? email, String? password) async {
    return _authenticate(email!, password!, 'verifyPassword');
  }

  void _autoLogout() {}
}
