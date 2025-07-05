import 'package:flutter/material.dart';
import 'package:wanigo_mitra/features/auth/views/bank_type.dart'; // Import halaman bank type
import 'package:wanigo_mitra/features/auth/views/mitra_insight1.dart'; // Import MitraInsightScreen
import '../../../widgets/global_app_bar.dart'; // Import GlobalAppBar lokal

class MitraFormScreen extends StatefulWidget {
  final String? email;
  
  // Terima parameter email opsional
  const MitraFormScreen({
    Key? key, 
    this.email,
  }) : super(key: key);

  @override
  State<MitraFormScreen> createState() => _MitraFormScreenState();
}

class _MitraFormScreenState extends State<MitraFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _allFieldsFilled = false;

  @override
  void initState() {
    super.initState();
    // Jika email diberikan dalam parameter, isi field email
    if (widget.email != null && widget.email!.isNotEmpty) {
      _emailController.text = widget.email!;
    }
    
    // Tambahkan listener ke semua controller teks untuk memeriksa apakah semua field diisi
    _nameController.addListener(_checkAllFieldsFilled);
    _emailController.addListener(_checkAllFieldsFilled);
    _phoneController.addListener(_checkAllFieldsFilled);
    _passwordController.addListener(_checkAllFieldsFilled);
    _confirmPasswordController.addListener(_checkAllFieldsFilled);
  }

  void _checkAllFieldsFilled() {
    setState(() {
      _allFieldsFilled = _nameController.text.isNotEmpty &&
                         _emailController.text.isNotEmpty &&
                         _phoneController.text.isNotEmpty &&
                         _passwordController.text.isNotEmpty &&
                         _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Gunakan GlobalAppBar baru
      appBar: const GlobalAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        showBackButton: true,
        // Hapus title parameter karena kita akan menggunakan pola desain lama
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan emoji pensil
              Row(
                children: [
                  const Text(
                    'Form Pendaftaran',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '✏️', // Emoji pensil alih-alih gambar
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Menampilkan teks berbeda berdasarkan apakah email telah diisi
              widget.email != null && widget.email!.isNotEmpty 
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subjudul email
                    Text(
                      'Lanjutkan proses pendaftaran dengan email:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    
                    // Tampilan email
                    Text(
                      widget.email!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Field Email
                    const Text(
                      'Alamat Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan alamat email anda',
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
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              
              const SizedBox(height: 24),
              
              // Field Nama Lengkap
              const Text(
                'Nama Lengkap Admin Bank Sampah',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 8),
              
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan nama lengkap anda',
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
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Field Nomor Telepon
              const Text(
                'Nomor Telepon Nasabah',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 8),
              
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: 'Masukkan nomor telepon anda',
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
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              
              const SizedBox(height: 16),
              
              // Field Kata Sandi
              const Text(
                'Kata Sandi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 8),
              
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan kata sandi anda disini',
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
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  errorText: _passwordError,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Field Ulangi Kata Sandi
              const Text(
                'Ulangi Kata Sandi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 8),
              
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan ulang kata sandi anda disini',
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
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0A5AEB)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  errorText: _confirmPasswordError,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Tombol Lanjutkan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _allFieldsFilled ? () {
                    // Validasi formulir saat tombol ditekan
                    _validateForm();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF0A5AEB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: const Color(0xFF92B5FF),
                    disabledForegroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Lanjutkan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Validasi formulir
  bool _validateForm() {
    bool isValid = true;
    
    // Reset pesan kesalahan
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;
    });
    
    // Periksa apakah kata sandi cocok
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = 'Kata sandi tidak cocok';
      });
      isValid = false;
    }
    
    // Jika formulir valid, navigasi ke layar MitraInsightScreen
    if (isValid) {
      print('Form is valid');
      print('Email: ${_emailController.text}');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      
      // Navigasi ke MitraInsightScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MitraInsightScreen(
            email: _emailController.text,
            name: _nameController.text,
            phone: _phoneController.text,
          ),
        ),
      );
    }
    
    return isValid;
  }
}