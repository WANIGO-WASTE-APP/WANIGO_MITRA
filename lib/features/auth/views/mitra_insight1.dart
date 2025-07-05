// File: lib/features/auth/views/mitra_insight1.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart' as wanigo;
import '../../../widgets/global_app_bar.dart'; // Import GlobalAppBar lokal 
import '../../profil/bindings/profile_binding.dart'; // Path yang benar
import '../../profil/mitra_step1.dart'; // Path yang benar
import 'package:wanigo_mitra/features/auth/views/bank_type.dart'; // Import dari file lama

class MitraInsightScreen extends StatefulWidget {
  final String email;
  final String name;
  final String phone;

  const MitraInsightScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  State<MitraInsightScreen> createState() => _MitraInsightScreenState();
}

class _MitraInsightScreenState extends State<MitraInsightScreen> {
  // Selected status option
  String? _selectedStatus;
  final TextEditingController _accessCodeController = TextEditingController();
  bool _showAccessCodeError = false;

  @override
  void initState() {
    super.initState();
    _accessCodeController.addListener(() {
      // Reset error when user types
      if (_showAccessCodeError) {
        setState(() {
          _showAccessCodeError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _accessCodeController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Pastikan ScreenUtil sudah diinisialisasi
    ScreenUtil.init(
      context, 
      designSize: const Size(393, 852), 
      minTextAdapt: true,
      splitScreenMode: true,
    );
    
    return Scaffold(
      backgroundColor: Colors.white,
      // Menggunakan GlobalAppBar lokal
      appBar: const GlobalAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  wanigo.GlobalText(
                    text: 'Status Bank Sampah',
                    variant: wanigo.TextVariant.h4,
                    color: wanigo.AppColors.gray800,
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Subtitle
                  wanigo.GlobalText(
                    text: 'Pilih status bank sampah untuk melanjutkan',
                    variant: wanigo.TextVariant.mediumRegular,
                    color: wanigo.AppColors.gray600,
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Question
                  wanigo.GlobalText(
                    text: 'Apakah bank sampah anda sudah pernah terdaftar di aplikasi WANIGO! sebelumnya?',
                    variant: wanigo.TextVariant.mediumMedium,
                    color: wanigo.AppColors.gray800,
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Option buttons
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedStatus = 'Iya, sudah';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _selectedStatus == 'Iya, sudah' 
                                    ? wanigo.AppColors.blue600
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: _selectedStatus == 'Iya, sudah'
                                    ? Border.all(
                                        color: wanigo.AppColors.blue200,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: wanigo.GlobalText(
                                text: 'Iya, sudah',
                                variant: wanigo.TextVariant.mediumMedium,
                                color: _selectedStatus == 'Iya, sudah'
                                    ? Colors.white
                                    : wanigo.AppColors.gray800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedStatus = 'Tidak, belum';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _selectedStatus == 'Tidak, belum'
                                    ? wanigo.AppColors.blue600
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: _selectedStatus == 'Tidak, belum'
                                    ? Border.all(
                                        color: wanigo.AppColors.blue200,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: wanigo.GlobalText(
                                text: 'Tidak, Belum',
                                variant: wanigo.TextVariant.mediumMedium,
                                color: _selectedStatus == 'Tidak, belum'
                                    ? Colors.white
                                    : wanigo.AppColors.gray800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Access code input field - only shown if "Iya, sudah" is selected
                  if (_selectedStatus == 'Iya, sudah') ...[
                    SizedBox(height: 24),
                    
                    wanigo.GlobalText(
                      text: 'Masukkan kode akses bank sampah',
                      variant: wanigo.TextVariant.mediumMedium,
                      color: wanigo.AppColors.gray800,
                    ),
                    
                    SizedBox(height: 12),
                    
                    TextField(
                      controller: _accessCodeController,
                      decoration: InputDecoration(
                        hintText: 'BANKSAMPAHKAWANSBY12',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _showAccessCodeError ? Colors.red : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _showAccessCodeError ? Colors.red : wanigo.AppColors.blue600),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 8),
                    
                    if (_showAccessCodeError)
                      wanigo.GlobalText(
                        text: 'Perhatikan! Kode bank sampah tidak ditemukan!',
                        variant: wanigo.TextVariant.smallMedium,
                        color: Colors.red,
                      ),
                    
                    if (!_showAccessCodeError)
                      wanigo.GlobalText(
                        text: 'Note: dengan ini anda akan terdaftar sebagai petugas pada bank sampah tersebut',
                        variant: wanigo.TextVariant.smallRegular,
                        color: wanigo.AppColors.gray600,
                      ),
                  ],
                ],
              ),
            ),
          ),
          
          // Continue button positioned higher
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40), // More bottom padding
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: wanigo.GlobalButton(
                text: 'Lanjutkan',
                variant: wanigo.ButtonVariant.large,
                style: wanigo.ButtonStyle.primary,
                onPressed: (_selectedStatus != null && 
                          (_selectedStatus == 'Tidak, belum' || 
                           (_selectedStatus == 'Iya, sudah' && _accessCodeController.text.isNotEmpty)))
                  ? () {
                      // Validate code if "Iya, sudah" is selected
                      if (_selectedStatus == 'Iya, sudah') {
                        // Mock validation - consider this a "known code"
                        final knownCode = "BANKSAMPAHKAWANSBY12";
                        
                        if (_accessCodeController.text != knownCode) {
                          setState(() {
                            _showAccessCodeError = true;
                          });
                          return; // Don't navigate if code is invalid
                        }
                        
                        print('Access code valid: ${_accessCodeController.text}');
                      }
                      
                      // If code is valid or "Tidak, belum" was selected, navigate
                      print('Selected status: $_selectedStatus');
                      
                      // Gunakan ProfileBinding untuk mengatasi error ScreenUtil
                      ProfileBinding.ensureInitialized(context);
                      
                      // Navigate based on selection
                      if (_selectedStatus == 'Tidak, belum') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BankTypeScreen(
                              email: widget.email,
                              name: widget.name,
                              phone: widget.phone,
                            ),
                          ),
                        );
                      } else {
                        // Handle navigation for "Iya, sudah" with valid code
                        // Add navigation logic here using ProfileBinding & ProfileScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              email: widget.email,
                              name: widget.name,
                              phone: widget.phone,
                              bankType: 'existing', // Assuming 'existing' bank type for 'Iya, sudah' option
                            ),
                          ),
                        );
                      }
                    }
                  : null, // Disable button if no option selected or if code is required but empty
              ),
            ),
          ),
        ],
      ),
    );
  }
}