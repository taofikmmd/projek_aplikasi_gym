import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import Wajib
import 'menu_latihan.dart'; 

class SessionPage extends StatefulWidget {
  final String userLevel; 

  const SessionPage({
    super.key, 
    required this.userLevel, 
  });

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  // Variabel untuk menyimpan daftar hari yang sudah selesai
  // Contoh isi: {"Pemula_1", "Pemula_2"}
  Set<String> _completedSessions = {};

  @override
  void initState() {
    super.initState();
    _loadCompletedSessions(); // Muat data saat aplikasi dibuka
  }

  // --- LOGIKA PENYIMPANAN DATA (DATABASE SEDERHANA) ---
  
  // 1. Memuat data dari HP
  Future<void> _loadCompletedSessions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Ambil list string yang tersimpan, jika kosong buat list baru
      _completedSessions = prefs.getStringList('completed_workouts')?.toSet() ?? {};
    });
  }

  // 2. Menandai hari sebagai selesai
  Future<void> _markAsCompleted(int dayIndex) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Buat ID unik: Level + Index Hari (Contoh: "Pemula_1")
    String sessionID = "${widget.userLevel}_$dayIndex";
    
    setState(() {
      _completedSessions.add(sessionID);
    });

    // Simpan permanen ke memori HP
    await prefs.setStringList('completed_workouts', _completedSessions.toList());
  }

  // 3. Cek apakah hari ini sudah selesai
  bool _isSessionDone(int dayIndex) {
    String sessionID = "${widget.userLevel}_$dayIndex";
    return _completedSessions.contains(sessionID);
  }

  // ===========================================================================
  // DATABASE LATIHAN (SAMA SEPERTI SEBELUMNYA)
  // ===========================================================================

  // --- LEVEL: PEMULA ---
  final List<Map<String, dynamic>> _begDay1Chest = const [
    {'name': 'Push Up', 'reps': '12x', 'isCompleted': false, 'image': 'assets/img/pushup.png'},
    {'name': 'Knee Push Up', 'reps': '12x', 'isCompleted': false},
    {'name': 'Wall Push Up', 'reps': '15x', 'isCompleted': false},
    {'name': 'Cobra Stretch', 'reps': '30 Detik', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _begDay2Back = const [
    {'name': 'Arm Raises', 'reps': '15x', 'isCompleted': false},
    {'name': 'Superman', 'reps': '20 Detik', 'isCompleted': false},
    {'name': 'Cat-Cow', 'reps': '30 Detik', 'isCompleted': false},
    {'name': 'Child Pose', 'reps': '30 Detik', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _begDay3Legs = const [
    {'name': 'Squats', 'reps': '15x', 'isCompleted': false},
    {'name': 'Lunges', 'reps': '12x', 'isCompleted': false},
    {'name': 'Side Lying Leg Lift', 'reps': '12x', 'isCompleted': false},
    {'name': 'Calf Raises', 'reps': '15x', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _begDay4Abs = const [
    {'name': 'Sit Up', 'reps': '15x', 'isCompleted': false},
    {'name': 'Plank', 'reps': '30 Detik', 'isCompleted': false},
    {'name': 'Heel Touch', 'reps': '20x', 'isCompleted': false},
    {'name': 'Cobra Stretch', 'reps': '30 Detik', 'isCompleted': false},
  ];

  // --- LEVEL: MENENGAH ---
  final List<Map<String, dynamic>> _intDay1Chest = const [
    {'name': 'Wide Push Up', 'reps': '15x', 'isCompleted': false, 'image': 'assets/img/pushup.png'},
    {'name': 'Diamond Push Up', 'reps': '10x', 'isCompleted': false},
    {'name': 'Decline Push Up', 'reps': '12x', 'isCompleted': false},
    {'name': 'Spiderman Push Up', 'reps': '10x', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _intDay2Back = const [
    {'name': 'Pull Up', 'reps': '8x', 'isCompleted': false},
    {'name': 'Hyperextension', 'reps': '15x', 'isCompleted': false},
    {'name': 'Reverse Snow Angels', 'reps': '15x', 'isCompleted': false},
    {'name': 'Doorway Rows', 'reps': '15x', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _intDay3Legs = const [
    {'name': 'Jump Squats', 'reps': '15x', 'isCompleted': false},
    {'name': 'Bulgarian Split Squat', 'reps': '10x', 'isCompleted': false},
    {'name': 'Sumo Squat', 'reps': '20x', 'isCompleted': false},
    {'name': 'Wall Sit', 'reps': '1 Menit', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _intDay4Abs = const [
    {'name': 'Leg Raises', 'reps': '20x', 'isCompleted': false},
    {'name': 'Russian Twist', 'reps': '30x', 'isCompleted': false},
    {'name': 'Mountain Climber', 'reps': '30 Detik', 'isCompleted': false},
    {'name': 'Side Plank', 'reps': '30 Detik', 'isCompleted': false},
  ];

  // --- LEVEL: LANJUTAN ---
  final List<Map<String, dynamic>> _advDay1Chest = const [
    {'name': 'Archer Push Up', 'reps': '12x', 'isCompleted': false, 'image': 'assets/img/pushup.png'},
    {'name': 'Clap Push Up', 'reps': '10x', 'isCompleted': false},
    {'name': 'One Arm Push Up (Assist)', 'reps': '8x', 'isCompleted': false},
    {'name': 'Weighted Push Up', 'reps': '15x', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _advDay2Back = const [
    {'name': 'Wide Grip Pull Up', 'reps': '12x', 'isCompleted': false},
    {'name': 'Commando Pull Up', 'reps': '10x', 'isCompleted': false},
    {'name': 'Superman Hold', 'reps': '1 Menit', 'isCompleted': false},
    {'name': 'Australian Pull Up', 'reps': '20x', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _advDay3Legs = const [
    {'name': 'Pistol Squats', 'reps': '8x', 'isCompleted': false},
    {'name': 'Lunge Jumps', 'reps': '20x', 'isCompleted': false},
    {'name': 'Box Jumps', 'reps': '15x', 'isCompleted': false},
    {'name': 'Single Leg Calf Raise', 'reps': '20x', 'isCompleted': false},
  ];
  final List<Map<String, dynamic>> _advDay4Abs = const [
    {'name': 'V-Ups', 'reps': '20x', 'isCompleted': false},
    {'name': 'Hanging Leg Raises', 'reps': '15x', 'isCompleted': false},
    {'name': 'Bicycle Crunches', 'reps': '1 Menit', 'isCompleted': false},
    {'name': 'Plank to Push Up', 'reps': '20x', 'isCompleted': false},
  ];

  List<Map<String, dynamic>> _getData(int day) {
    if (widget.userLevel == 'Menengah') {
      if (day == 1) return _intDay1Chest;
      if (day == 2) return _intDay2Back;
      if (day == 3) return _intDay3Legs;
      return _intDay4Abs;
    } else if (widget.userLevel == 'Lanjutan') {
      if (day == 1) return _advDay1Chest;
      if (day == 2) return _advDay2Back;
      if (day == 3) return _advDay3Legs;
      return _advDay4Abs;
    } else {
      if (day == 1) return _begDay1Chest;
      if (day == 2) return _begDay2Back;
      if (day == 3) return _begDay3Legs;
      return _begDay4Abs;
    }
  }

  String _getDuration(int day) {
    if (widget.userLevel == 'Lanjutan') return "15-20 Menit • Intens";
    if (widget.userLevel == 'Menengah') return "10-15 Menit • Sedang";
    return "5-7 Menit • Ringan"; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 
        toolbarHeight: 0, 
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- HEADER ---
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 190,
                  child: Image.asset(
                    'assets/img/hero_sesi.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SESI LATIHAN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(offset: Offset(0, 2), blurRadius: 4, color: Colors.black45),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          "Level: ${widget.userLevel}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // --- DAY 1 ---
            _sessionCard(
              context: context,
              title: "Day 1 (Chest)",
              subtitle: _getDuration(1),
              image: 'assets/img/selesai.png',
              dayIndex: 1, 
              headerImage: 'assets/img/menu_latihan.png',
              active: true,
            ),

            // --- DAY 2 ---
            _sessionCard(
              context: context,
              title: "Day 2 (Back)",
              subtitle: _getDuration(2),
              image: 'assets/img/mulai.png',
              dayIndex: 2,
              headerImage: 'assets/img/hero_sesi.png',
            ),

            // --- ISTIRAHAT ---
            _sessionCard(
              context: context,
              title: "Istirahat",
              subtitle: "Pemulihan Otot",
              image: 'assets/img/istirahat.png',
              isRestDay: true,
            ),

            // --- DAY 3 ---
            _sessionCard(
              context: context,
              title: "Day 3 (Legs)",
              subtitle: _getDuration(3),
              image: 'assets/img/model.png',
              dayIndex: 3,
              headerImage: 'assets/img/hero_sesi.png',
            ),

            // --- DAY 4 ---
            _sessionCard(
              context: context,
              title: "Day 4 (Abs)",
              subtitle: _getDuration(4),
              image: 'assets/img/model2.png',
              dayIndex: 4,
              headerImage: 'assets/img/hero_sesi.png',
            ),

            // --- SELESAI ---
            _sessionCard(
              context: context,
              title: "Selesai",
              subtitle: "Evaluasi Mingguan",
              image: 'assets/img/istirahat.png',
              isRestDay: true,
              isLast: true,
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget _sessionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String image,
    int dayIndex = 0, 
    String headerImage = 'assets/img/menu_latihan.png',
    bool active = false,
    bool isLast = false,
    bool isRestDay = false,
  }) {
    // CEK APAKAH SUDAH SELESAI?
    bool isDone = _isSessionDone(dayIndex);
    
    // Warna Card: Kalau selesai jadi Abu-abu gelap, kalau istirahat abu-abu terang, kalau aktif Merah
    Color cardColor = isRestDay 
        ? Colors.blueGrey.shade100 
        : (isDone ? Colors.grey.shade400 : Colors.red.shade700);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // GARIS ALUR (TIMELINE)
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  // Jika selesai, titiknya jadi hijau
                  color: isDone ? Colors.green : (active ? Colors.red : Colors.white),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: isDone ? const Icon(Icons.check, size: 10, color: Colors.white) : null,
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 150,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // KARTU KONTEN
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -10,
                    bottom: 0,
                    child: Image.asset(image, width: 180, fit: BoxFit.contain),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 100, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: isRestDay ? Colors.black87 : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            decoration: isDone ? TextDecoration.lineThrough : null, // Coret jika selesai
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isDone ? "Latihan Selesai ✅" : subtitle, // Ubah teks jika selesai
                          style: GoogleFonts.poppins(
                            color: isRestDay ? Colors.black54 : Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),

                        if (!isRestDay)
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isDone 
                                  ? null // DISABLE TOMBOL JIKA SUDAH SELESAI
                                  : () async {
                                      final data = _getData(dayIndex);
                                      
                                      // Navigasi dan MENUNGGU HASIL (true jika selesai)
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WorkoutMenuPage(
                                            pageTitle: "$title - ${widget.userLevel}",
                                            headerImage: headerImage,
                                            workoutData: List.from(
                                              data.map((e) => Map<String, dynamic>.from(e)),
                                            ),
                                          ),
                                        ),
                                      );

                                      // Jika WorkoutMenuPage mengembalikan 'true', tandai selesai
                                      if (result == true) {
                                        _markAsCompleted(dayIndex);
                                      }
                                    },
                                style: ElevatedButton.styleFrom(
                                  // Ubah warna tombol jika disable
                                  backgroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.grey.shade300, 
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  isDone ? "SELESAI" : "MULAI", // Ubah Teks Tombol
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3);
  }
}