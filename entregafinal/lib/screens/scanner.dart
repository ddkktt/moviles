import 'package:flutter/material.dart';
import 'package:flutter_scan_barcode/flutter_barcode_scan.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _scanResult = 'No scan result';

  Future<void> _scanQRCode() async {
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
                onTap: _scanQRCode, // Inicia el escaneo cuando se toque el contenedor
                child: Center(
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
            SizedBox(height: 10),
            Text(
              'Scan Result: $_scanResult',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
