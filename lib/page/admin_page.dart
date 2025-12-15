import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Data Dummy untuk simulasi Database
  List<Map<String, String>> latihanData = [
    {'id': '1', 'name': 'Push Up', 'reps': '50x'},
    {'id': '2', 'name': 'Sit Up', 'reps': '30x'},
    {'id': '3', 'name': 'Squat', 'reps': '40x'},
  ];

  // Controller untuk Form Input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  // --- FUNGSI CRUD ---

  // 1. CREATE (Tambah Data)
  void _addNewItem() {
    _nameController.clear();
    _repsController.clear();
    showDialog(
      context: context,
      builder: (context) => _buildFormDialog(title: "Tambah Latihan", onSubmit: () {
        setState(() {
          latihanData.add({
            'id': DateTime.now().millisecondsSinceEpoch.toString(), // ID unik sederhana
            'name': _nameController.text,
            'reps': _repsController.text,
          });
        });
        Navigator.pop(context);
      }),
    );
  }

  // 2. UPDATE (Edit Data)
  void _editItem(int index) {
    _nameController.text = latihanData[index]['name']!;
    _repsController.text = latihanData[index]['reps']!;
    
    showDialog(
      context: context,
      builder: (context) => _buildFormDialog(title: "Edit Latihan", onSubmit: () {
        setState(() {
          latihanData[index]['name'] = _nameController.text;
          latihanData[index]['reps'] = _repsController.text;
        });
        Navigator.pop(context);
      }),
    );
  }

  // 3. DELETE (Hapus Data)
  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Item?"),
        content: Text("Yakin ingin menghapus ${latihanData[index]['name']}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                latihanData.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  // Widget Form Dialog yang dipakai ulang untuk Add dan Edit
  Widget _buildFormDialog({required String title, required VoidCallback onSubmit}) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Nama Latihan"),
          ),
          TextField(
            controller: _repsController,
            decoration: const InputDecoration(labelText: "Jumlah Repetisi (misal: 50x)"),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
        ElevatedButton(onPressed: onSubmit, child: const Text("Simpan")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard - Kelola Latihan'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: latihanData.isEmpty
          ? const Center(child: Text("Belum ada data latihan."))
          : ListView.builder(
              itemCount: latihanData.length,
              itemBuilder: (context, index) {
                final item = latihanData[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      child: Text("${index + 1}"),
                    ),
                    title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Repetisi: ${item['reps']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editItem(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}