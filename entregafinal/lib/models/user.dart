import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entregafinal/models/address.dart';

class User {
  int id;
  String name;
  String email;
  String role; // 'admin', 'customer', 'provider', 'driver'
  String? phoneNumber;
  Address? address;



  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phoneNumber,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] as String,
      email: json['email'] as String,
      role:  json['role'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }

  factory User.fromDB(Map<String, dynamic> json) {
    final addrs = FirebaseFirestore.instance.collection('/Address');

    return User(
      id: json['id'],
      name: json['name'] as String,
      email: json['email'] as String,
      role:  json['role'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] != null
          ? Address.fromDB(json['address'].data)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'address': address?.toJson(),
    };
  }
}