// lib/main_screen.dart (Atau di file utama Anda)

import 'package:flutter/material.dart';
import '/commponent/navbar.dart'; // Import komponen navbar yang sudah dibuat

// --- Import Halaman-Halaman Anda ---
// Asumsikan:
// import 'menu_latihan_page.dart'; // Ini adalah halaman utama
// import 'laporan_page.dart';        // Ini adalah halaman Laporan/Kalender
// import 'akun_page.dart';          // Ini adalah halaman Akun/Profil

// --- Placeholder Halaman (Ganti dengan file Anda yang sebenarnya) ---
class MenuLatihanPage extends StatelessWidget {
  const MenuLatihanPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Halaman Menu Latihan',
        style: TextStyle(fontSize: 24, color: Colors.red),
      ),
    );
  }
}

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Laporan/Kalender', style: TextStyle(fontSize: 24)),
    );
  }
}

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Akun/Profil', style: TextStyle(fontSize: 24)),
    );
  }
}
// -------------------------------------------------------------------

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 1. Variabel state untuk melacak indeks halaman yang sedang aktif
  int _selectedIndex = 0;

  // 2. Daftar widget (halaman) yang akan ditampilkan
  final List<Widget> _pages = const [
    MenuLatihanPage(), // Indeks 0
    LaporanPage(), // Indeks 1
    AkunPage(), // Indeks 2
  ];

  // 3. Fungsi yang dipanggil saat item BottomNavigationBar diklik
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Memperbarui indeks aktif
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Latihan'
              : _selectedIndex == 1
              ? 'Laporan'
              : 'Profil',
        ),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),

      // BODY: Menampilkan halaman yang sesuai dengan _selectedIndex
      body: _pages[_selectedIndex],

      // BOTTOM NAVIGATION BAR: Memanggil komponen dari file 'navbar.dart'
      bottomNavigationBar: CustomBottomNavBar(
        // Meneruskan indeks aktif saat ini ke komponen navbar
        currentIndex: _selectedIndex,
        // Meneruskan fungsi _onItemTapped sebagai callback
        onTap: _onItemTapped,
      ),
    );
  }
}
