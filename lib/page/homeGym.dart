import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeGym extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jadwal Gym")),
      body: StreamBuilder(
        // Mengambil data dari koleksi 'apk_gym' secara realtime
        stream: FirebaseFirestore.instance.collection('apk_gym').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['nama_kelas']),
                subtitle: Text("Instruktur: ${doc['instruktur']}"),
                trailing: Text(doc['jam']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
