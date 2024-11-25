import 'package:equatable/equatable.dart';

class ShipmentEntity extends Equatable{
  final int trackingNumber;
  final String sender;
  final String recipient;
  final String driver;
  final String packageInfo;
  final DateTime deliveryDate;
  final String status;
  final String address;
  final List<double> loc;

  const ShipmentEntity({
    required this.trackingNumber,
    required this.sender,
    required this.recipient,
    required this.driver,
    required this.packageInfo,
    required this.deliveryDate,
    required this.status,
    required this.address,
    required this.loc,
  });

  Map<String, Object?> toDocument() {
    return{
      'trackingNumber': trackingNumber,
      'sender': sender,
      'recipient': recipient,
      'driver': driver,
      'packageInfo': packageInfo,
      'deliveryDate': deliveryDate,
      'status': status,
      'address': address,
      'loc': loc,
    };
  }

  static ShipmentEntity fromDocument(Map<String, dynamic> doc) {
    return ShipmentEntity(
      trackingNumber: doc['trackingNumber'], 
      sender: doc['sender'], 
      recipient: doc['recipient'], 
      driver: doc['driver'], 
      packageInfo: doc['packageInfo'], 
      deliveryDate: doc['deliveryDate'].toDate(), 
      status: doc['status'],
      address: doc['address'],
      loc: [doc['loc'][0],doc['loc'][1]],
    );
  }

  @override
  List<Object?> get props => [trackingNumber, sender, recipient, driver, packageInfo, deliveryDate, status, address, loc];
}