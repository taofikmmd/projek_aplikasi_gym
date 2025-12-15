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
        children: [
          const ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Jenis Kelamin'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          const Divider(height: 1),
          
          // --- MENU MUSIK (Hanya Informasi) ---
          ListTile(
            leading: const Icon(Icons.music_note, color: Colors.red),
            title: const Text('Musik Latihan'),
            subtitle: const Text('Youtube Playlist & Spotify'),
            trailing: const Icon(Icons.info_outline, size: 20, color: Colors.grey),
            onTap: () {
              // Karena Player sudah ada di halaman utama, kita hanya beri notifikasi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Gunakan Tombol Musik Melayang (ikon nada) di Halaman Utama."),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.red,
                ),
              );
            },
          ),
          const Divider(height: 1),
          // ------------------------------------
          
           const ListTile(
            leading: Icon(Icons.notifications_none),
            title: Text('Pengingat'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
      ),
    );
  }
}