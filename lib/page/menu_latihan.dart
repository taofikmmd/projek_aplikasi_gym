import 'package:flutter/material.dart';
import 'mulai_latihan.dart';

// --- Widget Utama Aplikasi ---

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChestWorkoutApp(),
    );
  }
}

// --- Layar Latihan Dada ---
class ChestWorkoutApp extends StatelessWidget {
  const ChestWorkoutApp({super.key});

  // Data untuk daftar latihan
  final List<Map<String, dynamic>> workouts = const [
    {'name': 'Push Up', 'reps': '50x', 'image': 'assets/images/pushup.png'},
    {'name': 'Push Up Diamond', 'reps': '50x', 'icon': Icons.fitness_center},
    {'name': 'Wide Push Up', 'reps': '50x', 'icon': Icons.fitness_center},
    {
      'name': 'Reverse Grip Push-Up',
      'reps': '50x',
      'icon': Icons.fitness_center,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // Bagian Header (Gambar latar belakang dan teks CHEST)
          SliverAppBar(
            expandedHeight: 250.0, // Tinggi AppBar saat diperluas
            floating: false,
            pinned: true, // AppBar akan tetap ada di atas saat digulir
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              title: const Text(
                'CHEST',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    // Ganti dengan URL gambar Anda atau AssetImage
                    image: AssetImage(
                      'assets/img/menu_latihan.png', // Sesuaikan path ini jika Anda menggunakan subfolder
                    ), // Placeholder image
                    fit: BoxFit.cover,
                  ),
                ),
                // Tambahkan overlay gelap untuk kontras teks
                child: Container(color: Colors.black.withOpacity(0.4)),
              ),
            ),
          ),

          // Bagian Daftar Latihan
          SliverList(
            delegate: SliverChildListDelegate([
              ...workouts.map((workout) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: WorkoutTile(
                    name: workout['name']!,
                    reps: workout['reps']!,
                  ),
                );
              }),

              // Tombol "Mulai"
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkoutDetailPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna merah
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Mulai',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),

      // Bottom Navigation Bar
    );
  }
}

// --- Widget Kustom untuk Baris Latihan ---
class WorkoutTile extends StatelessWidget {
  final String name;
  final String reps;

  const WorkoutTile({super.key, required this.name, required this.reps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Placeholder untuk gambar kecil/ikon latihan (Ganti dengan gambar Anda)
          Container(
            width: 50.0,
            height: 50.0,
            // Menggunakan warna latar belakang untuk simulasi gambar
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(
              Icons.directions_run,
              color: Colors.red,
              size: 30.0,
            ),
          ),
          const SizedBox(width: 16.0),
          // Nama Latihan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Repetisi
                Text(
                  reps,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
