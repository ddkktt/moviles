import 'package:entregafinal/models/shipment.dart';
import 'package:entregafinal/widgets/delivery_card.dart';
import 'package:flutter/material.dart';
class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  List<Shipment>? _shipments = null;

  _PackageListScreenState() {
    getShipments().then((shipments) {
      setState(() {
        //debugPrint(shipments == null ? "zero" : "uno");
        _shipments = shipments;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final shipments = Provider.of<DataProvider>(context).getTodaysShipmentsForMe();
    if (_shipments == null) {
      return const Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return ListView.builder(
      itemCount: _shipments?.length,
      itemBuilder: (context, index) => DeliveryCard(delivery: _shipments![index])
    );
    
    // return FutureBuilder(
    //   future: _shipments,
    //   builder: (BuildContext context, AsyncSnapshot<List<Shipment>?> snapshot) {
    //     ListView children;
    //     if (snapshot.hasData) {
    //       List<Shipment> singleShipment = snapshot.data as List<Shipment>;
    //       children = ListView.builder(
    //         itemCount: singleShipment.length,
    //         itemBuilder: (BuildContext context, int index) {     
    //           return DeliveryCard(delivery: singleShipment[index]);
    //         },
    //       );
    //     } else if (snapshot.hasError) {
    //       children = ListView.builder(
    //         itemCount: 1,
    //         itemBuilder: (BuildContext context, int index) {
    //           return const Icon(
    //             Icons.error_outline,
    //             color: Colors.red,
    //             size: 60,
    //           );
    //         }
    //       );
    //     } else {
    //       children = ListView.builder(
    //         itemCount: 1,
    //         itemBuilder: (BuildContext context, int index) {
    //           return const SizedBox(
    //             width: 60,
    //             height: 60,
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //       );
    //     }
    //     return Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [children],
    //       ),
    //     );
    //   }
    // );
  }
}
