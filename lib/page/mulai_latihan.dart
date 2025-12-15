import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatelessWidget {
  // Tambahan parameter agar halaman ini dinamis
  final String workoutName;
  final String reps;
  final String? imagePath; // Opsional, jika ada gambar
  
  const WorkoutDetailPage({
    super.key, 
    this.workoutName = 'Latihan', 
    this.reps = '',
    this.imagePath,
  });

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
            Navigator.pop(context); // Kembali tanpa menyimpan progres
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
              // Logika: Jika ada imagePath gunakan itu, jika tidak gunakan placeholder default
              imagePath != null 
                  ? Image.asset(
                      imagePath!, 
                      height: 250,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                         // Fallback jika gambar tidak ditemukan
                         return const Icon(Icons.fitness_center, size: 150, color: Colors.red);
                      },
                    )
                  : const Icon(Icons.fitness_center, size: 150, color: Colors.red),

              const SizedBox(height: 30),

              // --- BAGIAN TEKS ---
              Text(
                '$reps $workoutName', // Menggunakan data dinamis
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                    // Aksi ketika tombol ditekan:
                    // Kirim nilai 'true' ke halaman sebelumnya (menu_latihan)
                    // menandakan latihan ini selesai.
                    Navigator.pop(context, true);
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