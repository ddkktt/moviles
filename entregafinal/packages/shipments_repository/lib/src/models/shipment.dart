import 'package:equatable/equatable.dart';
import 'package:shipments_repository/src/entities/entities.dart';

class Shipment extends Equatable{
  final int trackingNumber;
  final String sender;
  final String recipient;
  final String driver;
  final String packageInfo;
  final DateTime deliveryDate;
  final String status; // 'Nuevo', 'Enviado', 'En Proceso de Entrega', 'Entregado', 'Cancelado', 'Perdido'
  final String address;
  final List<double> loc;

  const Shipment({
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

  @override
  List<Object?> get props => [trackingNumber, sender, recipient, driver, packageInfo, deliveryDate, status, address, loc];

  // final empty = Shipment(
  //   trackingNumber: 0,
  //   packageInfo: "",
  //   status: "none",
  //   deliveryDate: DateTime.now(),
  //   sender: "",
  //   recipient: "",
  //   driver: ""
  // );

  Shipment copyWith({
    int? trackingNumber,
    String? sender,
    String? recipient,
    String? driver,
    String? packageInfo,
    DateTime? deliveryDate,
    String? status,
    String? address,
    List<double>? loc,
  }) {
    return Shipment(
      trackingNumber: trackingNumber ?? this.trackingNumber,
      sender: sender ?? this.sender,
      recipient: recipient ?? this.recipient,
      driver: driver ?? this.driver,
      packageInfo: packageInfo ?? this.packageInfo,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      status: status ?? this.status,
      address: address ?? this.address,
      loc: loc ?? this.loc,

    );
  }

  ShipmentEntity toEntity() {
    return ShipmentEntity(
      trackingNumber: trackingNumber,
      sender: sender,
      recipient: recipient,
      driver: driver,
      packageInfo: packageInfo,
      deliveryDate: deliveryDate,
      status: status,
      address: address,
      loc: loc,
    );
  }

  static Shipment fromEntity (ShipmentEntity entity) {
    return Shipment(
      trackingNumber: entity.trackingNumber, 
      sender: entity.sender, 
      recipient: entity.recipient, 
      driver: entity.driver, 
      packageInfo: entity.packageInfo, 
      deliveryDate: entity.deliveryDate, 
      status: entity.status,
      address: entity.address,
      loc: entity.loc,
    );
  }


}