import 'package:flutter/material.dart';

class AdminPackagesListScreen extends StatefulWidget{
  const AdminPackagesListScreen({super.key});

  @override 
  State<AdminPackagesListScreen> createState() => _AdminPackagesListScreenState();
}

class _AdminPackagesListScreenState extends State<AdminPackagesListScreen>{
  @override 
  Widget build(BuildContext context) {
    return const Text("admin package list");
  }
}