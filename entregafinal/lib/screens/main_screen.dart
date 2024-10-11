import 'package:entregafinal/data/data_provider.dart';
import 'package:entregafinal/screens/home.dart';
import 'package:entregafinal/screens/packageList.dart';
import 'package:entregafinal/screens/profile.dart';
import 'package:entregafinal/screens/scanner.dart';
import 'package:entregafinal/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  final titles = ['Inicio', 'Paquetes', 'Configuración', 'Escanear'];
  final screens = [const HomeScreen(), const PackageListScreen(), const SettingsScreen(), const ScannerScreen()];

  // Methods
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            titles[currentScreen], 
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              }, 
              icon: const Icon(Icons.account_circle, color: Colors.blue,)),
          )
        ]
      ),
      body: screens[currentScreen],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
        },
        destinations:[
          const NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text("${Provider.of<DataProvider>(context).getPendingDeliveriesCount()}"),
              child: const Icon(Icons.apps),
            ),
            label: 'Paquetes'
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Config'

          ),
          const NavigationDestination(
            icon: Icon(Icons.camera),
            label: 'Scan'
          ),
        ],
      ),
    );
  }
}