import 'package:flutter/material.dart';

class RolesProvider with ChangeNotifier {
  final String? adminUser = "iteso@iteso.iteso";

  bool isAdmin(String? username) {
    return (username == adminUser ? true : false);
  }
}