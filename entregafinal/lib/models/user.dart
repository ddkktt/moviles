import 'package:entregafinal/models/address.dart';

class User {
  String id;
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
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role:  json['role'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
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