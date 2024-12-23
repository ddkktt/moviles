import 'package:flutter/material.dart';
import 'package:entregafinal/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:entregafinal/bloc/shipments_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocBuilder<ShipmentsBloc, ShipmentsState>(
          builder: (context, state) {
            int enRepartoPackages = 0;
            
            if (state is ShipmentsLoaded) {
              enRepartoPackages = state.shipments
                  .where((shipment) => shipment.status.toLowerCase() == 'en reparto')
                  .length;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "¡Bienvenido!",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 400,
                  child: Card(
                    semanticContainer: true,
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getCurrentDate(),
                          style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        Column(
                          children: [
        
                            const SizedBox(height: 8),
                            Text(
                              "tienes $enRepartoPackages paquete pendiente",
                              style: TextStyle(
                                fontSize: 20,
                                foreground: Paint()
                                  ..strokeWidth = 4
                                  ..color = Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Icon(
                  Icons.local_shipping,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(initialScreen: 1),
                          ),
                        );
                      },
                      child: const Text("Ver Paquetes"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(initialScreen: 2),
                          ),
                        );
                      },
                      child: const Text("Scan QR"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

String getCurrentDate() {
  var date = DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  return formattedDate;
}