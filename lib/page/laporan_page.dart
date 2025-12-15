import 'package:flutter/material.dart';

class laporanPage extends StatefulWidget {
  const laporanPage({super.key});

  @override
  State<laporanPage> createState() => _laporanPageState();
}

class _laporanPageState extends State<laporanPage> {
  // Controller untuk input
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();

  // State untuk hasil
  String _statusBeratBadan = "";
  String _pesanPemberitahuan = "";
  Color _warnaStatus = Colors.black;
  bool _showDietMenu = false; // Menampilkan menu diet hanya setelah dihitung

  void _hitungDanSimpan() {
    // Validasi input
    if (_beratController.text.isEmpty || _tinggiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon isi Tinggi dan Berat Badan!")),
      );
      return;
    }

    double berat = double.tryParse(_beratController.text) ?? 0;
    double tinggiCm = double.tryParse(_tinggiController.text) ?? 0;
    double tinggiM = tinggiCm / 100; // Konversi ke meter

    if (berat > 0 && tinggiM > 0) {
      // Rumus BMI
      double bmi = berat / (tinggiM * tinggiM);

      setState(() {
        _showDietMenu = true; // Tampilkan menu diet

        if (bmi < 18.5) {
          _statusBeratBadan = "Kekurangan Berat Badan";
          _pesanPemberitahuan = "Anda perlu menambah asupan kalori & protein.";
          _warnaStatus = Colors.orange;
        } else if (bmi >= 18.5 && bmi < 24.9) {
          _statusBeratBadan = "Berat Badan Ideal";
          _pesanPemberitahuan = "Pertahankan pola makan dan latihan Anda!";
          _warnaStatus = Colors.green;
        } else if (bmi >= 25 && bmi < 29.9) {
          _statusBeratBadan = "Kelebihan Berat Badan";
          _pesanPemberitahuan = "Anda sedikit kegemukan, kurangi gula.";
          _warnaStatus = Colors.orange.shade800;
        } else {
          _statusBeratBadan = "Obesitas / Kegemukan";
          _pesanPemberitahuan = "Bahaya! Anda kegemukan. Segera atur pola makan.";
          _warnaStatus = Colors.red;
        }
      });
      
      // Tampilkan notifikasi Snack Bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Status: $_statusBeratBadan. $_pesanPemberitahuan"),
          backgroundColor: _warnaStatus,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        title: const Text(
          'LAPORKAN',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CARD INFO LAMA ---
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _InfoItem(icon: Icons.bar_chart, title: 'Pemula'),
                    _InfoItem(title: 'Program', value: '7\nSelesai'),
                    _InfoItem(title: 'Waktu', value: '120\nMenit'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- FITUR BARU: INPUT BERAT & TINGGI ---
            const Text(
              "Cek Kondisi Badan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tinggiController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Tinggi (cm)",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.height),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _beratController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Berat (kg)",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.monitor_weight),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _hitungDanSimpan,
                      child: const Text(
                        'Cek & Simpan Berat Badan',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- HASIL PEMBERITAHUAN ---
            if (_showDietMenu) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _warnaStatus.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _warnaStatus),
                ),
                child: Column(
                  children: [
                    Text(
                      _statusBeratBadan.toUpperCase(),
                      style: TextStyle(
                        color: _warnaStatus,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _pesanPemberitahuan,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _warnaStatus),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // --- MENU MENJAGA POLA MAKAN ---
              const Text(
                "Menu Menjaga Pola Makan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildDietMenu(),
            ],

            const SizedBox(height: 20),

            // --- TARGET HARI INI (BAWAAN LAMA) ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Target Hari ini',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _TargetItem(title: 'CHEST'),
                  const SizedBox(height: 8),
                  _TargetItem(title: 'BICEPS'),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Text('Durasi'),
                      SizedBox(width: 8),
                      Text(
                        '0',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(' / 60 Menit'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan saran menu berdasarkan status
  Widget _buildDietMenu() {
    List<Map<String, String>> saranMenu = [];

    if (_statusBeratBadan.contains("Obesitas") || _statusBeratBadan.contains("Kelebihan")) {
      saranMenu = [
        {'title': 'Sarapan', 'desc': 'Oatmeal dengan buah-buahan atau telur rebus.'},
        {'title': 'Makan Siang', 'desc': 'Dada ayam bakar, nasi merah sedikit, banyak sayur.'},
        {'title': 'Makan Malam', 'desc': 'Salad sayur dengan tuna/tahu. Hindari karbohidrat berat.'},
        {'title': 'Tips', 'desc': 'Minum air putih 3L sehari, hindari gorengan & manis.'},
      ];
    } else if (_statusBeratBadan.contains("Kekurangan")) {
      saranMenu = [
        {'title': 'Sarapan', 'desc': 'Roti gandum selai kacang, susu full cream, pisang.'},
        {'title': 'Makan Siang', 'desc': 'Nasi putih, daging sapi/ayam, tempe, sayur sop.'},
        {'title': 'Makan Malam', 'desc': 'Nasi goreng ayam atau pasta dengan keju.'},
        {'title': 'Camilan', 'desc': 'Kacang-kacangan, alpukat, atau smoothies.'},
      ];
    } else {
      saranMenu = [
        {'title': 'Sarapan', 'desc': 'Roti gandum, telur dadar, jus jeruk.'},
        {'title': 'Makan Siang', 'desc': 'Nasi secukupnya, lauk pauk seimbang, sayuran hijau.'},
        {'title': 'Makan Malam', 'desc': 'Ikan bakar/pepes dengan tumis sayuran.'},
        {'title': 'Tips', 'desc': 'Jaga keseimbangan nutrisi dan istirahat cukup.'},
      ];
    }

    return Column(
      children: saranMenu.map((menu) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.restaurant_menu, color: Colors.green),
            title: Text(menu['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(menu['desc']!),
          ),
        );
      }).toList(),
    );
  }
}

// Widget Bawaan (Stateless)
class _InfoItem extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;

  const _InfoItem({required this.title, this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null) Icon(icon, size: 28),
        if (value != null)
          Text(
            value!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}

class _TargetItem extends StatelessWidget {
  final String title;

  const _TargetItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}