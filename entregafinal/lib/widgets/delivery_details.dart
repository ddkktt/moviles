import 'package:entregafinal/auth/auth_provider.dart';
import 'package:entregafinal/screens/package_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shipments_repository/src/models/shipment.dart';
import 'package:entregafinal/bloc/shipments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:map_launcher/map_launcher.dart';

class DeliveryDetails extends StatefulWidget {
  final Shipment delivery;

  const DeliveryDetails({super.key, required this.delivery});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  bool isEditing = false;
  bool _deleted = false;
  String status = 'En Reparto';
  
  @override
  void initState() {
    super.initState();
    status = widget.delivery.status;
  }

  @override
  Widget build(BuildContext context) { 
    return BlocBuilder<ShipmentsBloc, ShipmentsState>(
      builder: (context, state) {
        if (_deleted) {
          debugPrint("delte product");//context.read<ShipmentsBloc>().add(UpdateShipmentStatus(_scanResult));
        } 
        return Column(
          children: [
            _buildMap(),
            _buildPackageDetails(),
            const Spacer(),
            _buildBottomButtons(),
          ],
        );
      }
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
          _buildStatusField(),
          const SizedBox(height: 12),
          _buildAddressField(),
          const SizedBox(height: 12),
          _buildRecipientField(),
        ],
      ),
    );
  }

  Widget _buildStatusField() {
    return Row(
      children: [
        const Icon(Icons.info_outline, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        const Text(
          'Status del paquete:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: isEditing
              ? DropdownButton<String>(
                  value: status,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'Nuevo', child: Text('Nuevo')),
                    DropdownMenuItem(value: 'En Reparto', child: Text('En Reparto')),
                    DropdownMenuItem(value: 'Entregado', child: Text('Entregado')),
                    DropdownMenuItem(value: 'Cancelado', child: Text('Cancelado')),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => status = value);
                    }
                  },
                )
              : Text(status, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildAddressField() {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: isEditing
              ? TextField(
                  decoration: const InputDecoration(
                    labelText: 'Destino final',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: widget.delivery.address),
                )
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      const TextSpan(
                        text: 'Destino final: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: widget.delivery.address),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildRecipientField() {
    return Row(
      children: [
        const Icon(Icons.person_outline, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: isEditing
              ? TextField(
                  decoration: const InputDecoration(
                    labelText: 'A quien entregar',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: widget.delivery.recipient),
                )
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      const TextSpan(
                        text: 'A quien entregar: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: widget.delivery.recipient),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildMap() {
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
        child: google_maps.GoogleMap(
          initialCameraPosition: google_maps.CameraPosition(
            target: google_maps.LatLng(
              widget.delivery.loc[0],
              widget.delivery.loc[1],
            ),
            zoom: 15,
          ),
          markers: {
            google_maps.Marker(
              markerId: const google_maps.MarkerId('destination'),
              position: google_maps.LatLng(
                widget.delivery.loc[0],
                widget.delivery.loc[1],
              ),
              infoWindow: google_maps.InfoWindow(title: widget.delivery.recipient),
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
    );
  }

  Widget _buildBottomButtons() {
    
    String? email = FirebaseAuth.instance.currentUser?.email;
    final bool isAdmin = Provider.of<RolesProvider>(context).isAdmin(email);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (isEditing)
            ElevatedButton(
              onPressed: () {
                // Here you would typically save the changes
                setState(() => isEditing = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cambios guardados'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save),
                  SizedBox(width: 8),
                  Text('Guardar cambios', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          const SizedBox(height: 8),
          (isAdmin ? ElevatedButton(
            onPressed: () {
              setState(() => isEditing = !isEditing);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isEditing ? Colors.red : Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isEditing ? Icons.close : Icons.edit),
                const SizedBox(width: 8),
                Text(
                  isEditing ? 'Cancelar' : 'Editar detalles',
                  style: const TextStyle(fontSize: 18),
                )
              ]
            ),
          ): const SizedBox.shrink()),
          const SizedBox(height: 8),
          (!isAdmin ? ElevatedButton(
            onPressed: () async {
              final availableMaps = await MapLauncher.installedMaps;
              final googleMaps = availableMaps.firstWhere(
                (map) => map.mapType == MapType.google,
                orElse: () => availableMaps.first,
              );

              await googleMaps.showDirections(
                destination: Coords(
                  widget.delivery.loc[0],
                  widget.delivery.loc[1],
                ),
                destinationTitle: widget.delivery.recipient,
                directionsMode: DirectionsMode.driving,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_outlined),
                SizedBox(width: 8),
                Text('Iniciar ruta', style: TextStyle(fontSize: 18)),
              ],
            ),
          ): 
          ElevatedButton(
            onPressed: () => {
              setState(() {
                Navigator.of(context).pop();
                _deleted = true;
              })
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_outlined),
                SizedBox(width: 8),
                Text('Delete Shipment', style: TextStyle(fontSize: 18)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}