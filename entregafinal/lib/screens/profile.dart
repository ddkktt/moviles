import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entregafinal/auth/auth_gate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profilePhoto;
  final ImagePicker _picker = ImagePicker();
  late Directory _photoDir;
  bool _isEditing = false;
  
  // Controllers for editing
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  
  // User data
  String _userName = 'Nombre Usuario';
  String _phone = '+1234567890';
  String _address = 'Calle Principal 123';
  String _city = 'Ciudad Ejemplo';

  @override
  void initState() {
    super.initState();
    _initPhotoDir();
    _loadUserData();
    _initControllers();
  }

  void _initControllers() {
    _nameController = TextEditingController(text: _userName);
    _phoneController = TextEditingController(text: _phone);
    _addressController = TextEditingController(text: _address);
    _cityController = TextEditingController(text: _city);
  }

  Future<void> _loadUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _userName = data['name'] ?? 'Nombre Usuario';
          _phone = data['phone'] ?? '+1234567890';
          _address = data['address'] ?? 'Calle Principal 123';
          _city = data['city'] ?? 'Ciudad Ejemplo';
          _initControllers();
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'city': _cityController.text,
      }, SetOptions(merge: true));

      setState(() {
        _userName = _nameController.text;
        _phone = _phoneController.text;
        _address = _addressController.text;
        _city = _cityController.text;
        _isEditing = false;
      });
    }
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
      ..sort((a, b) => b.path.compareTo(a.path));
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
                  Navigator.of(context).pop();
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar de la galería'),
                onTap: () {
                  Navigator.of(context).pop();
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
      final newPhoto = await photoFile.copy('${_photoDir.path}/photo_$timestamp.jpg');
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
      final newPhoto = await photoFile.copy('${_photoDir.path}/photo_$timestamp.jpg');
      setState(() {
        _profilePhoto = newPhoto;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildEditProfileButton(),
              const SizedBox(height: 24),
              _buildPersonalInfo(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const AuthGate()),
                        (route) => false);
                  }
                },
                child: const Text("Sign Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _showPhotoOptions,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _profilePhoto != null
                  ? FileImage(_profilePhoto!)
                  : const AssetImage('assets/images/photo_1.jpg') as ImageProvider,
            ),
          ),
          const SizedBox(height: 16),
          _isEditing
              ? TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Nombre',
                  ),
                )
              : Text(
                  _userName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
          Text(
            FirebaseAuth.instance.currentUser?.email ?? 'usuario@email.com',
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
        if (_isEditing) {
          _saveUserData();
        } else {
          setState(() {
            _isEditing = true;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(_isEditing ? 'Guardar Cambios' : 'Editar Perfil'),
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
        _buildInfoItem('Teléfono', _phone, _phoneController),
        _buildInfoItem('Dirección', _address, _addressController),
        _buildInfoItem('Ciudad', _city, _cityController),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: _isEditing
                ? TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Ingrese $label',
                    ),
                  )
                : Text(value),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}