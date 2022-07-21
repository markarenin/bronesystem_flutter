import 'dart:convert';

import 'package:bronesystem/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

const baseUrl = "http://10.0.2.2:8000";
const loginUrl = "$baseUrl/api/login/";

enum Status { notLoggedIn, authenticating, loggedIn }

class AuthProvider extends ChangeNotifier {
  User? user;

  Status _loggedInStatus = Status.notLoggedIn;

  Status get status => _loggedInStatus;

  login(String name, int apartment) async {
    final Map<String, dynamic> loginData = {'name': name, 'apartment': apartment};

    post(
      Uri.parse(loginUrl),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    ).then((response) {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        user = User.fromJson(responseData);
        _loggedInStatus = Status.authenticating;
        notifyListeners();
        _saveSession(user!);
      }
      else {
        print(response.statusCode);
        _loggedInStatus = Status.notLoggedIn;
        notifyListeners();
      }
    })
    .catchError((onError) {
      print(onError);
    });

  }

  void _saveSession(User user) async {
    final storage = new FlutterSecureStorage();
    Map<String, dynamic> userData = user.toMap();
    await storage.write(key: 'user', value: json.encode(userData));
    _loggedInStatus = Status.loggedIn;
    notifyListeners();
  }

  AuthProvider() {
    final storage = new FlutterSecureStorage();
    Future<String?> storageData = storage.read(key: 'user');
    storageData.then((value) {
      if (value != null) {
        Map<String, dynamic> userData = json.decode(value);
        user = User.fromJson(userData);
        _loggedInStatus = Status.loggedIn;
        notifyListeners();
      }
    });
  }
}
