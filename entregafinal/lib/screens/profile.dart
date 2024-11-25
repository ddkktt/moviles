import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:entregafinal/auth/auth_gate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profilePhoto; // Variable para almacenar la foto de perfil
  final ImagePicker _picker = ImagePicker();
  late Directory _photoDir;

  @override
  void initState() {
    super.initState();
    _initPhotoDir();
  }

  Future<void> _initPhotoDir() async {
    final directory = await getApplicationDocumentsDirectory();
    _photoDir = Directory('${directory.path}/MyPhotos');
    if (!(await _photoDir.exists())) {
      await _photoDir.create();
    }
    _loadLastPhoto();
  }

  Future<void> _loadLastPhoto() async {
    final files = _photoDir
        .listSync()
        .whereType<File>()
        .toList()
      ..sort((a, b) => b.path.compareTo(a.path)); // Ordenar por nombre para obtener la última foto.
    if (files.isNotEmpty) {
      setState(() {
        _profilePhoto = files.first;
      });
    }
  }

  Future<void> _showPhotoOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto'),
                onTap: () {
                  Navigator.of(context).pop(); // Cerrar el modal
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar de la galería'),
                onTap: () {
                  Navigator.of(context).pop(); // Cerrar el modal
                  _selectPhotoFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final photoFile = File(pickedFile.path);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final newPhoto =
          await photoFile.copy('${_photoDir.path}/photo_$timestamp.jpg');
      setState(() {
        _profilePhoto = newPhoto;
      });
    }
  }

  Future<void> _selectPhotoFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final photoFile = File(pickedFile.path);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final newPhoto =
          await photoFile.copy('${_photoDir.path}/photo_$timestamp.jpg');
      setState(() {
        _profilePhoto = newPhoto;
      });
    }
  }

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
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthGate()),
                    (route) => false);
              },
              child: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _showPhotoOptions, // Mostrar opciones de foto (cámara o galería)
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _profilePhoto != null
                  ? FileImage(_profilePhoto!) // Muestra la foto personalizada
                  : const AssetImage('assets/default_avatar.png')
                      as ImageProvider, // Foto predeterminada
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nombre Usuario',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'usuario@email.com',
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implementar acción de editar perfil
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