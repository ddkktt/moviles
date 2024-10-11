import 'package:entregafinal/models/user.dart';

class Shipment {
  String trackingNumber;
  User sender;
  User recipient;
  String packageInfo;
  DateTime? deliveryDate;
  String status; // 'Nuevo', 'Enviado', 'En Proceso de Entrega', 'Entregado', 'Cancelado', 'Perdido'

  Shipment({
    required this.trackingNumber,
    required this.sender,
    required this.recipient,
    required this.packageInfo,
    this.deliveryDate,
    required this.status
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      trackingNumber: json['trackingNumber'] as String,
      sender: User.fromJson(json['sender'] as Map<String, dynamic>),
      recipient: User.fromJson(json['recipient'] as Map<String, dynamic>),
      packageInfo: json['packageInfo'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'] as String)
          : null,
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackingNumber': trackingNumber,
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'packageInfo': packageInfo,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'status': status,
    };
  }
}