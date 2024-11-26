import 'package:entregafinal/bloc/shipments_bloc.dart';
import 'package:entregafinal/widgets/delivery_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  String _selectedFilter = 'all'; // 

  Future<void> _onRefresh() async {
    context.read<ShipmentsBloc>().add(LoadShipmentsCounter());
    await Future.delayed(const Duration(seconds: 1));
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Todos'),
            selected: _selectedFilter == 'all',
            onSelected: (selected) {
              setState(() {
                _selectedFilter = 'all';
              });
            },
            backgroundColor: Colors.grey[200],
            selectedColor: Colors.blue[100],
            checkmarkColor: Colors.blue,
            labelStyle: TextStyle(
              color: _selectedFilter == 'all' ? Colors.blue : Colors.black87,
              fontWeight: _selectedFilter == 'all' ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('En Reparto'),
            selected: _selectedFilter == 'en_reparto',
            onSelected: (selected) {
              setState(() {
                _selectedFilter = 'en_reparto';
              });
            },
            backgroundColor: Colors.grey[200],
            selectedColor: Colors.blue[100],
            checkmarkColor: Colors.blue,
            labelStyle: TextStyle(
              color: _selectedFilter == 'en_reparto' ? Colors.blue : Colors.black87,
              fontWeight: _selectedFilter == 'en_reparto' ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> _getFilteredShipments(List<dynamic> shipments) {
    if (_selectedFilter == 'all') {
      return shipments;
    }
    return shipments.where((shipment) => 
      shipment.status.toLowerCase() == 'en reparto'
    ).toList();
  }

  Widget _buildShipmentsList(List<dynamic> shipments) {
    final filteredShipments = _getFilteredShipments(shipments);
    
    if (filteredShipments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay paquetes ${_selectedFilter == "en_reparto" ? "en reparto" : ""}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: filteredShipments.length,
      itemBuilder: (BuildContext context, int index) {     
        return DeliveryCard(delivery: filteredShipments[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentsBloc, ShipmentsState>(
      builder: (context, state) {
        if (state is ShipmentsInitial) {
          return const Center(
            child: CircularProgressIndicator()
          );
        } else if (state is ShipmentsLoaded) {
          return Column(
            children: [
              _buildFilterChips(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: _buildShipmentsList(state.shipments),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator()
        );
      }
    );
  }
}