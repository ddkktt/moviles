import 'package:entregafinal/widgets/delivery_details.dart';
import 'package:flutter/material.dart';

class PackageDataScreen extends StatelessWidget {
  final delivery;


  const PackageDataScreen({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del paquete'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.close),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ],
      ),
      body: DeliveryDetails(delivery: delivery),
    );
  }
}