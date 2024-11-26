import 'package:shipments_repository/src/models/shipment.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:map_launcher/map_launcher.dart';

class DeliveryDetails extends StatelessWidget {
  final Shipment delivery;

  const DeliveryDetails({super.key, required this.delivery});

  goToMap() async {
    final availableMaps = await MapLauncher.installedMaps;
    final googleMaps = availableMaps.firstWhere(
      (map) => map.mapType == MapType.google,
      orElse: () => availableMaps.first, // Fallback to first available map if Google Maps isn't installed
    );

    await googleMaps.showDirections(
      destination: Coords(delivery.loc[0], delivery.loc[1]),
      destinationTitle: delivery.recipient,
      directionsMode: DirectionsMode.driving,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMap(delivery),
        _buildPackageDetails(),
        const Spacer(),
        _buildNavigateButton(context),
      ],
    );
  }

  Widget _buildMap(Shipment delivery) {
    return Container(
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
        child: GestureDetector(
          onTap: goToMap,
          child: google_maps.GoogleMap(
            initialCameraPosition: google_maps.CameraPosition(
              target: google_maps.LatLng(
                delivery.loc[0],
                delivery.loc[1],
              ),
              zoom: 15,
            ),
            markers: {
              google_maps.Marker(
                markerId: const google_maps.MarkerId('destination'),
                position: google_maps.LatLng(
                  delivery.loc[0],
                  delivery.loc[1],
                ),
                infoWindow: google_maps.InfoWindow(title: delivery.recipient),
              ),
            },
            liteModeEnabled: true,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            zoomGesturesEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
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
          _buildDetailRow(Icons.location_on_outlined, 'Destino final:', delivery.address),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.person_outline, 'A quien entregar:', delivery.recipient),
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

  Widget _buildNavigateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: goToMap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined),
            SizedBox(width: 8),
            Text('Iniciar Entrega', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}