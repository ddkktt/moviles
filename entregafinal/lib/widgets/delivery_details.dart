import 'package:entregafinal/models/shipment.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class DeliveryDetails extends StatelessWidget {
  final delivery;

  const DeliveryDetails({super.key, required this.delivery});

  goToMap() async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
            coords: Coords(delivery.recipient.address!.lat!, delivery.recipient.address!.lng!),
            title: delivery.recipient.name,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _buildMap(delivery),
          _buildPackageDetails(),
          const Spacer(),
          _buildDeliveredButton(context),
        ],
    );
  }

  // Widget _buildMiniMap(Shipment delivery) {
  //   GoogleMap(
  //   liteModeEnabled: true,     // the required field
  //   mapToolbarEnabled: false,  // to disable buttons
  //   onTap: (latLng) =>         // onTap handler
  //       goToMap, 
  //   );
  // }

  Widget _buildMap(Shipment delivery) {
    return ElevatedButton(
      onPressed: goToMap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: const Center(
            child: Text('Mini mapa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(Icons.info_outline, 'Status del paquete:', delivery.status),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.location_on_outlined, 'Destino final:', delivery.recipient.address?.formattedAddress),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.person_outline, 'A quien entregar:', delivery.recipient.name),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveredButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement delivery confirmation logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Paquete marcado como entregado')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline),
            SizedBox(width: 8),
            Text('Entregado', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
