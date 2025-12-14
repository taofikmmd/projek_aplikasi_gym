import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pengaturan Latihan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: const [
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Jenis Kelamin'),
          ),
          Divider(height: 1),
          ListTile(leading: Icon(Icons.music_note), title: Text('Musik')),
        ],
      ),
    );
  }
}
