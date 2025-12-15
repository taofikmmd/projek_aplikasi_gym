import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart'; // Import Main Screen agar bisa navigasi

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                "Pilih Level Anda",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Sesuaikan dengan kemampuan fisikmu saat ini",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // PILIHAN 1: PEMULA
              _buildLevelCard(
                context, 
                "Pemula", 
                "Baru memulai latihan fisik", 
                Colors.green,
                "Pemula"
              ),
              
              const SizedBox(height: 20),

              // PILIHAN 2: MENENGAH
              _buildLevelCard(
                context, 
                "Menengah", 
                "Sudah rutin berolahraga", 
                Colors.orange,
                "Menengah"
              ),

              const SizedBox(height: 20),

              // PILIHAN 3: LANJUTAN
              _buildLevelCard(
                context, 
                "Lanjutan", 
                "Latihan intensitas tinggi", 
                Colors.red,
                "Lanjutan"
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String title, String subtitle, Color color, String levelValue) {
    return InkWell(
      onTap: () {
        // NAVIGASI KE MAIN SCREEN MEMBAWA DATA LEVEL
        // Menggunakan pushReplacement agar tidak bisa back ke halaman pilih level
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(userLevel: levelValue),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(Icons.fitness_center, color: color),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}