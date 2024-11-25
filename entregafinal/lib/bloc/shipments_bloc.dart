import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:shipments_repository/shipment_repo.dart';
import 'package:shipments_repository/src/models/shipment.dart';
import 'package:shipments_repository/firebase_shipment_repo.dart';
part 'shipments_event.dart';
part 'shipments_state.dart';

class ShipmentsBloc extends Bloc<ShipmentsEvent, ShipmentsState> {
  final ShipmentRepo  shipmentRepo = FirebaseShipmentRepo();

  ShipmentsBloc() : super(ShipmentsInitial()) {
    on<LoadShipmentsCounter>(
      (event, emit) async {      
        emit(ShipmentsInitial());
        await shipmentRepo.getShipments().then((s) => 
        emit(ShipmentsLoaded(shipments: s))
        );
      }
    );
    on<AddShipment>(
      (event, emit) {
        if (state is ShipmentsLoaded) {
          final state = this.state as ShipmentsLoaded;
          emit(
            ShipmentsLoaded(
              shipments: List.from(state.shipments)..add(event.shipment),
            ),
          );
        }
      }
    );
  }
}