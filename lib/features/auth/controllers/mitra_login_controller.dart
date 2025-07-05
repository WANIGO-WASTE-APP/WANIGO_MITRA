import 'package:flutter/material.dart';

class MitraLoginController {
  // Controller untuk email
  final TextEditingController emailController = TextEditingController();
  
  // State untuk validasi email
  bool isEmailValid = true;
  String emailErrorMessage = '';
  
  // State untuk status registrasi email: 0 = belum terdaftar, 1 = sudah terdaftar
  int emailStatus = 1;
  
  // Regular expression untuk validasi format email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  // List email yang sudah terdaftar (dummy data)
  final List<String> registeredEmails = [
    'admin@banksampah.com',
    'test@banksampah.com',
    'wanigo@banksampah.com'
  ];

  // Dispose controller saat tidak digunakan lagi
  void dispose() {
    emailController.dispose();
  }
  
  // Fungsi untuk validasi format email
  bool validateEmail(String email) {
    if (email.isEmpty) {
      isEmailValid = false;
      emailErrorMessage = 'Email tidak boleh kosong';
      return false;
    } else if (!emailRegExp.hasMatch(email)) {
      isEmailValid = false;
      emailErrorMessage = 'Format email tidak valid';
      return false;
    } else {
      isEmailValid = true;
      emailErrorMessage = '';
      return true;
    }
  }

  // Fungsi untuk memeriksa apakah email sudah terdaftar
  int checkEmailStatus(String email) {
    // Cek dari list email terdaftar
    if (registeredEmails.contains(email.trim())) {
      return 1; // Sudah terdaftar
    }
    return 0; // Belum terdaftar
  }
}