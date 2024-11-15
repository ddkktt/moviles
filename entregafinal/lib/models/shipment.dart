import 'package:entregafinal/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shipment {
  int trackingNumber;
  User sender;
  User recipient;
  User? driver;
  String packageInfo;
  DateTime? deliveryDate;
  String status; // 'Nuevo', 'Enviado', 'En Proceso de Entrega', 'Entregado', 'Cancelado', 'Perdido'

  Shipment({
    required this.trackingNumber,
    required this.sender,
    required this.recipient,
    this.driver,
    required this.packageInfo,
    this.deliveryDate,
    required this.status
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {

    return Shipment(
      trackingNumber: json['trackingNumber'],
      sender: User.fromJson(json['sender'] as Map<String, dynamic>),
      recipient: User.fromJson(json['recipient'] as Map<String, dynamic>),
      driver: json['driver'] != null ? User.fromJson(json['driver'] as Map<String, dynamic>): null,
      packageInfo: json['packageInfo'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'] as String)
          : null,
      status: json['status']
    );
  }

  factory Shipment.fromDB(Map<String, dynamic> json) {

    return Shipment(
      trackingNumber: json['trackingNumber'],
      sender: User.fromDB(json['sender'].data),
      //sender: await User.fromDB((await json['sender'].get()).data()),
      //recipient: null, //await User.fromDB((await json['recipient'].get()).data()),
      recipient: User.fromDB(json['recepient'].data), //await User.fromDB((await json['recipient'].get()).data()),
      driver: null, //json['driver'] != null ? await User.fromDB((await json['driver'].get()).data()) : null,
      packageInfo: json['packageInfo'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'] as String)
          : null,
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackingNumber': trackingNumber.toInt(),
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'packageInfo': packageInfo,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'status': status,
    };
  }
}

Future<List<Shipment>> getShipments() async {
  final shipments = await FirebaseFirestore.instance.collection('/Shipments').get();
  final users = await FirebaseFirestore.instance.collection('/Users').get();
  final addrs = await FirebaseFirestore.instance.collection('/Address').get();
  List<Shipment> list = [];
  shipments.docs.forEach( (doc) {
    var jdoc = doc.data();
    jdoc['sender'] = users.docs.firstWhere((doc)=>doc.id==jdoc['sender'].id).data();
    jdoc['driver'] = users.docs.firstWhere((doc)=>doc.id==jdoc['driver'].id).data();
    jdoc['recipient'] = users.docs.firstWhere((doc)=>doc.id==jdoc['recipient'].id).data();
    jdoc['recipient']['address'] = addrs.docs.firstWhere((doc)=>doc.id==jdoc['recipient']['address'].id).data();
    list.add(Shipment.fromJson(jdoc));
  });
  return list;
 
}