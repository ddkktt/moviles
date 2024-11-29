import 'package:entregafinal/bloc/shipments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scan_barcode/flutter_barcode_scan.dart';

// Future<void> _qrUpdate(AddTodo event, Emitter<TodoState> emit) async {

// }

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _scanResult = 'No scan result';
  Future<void> _scanQRCode(context) async {
    try {
      final result = await FlutterBarcodeScan.scanBarcode(
        "#ff6666", // color del borde del escáner
        "Cancelar", // texto del botón de cancelación
        true, // muestra el icono de flash
        ScanMode.QR, // escaneo en modo QR
      );

      if (result != "-1") {
        setState(() {
          _scanResult = result; // El resultado escaneado
        });
      } else {
        setState(() {
          _scanResult = "Escaneo cancelado"; // Si el escaneo es cancelado
        });
      }
    } catch (e) {
      setState(() {
        _scanResult = "Error: $e"; // Si ocurre un error en el escaneo
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentsBloc, ShipmentsState>(
        builder: (context, state) {
      if (_scanResult != "No scan result" &&
          _scanResult != "Escaneo cancelado") {
        context.read<ShipmentsBloc>().add(UpdateShipmentStatus(_scanResult));
      }
      return Center(
        child: Container(
          width: 300, // Puedes ajustar el tamaño del contenedor
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _scanQRCode(
                      context), // Inicia el escaneo cuando se toque el contenedor
                  child: const Center(
                    child: Text(
                      'Scan QR Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Scan Result: $_scanResult',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    });
  }
}
