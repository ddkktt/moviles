import 'package:entregafinal/data/data_provider.dart';
import 'package:entregafinal/widgets/delivery_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  

  @override
  Widget build(BuildContext context) {
    final shipments = Provider.of<DataProvider>(context).getTodaysShipmentsForMe();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shipments.length,
            itemBuilder: (context, index) {
              return DeliveryCard(delivery: shipments[index]);
            },
          ),
        ),
      ],
    );
  }
}
