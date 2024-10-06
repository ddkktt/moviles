import 'package:entregafinal/screens/home.dart';
import 'package:entregafinal/screens/packageList.dart';
import 'package:entregafinal/screens/settings.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  final titles = ['Inicio', 'Paquetes', 'Configuración'];
  final screens = [const HomeScreen(), const PackageListScreen(), SettingsScreen()];

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
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: null, 
              icon: Icon(Icons.account_circle, color: Colors.blue,)),
          )
        ]
      ),
      body: screens[currentScreen],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            this.currentScreen = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Inicio'
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('11'),
              child: Icon(Icons.apps),
            ),
            label: 'Paquetes'
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Config'
          ),
        ],
      ),
    );
  }
}