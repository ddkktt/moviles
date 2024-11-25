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
  Future<void> _onRefresh() async {
    // Using the correct LoadShipmentsCounter event
    context.read<ShipmentsBloc>().add(LoadShipmentsCounter());
    // Wait briefly for the refresh to complete
    await Future.delayed(const Duration(seconds: 1));
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
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.shipments.length,
              itemBuilder: (BuildContext context, int index) {     
                return DeliveryCard(delivery: state.shipments[index]);
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator()
        );
      }
    );
  }
}