import 'package:entregafinal/data/dummy_data.dart';
import 'package:entregafinal/models/shipment.dart';
import 'package:entregafinal/models/user.dart';
import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  final List<User> _users = [];
  final List<Shipment> _shipments = [];

  DataProvider() {
    for (var user in dummyUsers) {
      _users.add(User.fromJson(user));
    }
    for (var shipment in dummyShipments) {
      _shipments.add(Shipment.fromJson(shipment));
    }
  }

  List<User> getAllUsers() {
    return _users;
  }

  List<Shipment> getTodaysShipmentsForMe() {
    return _shipments;
  }

  int getPendingDeliveriesCount() {
    return _shipments.length;
  }

  void setShipmentStatus(String trackingNumber, String newStatus) {
    final index = _shipments.indexWhere((shipment) => (
      shipment.trackingNumber == trackingNumber));
    if (index == -1) return;
   
    _shipments[index].status = newStatus;
    }
}
