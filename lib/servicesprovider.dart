// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bronesystem/authprovider.dart';

import 'models/service.dart';
import 'package:http/http.dart' as http;
import 'vars.dart';

enum ServicesStatus { loading, cached, ready }

class ServicesProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  ServicesStatus status = ServicesStatus.loading;
  List<Service> services = [];

  ServicesProvider({required this.authProvider}) {
    loadData();
    downloadData();
  }

  loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String servicesData = await prefs.getString('services') ?? "";
    if (servicesData.isEmpty) {
      return;
    }

    services = (json.decode(servicesData) as List)
        .map((i) => Service.fromJson(i))
        .toList();
    status = ServicesStatus.cached;
    notifyListeners();
  }

  downloadData() async {
    try {
      var response = await http.get(servicesUri,
          headers: {"Authorization": authProvider.user!.token});

      services = (json.decode(response.body) as List)
          .map((i) => Service.fromMap(i))
          .toList();
    } catch (e) {
      print('Error caught: $e');
    }

    status = ServicesStatus.ready;
    notifyListeners();
  }
}
