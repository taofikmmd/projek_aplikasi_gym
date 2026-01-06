import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Data Dummy (Nanti bisa diganti dengan Firebase)
  List<Map<String, String>> latihanData = [
    {'id': '1', 'name': 'Push Up', 'reps': '50x'},
    {'id': '2', 'name': 'Sit Up', 'reps': '30x'},
    {'id': '3', 'name': 'Squat', 'reps': '40x'},
    {'id': '4', 'name': 'Plank', 'reps': '1 Menit'},
    {'id': '5', 'name': 'Lari Statis', 'reps': '15 Menit'},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  // --- FUNGSI INPUT MENGGUNAKAN BOTTOM SHEET (Lebih Modern) ---
  void _showFormPanel({int? index}) {
    bool isEdit = index != null;
    
    // Jika Edit, isi form dengan data lama
    if (isEdit) {
      _nameController.text = latihanData[index]['name']!;
      _repsController.text = latihanData[index]['reps']!;
    } else {
      _nameController.clear();
      _repsController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Agar tidak tertutup keyboard
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEdit ? "Edit Latihan" : "Tambah Latihan Baru",
                style: GoogleFonts.poppins(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              
              // Input Nama
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama Gerakan",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.fitness_center),
                ),
              ),
              const SizedBox(height: 15),
              
              // Input Reps
              TextField(
                controller: _repsController,
                decoration: InputDecoration(
                  labelText: "Jumlah Repetisi (Contoh: 12x)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.repeat),
                ),
              ),
              
              const SizedBox(height: 25),
              
              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty && _repsController.text.isNotEmpty) {
                      setState(() {
                        if (isEdit) {
                          // UPDATE
                          latihanData[index]['name'] = _nameController.text;
                          latihanData[index]['reps'] = _repsController.text;
                        } else {
                          // CREATE
                          latihanData.add({
                            'id': DateTime.now().millisecondsSinceEpoch.toString(),
                            'name': _nameController.text,
                            'reps': _repsController.text,
                          });
                        }
                      });
                      Navigator.pop(context); // Tutup panel
                    }
                  },
                  child: Text(
                    isEdit ? "SIMPAN PERUBAHAN" : "TAMBAH DATA",
                    style: const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- FUNGSI HAPUS ---
  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Item?"),
        content: Text("Yakin ingin menghapus '${latihanData[index]['name']}'?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Batal", style: TextStyle(color: Colors.grey))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              setState(() {
                latihanData.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background sedikit abu agar modern
      appBar: AppBar(
        title: Text(
          'Admin Dashboard', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
            tooltip: "Keluar",
          )
        ],
      ),
      
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER RINGKASAN ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.dashboard, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Latihan",
                        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        "${latihanData.length} Item",
                        style: GoogleFonts.poppins(
                          color: Colors.white, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- LIST DATA ---
            Expanded(
              child: latihanData.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open, size: 80, color: Colors.grey[300]),
                          const SizedBox(height: 10),
                          Text("Belum ada data latihan", style: TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: latihanData.length,
                      itemBuilder: (context, index) {
                        final item = latihanData[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.fitness_center, color: Colors.red.shade700),
                            ),
                            title: Text(
                              item['name']!,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              "Target: ${item['reps']}",
                              style: GoogleFonts.poppins(color: Colors.grey[600]),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Tombol Edit
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                                  onPressed: () => _showFormPanel(index: index),
                                ),
                                // Tombol Hapus
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () => _deleteItem(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // TOMBOL TAMBAH MELAYANG
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFormPanel(),
        backgroundColor: Colors.red.shade700,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Tambah Data", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
