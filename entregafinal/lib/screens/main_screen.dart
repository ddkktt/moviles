import 'package:entregafinal/screens/home.dart';
import 'package:entregafinal/screens/package_list.dart';
import 'package:entregafinal/screens/profile.dart';
import 'package:entregafinal/screens/settings.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  final titles = ['Inicio', 'Paquetes', 'Configuración'];
  final screens = [const HomeScreen(), const PackageListScreen(), const SettingsScreen()];

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
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