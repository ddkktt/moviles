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