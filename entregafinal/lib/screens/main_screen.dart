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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:entregafinal/bloc/shipments_bloc.dart';

class MainScreen extends StatefulWidget {
  final int initialScreen;

  const MainScreen({super.key, this.initialScreen = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentScreen;
  
  final titles = ['Inicio', 'Paquetes', 'Escanear', 'Configuración', 'Modo Dios'];
  final screens = [
    const HomeScreen(),
    const PackageListScreen(),
    const ScannerScreen(),
    const SettingsScreen(),
    const AdminPackagesListScreen()
  ];

  @override
  void initState() {
    super.initState();
    currentScreen = widget.initialScreen;
  }

  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email;
    final bool isAdmin = Provider.of<RolesProvider>(context).isAdmin(email);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titles[currentScreen],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              icon: const Icon(Icons.account_circle, color: Colors.white),
            ),
          ),
        ],
      ),
      body: screens[currentScreen],
      bottomNavigationBar: BlocBuilder<ShipmentsBloc, ShipmentsState>(
        builder: (context, state) {
          int enRepartoPackages = 0;
          
          if (state is ShipmentsLoaded) {
            enRepartoPackages = state.shipments
                .where((shipment) => shipment.status.toLowerCase() == 'en reparto')
                .length;
          }

          return NavigationBar(
            selectedIndex: currentScreen,
            onDestinationSelected: (index) {
              setState(() {
                currentScreen = index;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text(enRepartoPackages.toString()),
                  child: const Icon(Icons.apps),
                ),
                label: 'Paquetes',
              ),
              const NavigationDestination(
                icon: Icon(Icons.camera),
                label: 'Scan',
              ),
              const NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Config',
              ),
            ] +
                (isAdmin
                    ? [const NavigationDestination(icon: Icon(Icons.admin_panel_settings), label: "Admin")]
                    : []),
          );
        },
      ),
    );
  }
}