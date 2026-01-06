import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _showSnackBar(String message, [Color color = Colors.red]) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  Future<void> _handleRegister() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar("Semua kolom wajib diisi!");
      return;
    }

    if (password.length < 6) {
      _showSnackBar("Password minimal harus 6 karakter!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. BUAT AKUN DI FIREBASE AUTHENTICATION
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // 2. SIMPAN DATA KE CLOUD FIRESTORE
      // PENTING: Saya ubah 'users' menjadi 'user' sesuai screenshot database kamu
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userCredential.user!.uid)
          .set({
            'uid': userCredential.user!.uid,
            'username': username,
            'email': email,
            'role': 'member',
            'createdAt': FieldValue.serverTimestamp(),
          });

      // 3. UPDATE DISPLAY NAME
      await userCredential.user?.updateDisplayName(username);

      _showSnackBar("Registrasi Berhasil! Silakan Login.", Colors.green);

      await Future.delayed(const Duration(seconds: 2));
      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Menampilkan pesan error spesifik agar mudah diperbaiki
      String errorMsg = "Gagal: ${e.code}";
      if (e.code == 'email-already-in-use') {
        errorMsg = "Email sudah digunakan.";
      } else if (e.code == 'invalid-email') {
        errorMsg = "Format email salah.";
      } else if (e.code == 'operation-not-allowed') {
        errorMsg = "Metode Email/Password belum aktif di Firebase Console.";
      }
      _showSnackBar(errorMsg);
    } catch (e) {
      _showSnackBar("Terjadi Kesalahan: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/bg_splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Daftar Akun Gym",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 25),
                        _buildField(
                          _usernameController,
                          "Username",
                          Icons.person,
                        ),
                        const SizedBox(height: 15),
                        _buildField(_emailController, "Email", Icons.email),
                        const SizedBox(height: 15),
                        _buildField(
                          _passwordController,
                          "Password",
                          Icons.lock,
                          true,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade800,
                            ),
                            onPressed: _isLoading ? null : _handleRegister,
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "DAFTAR SEKARANG",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Sudah punya akun? Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String hint,
    IconData icon, [
    bool isPass = false,
  ]) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
