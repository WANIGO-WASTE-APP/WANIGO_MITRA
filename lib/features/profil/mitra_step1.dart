import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/wanigo_ui.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String email;
  final String name;
  final String phone;
  final String bankType;

  const ProfileScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.phone,
    required this.bankType,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  // Step 1 controllers
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  // Step 2 controllers
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  // Step 3 variables
  File? _profileImage;
  bool _isCompleted = false;
  
  @override
  void dispose() {
    _pageController.dispose();
    _bankNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handling back navigation manually
        if (_currentStep > 0 && !_isCompleted) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return false;
        }
        return true;
      },
      child: BaseWidgetContainer(
        appBar: GlobalAppBar(
          showBackButton: true,
          actions: [],
        ),
        activateScroll: false,
        body: Column(
          children: [
            // Progress indicator
            if (!_isCompleted) _buildProgressBar(),
            
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: [
                  _buildStep1(),
                  _buildStep2(),
                  _buildStep3(),
                  _buildCompletionScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Progress bar
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.blue100,
            ),
            child: Row(
              children: [
                Flexible(
                  flex: _currentStep + 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: AppColors.blue500,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3 - (_currentStep + 1),
                  child: Container(),
                ),
              ],
            ),
          ),
          
          // Dot indicator
          Positioned(
            left: (MediaQuery.of(context).size.width - 40) * ((_currentStep + 1) / 3),
            child: Container(
              width: 12.r,
              height: 12.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.blue500, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // STEP 1: Profil Bank Sampah
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              GlobalText(
                text: 'Profil Bank Sampah',
                variant: TextVariant.h3,
                color: AppColors.gray600,
              ),
              SizedBox(width: 8.w),
              GlobalText(
                text: '1 dari 3',
                variant: TextVariant.h3,
                color: AppColors.blue500,
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Bank name field
          GlobalText(
            text: 'Nama Lengkap Usaha Bank Sampah',
            variant: TextVariant.mediumSemiBold,
            color: AppColors.gray600,
          ),
          
          SizedBox(height: 8.h),
          
          GlobalTextField(
            controller: _bankNameController,
            hint: 'Masukkan nama bank sampah',
          ),
          
          SizedBox(height: 24.h),
          
          // Phone field
          GlobalText(
            text: 'Nomor Telepon Usaha',
            variant: TextVariant.mediumSemiBold,
            color: AppColors.gray600,
          ),
          
          SizedBox(height: 8.h),
          
          GlobalTextField(
            controller: _phoneController,
            hint: 'Masukkan nomor telepon anda',
            keyboardType: TextInputType.phone,
          ),
          
          SizedBox(height: 8.h),
          
          // Use account phone link
          GestureDetector(
            onTap: () {
              setState(() {
                _phoneController.text = widget.phone;
              });
            },
            child: GlobalText(
              text: 'Klik disini untuk gunakan nomor telepon akun',
              variant: TextVariant.smallRegular,
              color: AppColors.blue500,
              decoration: TextDecoration.underline,
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Email field
          GlobalText(
            text: 'Alamat Email Usaha',
            variant: TextVariant.mediumSemiBold,
            color: AppColors.gray600,
          ),
          
          SizedBox(height: 8.h),
          
          GlobalTextField(
            controller: _emailController,
            hint: 'Masukkan alamat email usaha disini',
            keyboardType: TextInputType.emailAddress,
          ),
          
          SizedBox(height: 8.h),
          
          // Use account email link
          GestureDetector(
            onTap: () {
              setState(() {
                _emailController.text = widget.email;
              });
            },
            child: GlobalText(
              text: 'Klik disini untuk gunakan alamat email akun',
              variant: TextVariant.smallRegular,
              color: AppColors.blue500,
              decoration: TextDecoration.underline,
            ),
          ),
          
          SizedBox(height: 40.h),
          
          // Continue button
          GlobalButton(
            text: 'Lanjutkan',
            variant: ButtonVariant.large,
            style: _isStep1Valid() ? ButtonStyle.primary : ButtonStyle.secondary,
            onPressed: () {
              if (_isStep1Valid()) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _showErrorSnackBar('Harap lengkapi semua data');
              }
            },
          ),
        ],
      ),
    );
  }
  
  bool _isStep1Valid() {
    return _bankNameController.text.isNotEmpty &&
           _phoneController.text.isNotEmpty &&
           _emailController.text.isNotEmpty;
  }
  
  // STEP 2: Alamat dan Jadwal
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              GlobalText(
                text: 'Profil Bank Sampah',
                variant: TextVariant.h3,
                color: AppColors.gray600,
              ),
              SizedBox(width: 8.w),
              GlobalText(
                text: '2 dari 3',
                variant: TextVariant.h3,
                color: AppColors.blue500,
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Date field
          GlobalText(
            text: 'Tanggal Jadwal Setoran Sampah',
            variant: TextVariant.mediumSemiBold,
            color: AppColors.gray600,
          ),
          
          SizedBox(height: 8.h),
          
          // Date input field
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: GlobalTextField(
                controller: _dateController,
                hint: 'dd/mm/yyyy',
                suffixIcon: Icon(Icons.calendar_today, color: AppColors.gray400),
              ),
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Address field
          GlobalText(
            text: 'Alamat Usaha',
            variant: TextVariant.mediumSemiBold,
            color: AppColors.gray600,
          ),
          
          SizedBox(height: 8.h),
          
          GlobalTextField(
            controller: _addressController,
            hint: 'Masukkan alamat usaha anda disini',
            prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.gray400),
          ),
          
          SizedBox(height: 12.h),
          
          // Use current location button
          Container(
            decoration: BoxDecoration(
              color: AppColors.blue100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  // Logic to get current location would go here
                  setState(() {
                    _addressController.text = "Jl. Contoh No. 123, Surabaya";
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location, color: AppColors.blue500, size: 18.r),
                      SizedBox(width: 8.w),
                      GlobalText(
                        text: 'Klik disini untuk gunakan lokasi saat ini',
                        variant: TextVariant.smallMedium,
                        color: AppColors.blue500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Description field
          GlobalText(
            text: 'Deskripsi Usaha',
            variant: TextVariant.mediumSemiBold,
            color: AppColors.gray600,
          ),
          
          SizedBox(height: 8.h),
          
          Container(
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.gray200),
            ),
            child: TextField(
              controller: _descriptionController,
              maxLines: null,
              maxLength: 150,
              decoration: InputDecoration(
                hintText: 'Deskripsikan usaha bank sampah Anda disini. (maksimal 150 kata)',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.gray400,
                ),
                contentPadding: EdgeInsets.all(16.r),
                border: InputBorder.none,
                counterText: '${_descriptionController.text.length}/150',
                counterStyle: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.gray400,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 40.h),
          
          // Continue button
          GlobalButton(
            text: 'Lanjutkan',
            variant: ButtonVariant.large,
            style: _isStep2Valid() ? ButtonStyle.primary : ButtonStyle.secondary,
            onPressed: () {
              if (_isStep2Valid()) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _showErrorSnackBar('Harap lengkapi semua data');
              }
            },
          ),
        ],
      ),
    );
  }
  
  bool _isStep2Valid() {
    return _addressController.text.isNotEmpty &&
           _dateController.text.isNotEmpty;
  }
  
  // STEP 3: Upload Foto
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              GlobalText(
                text: 'Profil Bank Sampah',
                variant: TextVariant.h3,
                color: AppColors.gray600,
              ),
              SizedBox(width: 8.w),
              GlobalText(
                text: '3 dari 3',
                variant: TextVariant.h3,
                color: AppColors.blue500,
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Upload photo
          GlobalText(
            text: 'Pilih Foto Profil Usaha',
            variant: TextVariant.mediumSemiBold,
            color: AppColors.gray600,
          ),
          
          SizedBox(height: 16.h),
          
          // Photo selector
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                color: AppColors.blue100,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.blue300),
              ),
              child: _profileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        _profileImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 64.r,
                          color: AppColors.blue600,
                        ),
                        SizedBox(height: 16.h),
                        GlobalText(
                          text: 'Pilih foto dari galeri',
                          variant: TextVariant.mediumSemiBold,
                          color: AppColors.blue600,
                        ),
                        SizedBox(height: 4.h),
                        GlobalText(
                          text: '(Pastikan foto lanskap dan resolusi 393x180 piksel)',
                          variant: TextVariant.smallRegular,
                          color: AppColors.gray400,
                        ),
                      ],
                    ),
            ),
          ),
          
          SizedBox(height: 40.h),
          
          // Continue button
          GlobalButton(
            text: 'Lanjutkan',
            variant: ButtonVariant.large,
            style: _profileImage != null ? ButtonStyle.primary : ButtonStyle.secondary,
            onPressed: () {
              if (_profileImage != null) {
                setState(() {
                  _isCompleted = true;
                });
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _showErrorSnackBar('Harap pilih foto profil');
              }
            },
          ),
        ],
      ),
    );
  }
  
  // Completion Screen
  Widget _buildCompletionScreen() {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Celebration icon
          Icon(
            Icons.celebration,
            size: 80.r,
            color: AppColors.blue500,
          ),
          
          SizedBox(height: 24.h),
          
          // Success text
          GlobalText(
            text: 'Selamat! Akun Admin',
            variant: TextVariant.h3,
            color: AppColors.gray600,
            textAlign: TextAlign.center,
          ),
          
          GlobalText(
            text: 'Anda Sudah Siap',
            variant: TextVariant.h3,
            color: AppColors.gray600,
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 16.h),
          
          GlobalText(
            text: 'Tingkatkan omset bisnis dengan menggunakan fitur unggulan WANIGO untuk efisiensi manajemen data setoran dan analisis performa usaha bank sampah Anda.',
            variant: TextVariant.mediumRegular,
            color: AppColors.gray400,
            textAlign: TextAlign.center,
          ),
          
          Spacer(),
          
          // Start exploring button
          GlobalButton(
            text: 'Mulai Jelajahi Fitur WANIGO!',
            variant: ButtonVariant.large,
            style: ButtonStyle.primary,
            onPressed: () {
              // Navigate to WanigoHomePage
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ],
      ),
    );
  }
  
  // Helper Methods
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blue500,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }
  
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GlobalText(
          text: message,
          variant: TextVariant.smallMedium,
          color: Colors.white,
        ),
        backgroundColor: AppColors.red500,
      ),
    );
  }
}