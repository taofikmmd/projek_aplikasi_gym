import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatelessWidget {
  const WorkoutDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Hilangkan bayangan AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1), // Dorong konten sedikit ke bawah
              // --- BAGIAN GAMBAR ---
              // Ganti dengan Image.asset('assets/images/pushup.png') jika file lokal
              Image.asset(
                'assets/img/pushup.png', // Contoh placeholder
                height: 250,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 30),

              // --- BAGIAN TEKS ---
              const Text(
                '50 Push Up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const Spacer(flex: 2), // Dorong tombol ke bawah
              // --- TOMBOL SELESAI ---
              SizedBox(
                width: double.infinity, // Lebar tombol memenuhi layar
                height: 55, // Tinggi tombol
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol ditekan
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFC61212,
                    ), // Warna Merah Gelap
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Sudut melengkung
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Selesai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
