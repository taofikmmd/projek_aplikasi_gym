// Lokasi: lib/page/menu_latihan.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WorkoutMenuPage extends StatefulWidget {
  final String pageTitle;
  final String headerImage;
  final List<Map<String, dynamic>> workoutData;

  const WorkoutMenuPage({
    super.key,
    required this.pageTitle,
    required this.headerImage,
    required this.workoutData,
  });

  @override
  State<WorkoutMenuPage> createState() => _WorkoutMenuPageState();
}

class _WorkoutMenuPageState extends State<WorkoutMenuPage> {
  // List lokal agar kita bisa mengubah status checkbox tanpa merusak data asli
  late List<Map<String, dynamic>> _exercises;

  @override
  void initState() {
    super.initState();
    // Copy data dari widget agar bisa dimodifikasi (checkbox true/false)
    _exercises = List<Map<String, dynamic>>.from(widget.workoutData);
  }

  // Fungsi untuk mengecek berapa persen latihan yang sudah selesai
  double _calculateProgress() {
    int total = _exercises.length;
    int completed = _exercises.where((e) => e['isCompleted'] == true).length;
    return total == 0 ? 0 : completed / total;
  }

  // Fungsi saat user menekan checkbox
  void _toggleExercise(int index) {
    setState(() {
      _exercises[index]['isCompleted'] = !_exercises[index]['isCompleted'];
    });
  }

  // Fungsi saat tombol SELESAI ditekan
  void _finishWorkout() {
    // Tampilkan Dialog Selamat
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 60),
            const SizedBox(height: 10),
            Text(
              "Luar Biasa!",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          "Kamu telah menyelesaikan sesi latihan ini.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Tutup Dialog
              
              // KEMBALI KE HALAMAN SEBELUMNYA DENGAN SINYAL 'TRUE' (SELESAI)
              Navigator.pop(context, true); 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text("Lanjut"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = _calculateProgress();
    bool isAllDone = progress == 1.0; // Cek apakah progress sudah 100%

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // --- 1. HEADER IMAGE & TITLE ---
          Stack(
            children: [
              SizedBox(
                height: 220,
                width: double.infinity,
                child: Image.asset(
                  widget.headerImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    Container(color: Colors.grey.shade300),
                ),
              ),
              // Overlay Gelap
              Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
              ),
              // Tombol Back
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context, false), // Kembali tanpa selesai
                ),
              ),
              // Judul Halaman
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pageTitle,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Indikator Progress Garis
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation(Colors.red),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${(progress * 100).toInt()}% Selesai",
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // --- 2. LIST LATIHAN ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                bool isChecked = exercise['isCompleted'] ?? false;

                return GestureDetector(
                  onTap: () => _toggleExercise(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isChecked ? Colors.red.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isChecked ? Colors.red : Colors.grey.shade200,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        // Gambar Kecil (Thumbnail Latihan)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                            image: exercise['image'] != null 
                              ? DecorationImage(
                                  image: AssetImage(exercise['image']), 
                                  fit: BoxFit.cover
                                )
                              : null,
                          ),
                          child: exercise['image'] == null 
                            ? const Icon(Icons.fitness_center, color: Colors.grey) 
                            : null,
                        ),
                        const SizedBox(width: 15),
                        
                        // Nama & Repetisi
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  decoration: isChecked ? TextDecoration.lineThrough : null,
                                ),
                              ),
                              Text(
                                exercise['reps'],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Checkbox Custom
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isChecked ? Colors.red : Colors.white,
                            border: Border.all(
                              color: isChecked ? Colors.red : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: isChecked 
                            ? const Icon(Icons.check, size: 18, color: Colors.white)
                            : null,
                        ),
                      ],
                    ),
                  ),
                ).animate().slideX(begin: 0.2, duration: (300 + (index * 100)).ms);
              },
            ),
          ),

          // --- 3. TOMBOL SELESAI ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -5),
                  blurRadius: 10,
                )
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isAllDone ? _finishWorkout : null, // Disable jika belum 100%
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  disabledBackgroundColor: Colors.grey.shade300, // Warna saat disable
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: isAllDone ? 5 : 0,
                ),
                child: Text(
                  isAllDone ? "SELESAI LATIHAN" : "SELESAIKAN SEMUA GERAKAN",
                  style: GoogleFonts.poppins(
                    color: isAllDone ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}