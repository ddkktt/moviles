import 'package:entregafinal/auth/auth_provider.dart';
import 'package:entregafinal/screens/admin_packages_list.dart';
import 'package:entregafinal/screens/home.dart';
import 'package:entregafinal/screens/package_list.dart';
import 'package:entregafinal/screens/profile.dart';
import 'package:entregafinal/screens/scanner.dart';
import 'package:entregafinal/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  final titles = ['Inicio', 'Paquetes', 'Configuración', 'Escanear', 'Modo Dios'];
  final screens = [const HomeScreen(), const PackageListScreen(), const SettingsScreen(), const ScannerScreen(), const AdminPackagesListScreen()];
  
  // Methods
  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email;
    final bool isAdmin = Provider.of<RolesProvider>(context).isAdmin(email);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              titles[currentScreen], 
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        // title: Center(
        //   child: Text(
        //     titles[currentScreen], 
        //     style: const TextStyle(
        //       fontWeight: FontWeight.bold
        //     ),
        //   ),
        // ),
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
        destinations:[
          const NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          const NavigationDestination(
            icon: Badge(
              label: Text("1"),//TODO
              child: Icon(Icons.apps),
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
        ] + (isAdmin? [const NavigationDestination(icon: Icon(Icons.admin_panel_settings), label: "admin")] : [])
      ),
    );
  }
}