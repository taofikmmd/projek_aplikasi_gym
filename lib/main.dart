// Lokasi File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// --- IMPORT COMPONENT & PAGES ---
// Pastikan path import ini sesuai dengan struktur folder Anda
import 'component/navbar.dart';
import 'page/program_latihan.dart';
import 'page/laporan_page.dart';
import 'page/account_page.dart';
import 'page/splash_screen.dart';
import 'page/login_screen.dart'; 

// -------------------------------------------------------------------
// 1. FUNGSI UTAMA (ENTRY POINT)
// -------------------------------------------------------------------
void main() {
  runApp(const MyApp());
}

// -------------------------------------------------------------------
// 2. KONFIGURASI APLIKASI (MyApp)
// -------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan pita 'DEBUG' di pojok kanan atas
      title: 'Aplikasi Fitness',
      theme: ThemeData(
        // Pengaturan Tema Warna Merah
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Aplikasi pertama kali dibuka akan menampilkan SplashLoader
      home: const SplashLoader(),
    );
  }
}

// -------------------------------------------------------------------
// 3. SPLASH SCREEN LOADER (Logika Pindah Halaman Otomatis)
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
    _navigateToLogin();
  }

  // Fungsi untuk menunggu 3 detik lalu pindah ke Login
  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(), // Pastikan LoginScreen sudah dibuat
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memanggil UI Splash Screen yang ada di file terpisah
    return const SplashScreen();
  }
}

// -------------------------------------------------------------------
// 4. MAIN SCREEN (Halaman Utama dengan Tab Bar)
// -------------------------------------------------------------------
class MainScreen extends StatefulWidget {
  // Menerima data level dari halaman sebelumnya (LevelPage)
  final String userLevel;

  const MainScreen({
    super.key,
    // Kita set default 'Pemula' untuk mencegah error jika dipanggil tanpa parameter
    this.userLevel = 'Pemula', 
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- STATE NAVIGASI ---
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- STATE MUSIK PLAYER ---
  late YoutubePlayerController _musicController;
  bool _isPlaying = false;
  String _currentTitle = "Pilih Lagu";
  String _currentId = "";

  // Data Playlist Musik
  final List<Map<String, String>> _playlist = [
    {'title': 'Workout Songs 2025', 'id': 'tMUxHx5fatA', 'duration': 'Live'},
    {'title': 'Best Workout Music Mix', 'id': 'JYNa_9pYLGw', 'duration': '1 Jam'},
    {'title': 'Gym Motivation Bangers', 'id': 'RV2rqYuSFGQ', 'duration': '41 Min'},
    {'title': 'EDM House Music', 'id': 'q24y9Uu8Ud8', 'duration': '1 Jam'},
  ];

  @override
  void initState() {
    super.initState();
    _currentId = _playlist[0]['id']!;
    _currentTitle = _playlist[0]['title']!;

    // Inisialisasi Youtube Player (Hidden)
    _musicController = YoutubePlayerController(
      initialVideoId: _currentId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: true,
        enableCaption: false,
        loop: true,
      ),
    )..addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _musicController.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _musicController.dispose();
    super.dispose();
  }

  // Fungsi Menampilkan Panel Musik (Bottom Sheet)
  void _showMusicPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 500,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(width: 50, height: 5, color: Colors.grey[300]),
              const SizedBox(height: 20),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://img.youtube.com/vi/$_currentId/default.jpg',
                        width: 60, height: 60, fit: BoxFit.cover,
                        errorBuilder: (c,e,s) => Container(color: Colors.grey, width: 60, height: 60),
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                    // Judul Lagu
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_currentTitle, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                          const Text("Audio Mode", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),

                    // Tombol Play/Pause Kecil
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                        onPressed: () {
                          _isPlaying ? _musicController.pause() : _musicController.play();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 30),
              
              // List Lagu
              Expanded(
                child: ListView.builder(
                  itemCount: _playlist.length,
                  itemBuilder: (context, index) {
                    final song = _playlist[index];
                    return ListTile(
                      leading: Icon(Icons.music_note, color: song['id'] == _currentId ? Colors.red : Colors.grey),
                      title: Text(song['title']!, style: TextStyle(color: song['id'] == _currentId ? Colors.red : Colors.black)),
                      onTap: () {
                        setState(() {
                          _currentId = song['id']!;
                          _currentTitle = song['title']!;
                        });
                        _musicController.load(_currentId);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- LIST HALAMAN ---
    // Definisikan di dalam build agar bisa mengakses 'widget.userLevel'
    final List<Widget> pages = [
      // Kirim level ke SessionPage (Program Latihan)
      SessionPage(userLevel: widget.userLevel), 
      const laporanPage(),
      const accountPage(),
    ];

    return Scaffold(
      // AppBar Atas
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Latihan (${widget.userLevel})' // Judul berubah sesuai level
              : _selectedIndex == 1
                  ? 'Laporan'
                  : 'Profil',
        ),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Hilangkan tombol back di halaman utama
      ),
      
      // Body dengan Stack (untuk Player Musik Background)
      body: Stack(
        children: [
          // 1. Konten Halaman Aktif
          // Menggunakan IndexedStack agar halaman tidak reload saat ganti tab
          IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),

          // 2. Player Musik Tersembunyi (Invisible)
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: 1, 
              height: 1,
              child: YoutubePlayer(
                controller: _musicController, 
                showVideoProgressIndicator: false
              ),
            ),
          ),

          // 3. Tombol Musik Melayang (Floating Button Manual)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0), 
              child: GestureDetector(
                onTap: _showMusicPanel,
                child: Container(
                  width: 56, 
                  height: 56,
                  decoration: BoxDecoration(
                    color: _isPlaying ? Colors.red : Colors.black87,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Navbar Bawah (Custom Component)
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}