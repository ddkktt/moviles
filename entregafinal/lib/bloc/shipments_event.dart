part of 'shipments_bloc.dart';

abstract class ShipmentsEvent extends Equatable{
  const ShipmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadShipmentsCounter extends ShipmentsEvent {}

class AddShipment extends ShipmentsEvent{
  final Shipment shipment;

  const AddShipment(this.shipment);

  @override
  List<Object> get props => [shipment];
}

class DeleteShipment extends ShipmentsEvent{
  final int trackingNumber;

  const DeleteShipment(this.trackingNumber);

}

class UpdateShipment extends ShipmentsEvent{
  final Shipment shipment;
  final int trackingNumber;


  const UpdateShipment(this.shipment, this.trackingNumber);

  @override
  List<Object> get props => [shipment];
}

class UpdateShipmentStatus extends ShipmentsEvent{
  final String trackingNumber;


  const UpdateShipmentStatus(this.trackingNumber);

}