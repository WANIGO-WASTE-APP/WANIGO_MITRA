// File: lib/features/profil/bindings/profile_binding.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileBinding {
  static void ensureInitialized(BuildContext context) {
    // Tidak perlu cek apakah sudah diinisialisasi, langsung inisialisasi saja
    // Karena ScreenUtil.init() aman dipanggil berulang kali
    ScreenUtil.init(
      context,
      designSize: const Size(393, 852), // iPhone 14 Pro size
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }
}