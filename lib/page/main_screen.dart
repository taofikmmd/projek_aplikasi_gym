// Lokasi File: lib/page/main_screen.dart

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:math'; // IMPORT PENTING UNTUK SHUFFLE

// --- IMPORT COMPONENT & PAGES ---
import '../component/navbar.dart'; 
import 'program_latihan.dart';
import 'laporan_page.dart';
import 'account_page.dart';
import 'level_page.dart';

class MainScreen extends StatefulWidget {
  final String userLevel;

  const MainScreen({
    super.key,
    this.userLevel = 'Pemula', 
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- NAVIGASI ---
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- MUSIK & SHUFFLE ---
  late YoutubePlayerController _musicController;
  bool _isPlaying = false;
  bool _isShuffle = false; // Status Shuffle (Aktif/Mati)
  String _currentTitle = "Pilih Lagu";
  String _currentId = "";

  final List<Map<String, String>> _playlist = [
    {'title': 'Workout Songs 2025', 'id': 'tMUxHx5fatA', 'duration': 'Live'},
    {'title': 'Best Workout Music Mix', 'id': 'JYNa_9pYLGw', 'duration': '1 Jam'},
    {'title': 'Gym Motivation Bangers', 'id': 'RV2rqYuSFGQ', 'duration': '41 Min'},
    {'title': 'EDM House Music', 'id': 'q24y9Uu8Ud8', 'duration': '1 Jam'},
    {'title': 'Neck Deep -Desember', 'id': '8NnQs3EtoqU', 'duration': '3:38 min'},
  ];

  @override
  void initState() {
    super.initState();
    _currentId = _playlist[0]['id']!;
    _currentTitle = _playlist[0]['title']!;

    _musicController = YoutubePlayerController(
      initialVideoId: _currentId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: true,
        enableCaption: false,
        loop: false, // MATIKAN LOOP BAWAAN (Agar kita bisa kontrol manual)
      ),
    )..addListener(_musicListener);
  }

  // Listener untuk memantau status player
  void _musicListener() {
    if (mounted) {
      setState(() {
        _isPlaying = _musicController.value.isPlaying;
      });

      // LOGIKA SHUFFLE / AUTO NEXT
      // Jika status player adalah ENDED (Selesai), putar lagu selanjutnya
      if (_musicController.value.playerState == PlayerState.ended) {
        _playNextSong();
      }
    }
  }

  // FUNGSI MEMUTAR LAGU SELANJUTNYA
  void _playNextSong() {
    int nextIndex;
    int currentIndex = _playlist.indexWhere((song) => song['id'] == _currentId);

    if (_isShuffle) {
      // LOGIKA SHUFFLE: Pilih indeks acak
      // Pastikan tidak memutar lagu yang sama jika playlist lebih dari 1
      do {
        nextIndex = Random().nextInt(_playlist.length);
      } while (nextIndex == currentIndex && _playlist.length > 1);
    } else {
      // LOGIKA NORMAL: Lanjut ke urutan berikutnya (Looping playlist)
      nextIndex = (currentIndex + 1) % _playlist.length;
    }

    // Muat Lagu Baru
    final nextSong = _playlist[nextIndex];
    setState(() {
      _currentId = nextSong['id']!;
      _currentTitle = nextSong['title']!;
    });
    
    _musicController.load(_currentId);
    _musicController.play();
  }

  @override
  void dispose() {
    _musicController.removeListener(_musicListener); // Hapus listener saat keluar
    _musicController.dispose();
    super.dispose();
  }

  // --- PANEL MUSIK ---
  void _showMusicPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        // Gunakan StatefulBuilder agar tampilan bottom sheet bisa di-refresh (untuk tombol shuffle)
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 550,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(width: 50, height: 5, color: Colors.grey[300]),
                  const SizedBox(height: 20),
                  
                  // INFO LAGU & KONTROL
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://img.youtube.com/vi/$_currentId/default.jpg',
                            width: 60, height: 60, fit: BoxFit.cover,
                            errorBuilder: (c,e,s) => Container(color: Colors.grey, width: 60, height: 60),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_currentTitle, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text(_isShuffle ? "Mode: Acak (Shuffle)" : "Mode: Berurutan", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BARIS TOMBOL KONTROL (Shuffle - Prev - Play - Next)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TOMBOL SHUFFLE
                      IconButton(
                        icon: Icon(Icons.shuffle, color: _isShuffle ? Colors.red : Colors.grey, size: 28),
                        onPressed: () {
                          // Update state di MainScreen dan di Modal
                          setState(() => _isShuffle = !_isShuffle);
                          setModalState(() {}); // Refresh tampilan modal
                        },
                      ),
                      const SizedBox(width: 20),

                      // TOMBOL PREVIOUS (Mundur)
                      IconButton(
                         icon: const Icon(Icons.skip_previous, size: 36),
                         onPressed: () {
                           // Mundur logika sederhana (index - 1)
                           int currentIndex = _playlist.indexWhere((song) => song['id'] == _currentId);
                           int prevIndex = (currentIndex - 1) < 0 ? _playlist.length - 1 : currentIndex - 1;
                           final prevSong = _playlist[prevIndex];
                           setState(() {
                             _currentId = prevSong['id']!;
                             _currentTitle = prevSong['title']!;
                           });
                           _musicController.load(_currentId);
                           setModalState((){});
                         },
                      ),

                      const SizedBox(width: 10),

                      // TOMBOL PLAY/PAUSE BESAR
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red,
                        child: IconButton(
                          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 30),
                          onPressed: () {
                            _isPlaying ? _musicController.pause() : _musicController.play();
                            setModalState((){}); // Refresh icon
                          },
                        ),
                      ),

                      const SizedBox(width: 10),

                      // TOMBOL NEXT (Maju/Shuffle Manual)
                      IconButton(
                         icon: const Icon(Icons.skip_next, size: 36),
                         onPressed: () {
                           _playNextSong(); // Panggil fungsi next/shuffle
                           setModalState((){});
                         },
                      ),
                      const SizedBox(width: 20),
                      
                      // Placeholder agar seimbang (bisa diisi repeat mode nanti)
                      const SizedBox(width: 28), 
                    ],
                  ),

                  const Divider(height: 30),
                  
                  // LIST PLAYLIST
                  Expanded(
                    child: ListView.builder(
                      itemCount: _playlist.length,
                      itemBuilder: (context, index) {
                        final song = _playlist[index];
                        bool isActive = song['id'] == _currentId;
                        return ListTile(
                          leading: Icon(
                            isActive ? Icons.bar_chart : Icons.music_note, 
                            color: isActive ? Colors.red : Colors.grey
                          ),
                          title: Text(
                            song['title']!, 
                            style: TextStyle(
                              color: isActive ? Colors.red : Colors.black,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal
                            )
                          ),
                          subtitle: Text(song['duration']!),
                          trailing: isActive ? const Icon(Icons.volume_up, color: Colors.red, size: 18) : null,
                          onTap: () {
                            setState(() {
                              _currentId = song['id']!;
                              _currentTitle = song['title']!;
                            });
                            _musicController.load(_currentId);
                            setModalState((){}); // Refresh tampilan modal agar highlight pindah
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      SessionPage(userLevel: widget.userLevel), 
      const laporanPage(),
      const accountPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Latihan (${widget.userLevel})' 
              : _selectedIndex == 1
                  ? 'Laporan'
                  : 'Profil',
        ),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        
        // Tombol Back ke Level Page
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LevelPage()),
            );
          },
        ),
      ),
      
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),

          // Player Tersembunyi
          Positioned(
            bottom: 0, right: 0,
            child: SizedBox(
              width: 1, height: 1,
              child: YoutubePlayer(controller: _musicController, showVideoProgressIndicator: false),
            ),
          ),

          // Tombol Melayang
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
                      BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
                    ],
                  ),
                  child: const Icon(Icons.music_note, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}