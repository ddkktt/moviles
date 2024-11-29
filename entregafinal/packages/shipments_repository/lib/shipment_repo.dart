import 'package:shipments_repository/src/models/shipment.dart';

abstract class ShipmentRepo {
  Future<List<Shipment>> getShipments();
  Future<void> updateShipmentStatus(int trackingNumber);
  Future<void> deleteShipment(int trackingNumber);
}
