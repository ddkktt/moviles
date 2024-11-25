import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shipments_repository/shipment_repo.dart';
import 'package:shipments_repository/src/entities/shipment_entity.dart';
import 'package:shipments_repository/src/models/shipment.dart';

class FirebaseShipmentRepo implements ShipmentRepo{
  final shipmentsCol = FirebaseFirestore.instance.collection('/Shipments');

  @override
  Future<List<Shipment>> getShipments() {
    try {
      return shipmentsCol.get().then((res) =>
        res.docs.map((doc) => Shipment.fromEntity(ShipmentEntity.fromDocument(doc.data()))
        ).toList()
      );
    } catch(e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // List<Shipment> list = [];
  // for (var doc in shipments.docs) {
  //   var jdoc = doc.data();
  //   jdoc['sender'] = users.docs.firstWhere((doc)=>doc.id==jdoc['sender'].id).data();
  //   jdoc['driver'] = users.docs.firstWhere((doc)=>doc.id==jdoc['driver'].id).data();
  //   jdoc['recipient'] = users.docs.firstWhere((doc)=>doc.id==jdoc['recipient'].id).data();
  //   jdoc['recipient']['address'] = addrs.docs.firstWhere((doc)=>doc.id==jdoc['recipient']['address'].id).data();
  //   list.add(Shipment.fromJson(jdoc));
  // }
  // return list;
  // }

}