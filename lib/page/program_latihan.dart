import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'menu_latihan.dart';
import 'account_page.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                const Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    "SESI LATIHAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            _sessionCard(
              title: "Day 1",
              subtitle: "5 Menit",
              image: 'assets/img/selesai.png',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChestWorkoutApp(),
                  ),
                );
              },
              active: true,
            ),

            _sessionCard(
              title: "Day 2",
              subtitle: "5 Menit",
              image: 'assets/img/mulai.png',
              onPressed: () {},
            ),

            _sessionCard(
              title: "Istirahat",
              subtitle: "Harinya istirahat!",
              image: 'assets/img/istirahat.png',
            ),
            _sessionCard(
              title: "Day 3",
              subtitle: "5 Menit",
              image: 'assets/img/model.png',
              onPressed: () {},
            ),

            _sessionCard(
              title: "Day 4",
              subtitle: "5 Menit",
              image: 'assets/img/model2.png',
              onPressed: () {},
            ),

            _sessionCard(
              title: "Istirahat",
              subtitle: "Harinya istirahat!",
              image: 'assets/img/istirahat.png',
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget _sessionCard({
    required String title,
    required String subtitle,
    required String image,
    VoidCallback? onPressed,
    bool active = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: active ? Colors.red : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
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

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.red.shade700,
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
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: onPressed,
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                "MULAI",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
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
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.7);
  }
}
