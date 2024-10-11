import 'package:entregafinal/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
        appBar: AppBar(title: const Text("Perfil")),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 24),
                _buildEditProfileButton(),
                const SizedBox(height: 24),
                _buildPersonalInfo(),
              ],
            ),
          ),
      );
  }

  Widget _buildProfileHeader() {
  
    return Builder(
      builder: (context) {
        return Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(''),
              ),
              const SizedBox(height: 16),
              const Text(
                'Nombre Usuario',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'usuario@email.com',
                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildEditProfileButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement edit profile action
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Editar Perfil'),
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Información Personal',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildInfoItem('Teléfono', '+1234567890'),
        _buildInfoItem('Dirección', 'Calle Principal 123'),
        _buildInfoItem('Ciudad', 'Ciudad Ejemplo'),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
