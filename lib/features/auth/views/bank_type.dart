// File: lib/features/auth/views/bank_type.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart' as wanigo;
import '../../../widgets/global_app_bar.dart'; 
import '../../profil/bindings/profile_binding.dart';
import '../../profil/mitra_step1.dart';

class BankTypeScreen extends StatefulWidget {
  final String email;
  final String name;
  final String phone;

  const BankTypeScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  State<BankTypeScreen> createState() => _BankTypeScreenState();
}

class _BankTypeScreenState extends State<BankTypeScreen> {
  String? _selectedBankType;

  // Fungsi untuk navigasi ke ProfileScreen
  void _navigateToProfileScreen(String bankType) {
    // Gunakan ProfileBinding untuk mengatasi error ScreenUtil
    ProfileBinding.ensureInitialized(context);
    
    // Navigasi ke ProfileScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          email: widget.email,
          name: widget.name,
          phone: widget.phone,
          bankType: bankType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            wanigo.GlobalText(
              text: 'Tipe Bank Sampah',
              variant: wanigo.TextVariant.h4,
              color: wanigo.AppColors.gray700,
            ),
            const SizedBox(height: 8),
            wanigo.GlobalText(
              text: 'Silahkan pilih salah satu dari 2 pilihan berikut',
              variant: wanigo.TextVariant.smallRegular,
              color: wanigo.AppColors.gray500,
            ),
            const SizedBox(height: 24),
            
            // Bank Sampah Unit option
            _buildBankTypeOption(
              title: 'Bank Sampah Unit',
              description: 'Diperuntukkan pengelolaan sampah di lingkungan Rumah Tangga',
              type: 'unit',
              iconPath: 'assets/house.png',
            ),
            
            const SizedBox(height: 16),
            
            // Bank Sampah Induk option
            _buildBankTypeOption(
              title: 'Bank Sampah Induk',
              description: 'Diperuntukkan area yang lebih luas yaitu beberapa bank sampah unit',
              type: 'induk',
              iconPath: 'assets/corp.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankTypeOption({
    required String title,
    required String description,
    required String type,
    required String iconPath,
  }) {
    bool isSelected = _selectedBankType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBankType = type;
        });
        
        // Langsung navigasi ke ProfileScreen saat card diklik
        _navigateToProfileScreen(type);
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? wanigo.AppColors.blue500 : wanigo.AppColors.gray300,
            width: isSelected ? 2 : 0.75,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: wanigo.AppColors.blue500.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Stack(
          children: [
            // Main Row Content
            Row(
              children: [
                // Text content taking 75% of width
                Expanded(
                  flex: 75, // 75% of the width
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        wanigo.GlobalText(
                          text: title,
                          variant: wanigo.TextVariant.mediumSemiBold,
                          color: wanigo.AppColors.gray700,
                        ),
                        const SizedBox(height: 8),
                        wanigo.GlobalText(
                          text: description,
                          variant: wanigo.TextVariant.smallRegular,
                          color: wanigo.AppColors.gray500,
                        ),
                      ],
                    ),
                  ),
                ),
                // Empty space for icon (25% of width)
                Expanded(
                  flex: 25, // 25% of the width
                  child: Container(),
                ),
              ],
            ),

            // Icon positioned on right
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}