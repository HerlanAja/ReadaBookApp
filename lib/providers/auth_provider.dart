import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  bool isLogin = false; // Mode Register secara default
  String enteredEmail = ''; // Email yang diinput pengguna
  String enteredPassword = ''; // Password yang diinput pengguna
  bool isLoading = false; // Status loading
  String? errorMessage; // Pesan error untuk ditampilkan di UI

  /// Fungsi untuk menangani submit (Login/Registrasi)
  Future<void> submit() async {
    final isValid = form.currentState?.validate(); // Validasi form
    if (isValid == null || !isValid) return;

    form.currentState?.save(); // Simpan data input pengguna

    try {
      _setLoading(true); // Aktifkan status loading

      if (isLogin) {
        // Proses login pengguna
        await _fireAuth.signInWithEmailAndPassword(
          email: enteredEmail.trim(),
          password: enteredPassword.trim(),
        );
      } else {
        // Proses registrasi pengguna baru
        await _fireAuth.createUserWithEmailAndPassword(
          email: enteredEmail.trim(),
          password: enteredPassword.trim(),
        );
      }

      errorMessage = null; // Reset error jika berhasil
    } on FirebaseAuthException catch (e) {
      errorMessage = _getErrorMessage(e.code); // Ambil pesan error dari kode
    } catch (e) {
      errorMessage = 'Terjadi kesalahan tak terduga: $e'; // Fallback error
    } finally {
      _setLoading(false); // Matikan status loading
    }
  }

  /// Fungsi untuk mendapatkan pesan error berdasarkan kode Firebase
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar.';
      case 'user-not-found':
        return 'Pengguna tidak ditemukan.';
      case 'wrong-password':
        return 'Kata sandi salah.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'weak-password':
        return 'Kata sandi terlalu lemah.';
      case 'network-request-failed':
        return 'Gagal terhubung ke jaringan.';
      default:
        return 'Terjadi kesalahan.';
    }
  }

  /// Fungsi untuk mengatur status loading
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// Fungsi untuk reset form
  void resetForm() {
    enteredEmail = '';
    enteredPassword = '';
    notifyListeners();
  }
}
