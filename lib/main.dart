// lib/main.dart

import 'package:flutter/material.dart';
// Asumsi Import-Import Anda:
import 'commponent/navbar.dart';
import 'page/program_latihan.dart';
import 'page/laporan_page.dart';
import 'page/account_page.dart';
import 'page/splash_screen.dart';
import 'page/login_screen.dart'; // <-- Pastikan ini ada dan benar

// ... DEFINISI SEMUA WIDGET HALAMAN ANDA DI SINI (MainScreen, etc.) ...
// (Saya ulangi MainScreen di bawah untuk memastikan integritas)

// -------------------------------------------------------------------
// 1. SPLASH SCREEN WRAPPER (Mengelola Transisi Waktu)
// -------------------------------------------------------------------

class SplashLoader extends StatefulWidget {
  const SplashLoader({super.key});

  @override
  State<SplashLoader> createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<SplashLoader> {
  @override
  void initState() {
    super.initState();
    // Panggil fungsi navigasi ke Login
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    // Jeda 3 detik untuk Splash Screen
    await Future.delayed(const Duration(seconds: 3));

    // Pindah ke Halaman Login
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // Arahkan ke LoginPage()
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan widget SplashScreen Anda
    return const SplashScreen();
  }
}

// -------------------------------------------------------------------
// 2. DEFINISI WRAPPER UTAMA (MainScreen - DIJAGA UTUH)
// -------------------------------------------------------------------

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    SessionPage(),
    laporanPage(), // Ganti menjadi LaporanPage() jika nama kelasnya berbeda
    accountPage(), // Ganti menjadi AccountPage() jika nama kelasnya berbeda
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// -------------------------------------------------------------------
// 3. DEFINISI WIDGET UTAMA APLIKASI (MyApp)
// -------------------------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Fitness',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
      ),
      // Memulai aplikasi dengan SplashLoader
      home: const SplashLoader(),
    );
  }
}

// -------------------------------------------------------------------
// 4. FUNGSI UTAMA (main)
// -------------------------------------------------------------------

void main() {
  runApp(const MyApp());
}
