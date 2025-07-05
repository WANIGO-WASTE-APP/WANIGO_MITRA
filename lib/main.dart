import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart';
import 'package:wanigo_mitra/features/item/screen/wastelist.dart'; 
import 'package:wanigo_mitra/features/beli/views/mitra_pembelian_sampah_screen.dart'; 
import 'package:wanigo_mitra/features/beli/views/mitra_setoran_sampah_screen.dart'; 
import 'package:wanigo_mitra/features/beli/views/mitra_detail_setoran_screen.dart'; 
import 'package:wanigo_mitra/features/beli/views/mitra_daftar_item_screen.dart'; 
import 'splashscreen.dart';

import 'package:wanigo_mitra/features/home/views/home.dart'; // Path ke WanigoHomePage

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Penting: Wrap dengan ScreenUtilInit untuk mengatasi error LateInitializationError
    return ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone 14 Pro size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'WANIGO! MITRA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.blue600,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.blue500,
              primary: AppColors.blue600,
              secondary: AppColors.orange500,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.gray700),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // Tambahkan theme lain sesuai kebutuhan
          ),
          home: const SplashScreen(), // SplashScreen tetap sebagai halaman awal
          getPages: [
            // Definisikan routes untuk navigasi dengan GetX
            GetPage(name: '/', page: () => const SplashScreen()),
            GetPage(name: '/home', page: () => const WanigoHomePage()),
            GetPage(name: '/waste-catalog', page: () => const WasteItemCatalogScreen()),
            // Tambah route untuk fitur beli
            GetPage(name: '/pembelian-sampah', page: () => MitraPembelianSampahScreen()),
            GetPage(name: '/setoran-sampah', page: () => MitraSetoranSampahScreen()),
            GetPage(name: '/setoran-sampah/detail', page: () => const MitraDetailSetoranScreen()),
            GetPage(name: '/daftar-item', page: () => MitraDaftarItemScreen()),
            // Tambahkan route lain sesuai kebutuhan
            // GetPage(name: '/customer-list', page: () => const CustomerListScreen()),
            // GetPage(name: '/cashbook', page: () => const CashbookScreen()),
            // GetPage(name: '/sell-waste', page: () => const SellWasteScreen()),
            // GetPage(name: '/smart-voice', page: () => const WanigoSmartVoiceScreen()),
            // GetPage(name: '/smart-scan', page: () => const WanigoSmartScanScreen()),
            // GetPage(name: '/assistant-ai', page: () => const WanigoAssistantAIScreen()),
          ],
        );
      },
    );
  }
}