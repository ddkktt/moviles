part of 'shipments_bloc.dart';

abstract class ShipmentsState extends Equatable {
  const ShipmentsState();

  @override
  List<Object> get props => [];
}

class ShipmentsInitial extends ShipmentsState {}

final class ShipmentsLoaded extends ShipmentsState {
  final List<Shipment> shipments;

  const ShipmentsLoaded({required this.shipments});
}