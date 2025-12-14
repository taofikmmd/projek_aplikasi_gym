// lib/component/navbar.dart

import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed, // Memastikan label selalu terlihat
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Latihan', // Indeks 0: Latihan
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Kalender', // Indeks 1: Kalender / Laporan
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil', // Indeks 2: Akun
        ),
      ],
      // Meneruskan event klik ke fungsi onTap yang diberikan oleh parent widget
      onTap: onTap,
    );
  }
}
