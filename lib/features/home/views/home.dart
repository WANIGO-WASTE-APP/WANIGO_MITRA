import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart' hide GlobalAppBar;
import 'package:wanigo_mitra/widgets/global_app_bar.dart';
import 'package:wanigo_mitra/features/item/screen/wastelist.dart'; // Import yang benar untuk WasteItemCatalogScreen

// Konstanta screen untuk navigasi
const String kWasteItemCatalogScreen = 'WasteItemCatalogScreen';
const String kCustomerListScreen = 'CustomerListScreen';
const String kCashbookScreen = 'CashbookScreen';
const String kSellWasteScreen = 'SellWasteScreen';
const String kBuyWasteScreen = 'BuyWasteScreen';
const String kWanigoSmartVoiceScreen = 'WanigoSmartVoiceScreen';
const String kWanigoSmartScanScreen = 'WanigoSmartScanScreen';
const String kWanigoAssistantAIScreen = 'WanigoAssistantAIScreen';

class WanigoHomePage extends StatefulWidget {
  const WanigoHomePage({super.key});

  @override
  State<WanigoHomePage> createState() => _WanigoHomePageState();
}

class _WanigoHomePageState extends State<WanigoHomePage> {
  // Registration state: 0 = unregistered, 1 = registered
  final int _registrationState = 0;
  
  // Current active tab index
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Content layer - full white background
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian atas dengan padding horizontal yang konsisten 20px
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Card - Full width
                      _buildProfileCard(),
                      
                      SizedBox(height: 14.h),
                      
                      // Cash & Customers Info
                      _buildCashAndCustomersSection(),
                      
                      SizedBox(height: 18.h),
                      
                      // Calendar Card (mengadopsi style dari NasabahHomeScreen)
                      _buildScheduleCard(),
                      
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
                
                // Section with white background - Features and Setoran
                Container(
                  width: double.infinity, // Full width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFEAECF0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.r), // Konsisten 20px padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Inventory Section (if unregistered)
                        if (_registrationState == 0) _buildInventorySection(),
                        
                        // Action Buttons Row
                        _buildActionButtons(),
                        
                        // Transaction Cards
                        _buildTransactionCards(),
                        
                        SizedBox(height: 32.h),
                        
                        // App Features - WANIGO! Mitra
                        GlobalText(
                          text: "Fitur Aplikasi WANIGO! Mitra",
                          variant: TextVariant.h5,
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        _buildFeatureIcons(isMitraAI: false),
                        
                        SizedBox(height: 32.h),
                        
                        // App Features - WANIGO! Mitra AI
                        GlobalText(
                          text: "Fitur Aplikasi WANIGO! Mitra AI",
                          variant: TextVariant.h5,
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        _buildFeatureIcons(isMitraAI: true),
                        
                        SizedBox(height: 32.h),
                        
                        // Current Deposit Section
                        _buildDepositSection(),
                        
                        // Current Requests Section
                        if (_registrationState == 0) _buildRequestsSection(),
                        
                        // Tambah padding ekstra untuk memastikan bg_main_bottom terlihat
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 20.r, // Konsisten 20px
      title: Image.asset(
        'assets/images/appbar_logo.png',
        height: 30.h,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading appbar_logo.png: $error');
          return Text(
            'WANIGO!',
            style: TextStyle(
              color: AppColors.blue500,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.r), // Konsisten 20px
          child: Image.asset(
            'assets/images/lonceng.png',
            width: 24.r,
            height: 24.r,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading lonceng.png: $error');
              return Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 24.r,
              );
            },
          ),
        ),
      ],
    );
  }
  
  // Profile Card Widget
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFCACACA)),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.person, color: Colors.black, size: 24.r),
              ),
              SizedBox(width: 12.r),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    text: "Hai, Adhitya Pratama",
                    variant: TextVariant.smallBold,
                  ),
                  GlobalText(
                    text: "Petugas Bank Sampah Kawan Surabaya",
                    variant: TextVariant.xSmallRegular,
                    color: AppColors.gray600,
                  ),
                ],
              ),
              Spacer(),
              GlobalText(
                text: "0",
                variant: TextVariant.smallBold,
                color: AppColors.gray900,
              ),
              SizedBox(width: 4.r),
              GlobalText(
                text: "poin",
                variant: TextVariant.xSmallRegular,
                color: AppColors.gray600,
              ),
            ],
          ),
          SizedBox(height: 16.r),
          Divider(color: AppColors.gray200),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _registrationState == 0
                  ? GlobalText(
                      text: "Cari Rekan Bisnis Penjualan Sampah",
                      variant: TextVariant.smallBold,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          text: "Nasabah Bank Sampah Induk Mojo",
                          variant: TextVariant.smallBold,
                        ),
                        GlobalText(
                          text: "Jl Jojoran Baru III, No 30, Kelurahan Mojo",
                          variant: TextVariant.xSmallRegular,
                          color: AppColors.gray600,
                        ),
                      ],
                    ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.blue500),
                ),
                child: Icon(Icons.keyboard_arrow_down, color: AppColors.blue500, size: 20.r),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Cash and Customers Section Widget
  Widget _buildCashAndCustomersSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFCACACA)),
      ),
      padding: EdgeInsets.all(16.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Saldo Kas Usaha
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                text: "Saldo Kas Usaha",
                variant: TextVariant.smallRegular,
                color: AppColors.gray600,
              ),
              SizedBox(height: 4.r),
              Row(
                children: [
                  GlobalText(
                    text: _registrationState == 0 ? "Rp0" : "Rp10.000.000",
                    variant: TextVariant.h5,
                  ),
                  SizedBox(width: 4.r),
                  Icon(Icons.visibility_outlined, size: 20.r, color: AppColors.gray600),
                ],
              ),
            ],
          ),
          // Total Nasabah
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GlobalText(
                text: "Total Nasabah",
                variant: TextVariant.smallRegular,
                color: AppColors.gray600,
              ),
              SizedBox(height: 4.r),
              Row(
                children: [
                  GlobalText(
                    text: _registrationState == 0 ? "0" : "1000",
                    variant: TextVariant.h5,
                  ),
                  SizedBox(width: 8.r),
                  Image.asset(
                    'assets/icons/nasabah.png',
                    width: 24.r,
                    height: 24.r,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading nasabah.png: $error');
                      return Icon(
                        Icons.people,
                        size: 24.r,
                        color: AppColors.blue500,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Inventory Section Widget
  Widget _buildInventorySection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFCACACA)),
      ),
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(bottom: 16.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                text: "Invetaris Stok Sampah",
                variant: TextVariant.smallRegular,
                color: AppColors.gray600,
              ),
              GlobalText(
                text: "1000 Kg",
                variant: TextVariant.h5,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GlobalText(
                text: "Total Sub Kategori",
                variant: TextVariant.smallRegular,
                color: AppColors.gray600,
              ),
              GlobalText(
                text: "10",
                variant: TextVariant.h5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action Buttons Widget
  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.r),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue100,
                foregroundColor: AppColors.blue500,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 12.r),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text("Perbarui Kas Usaha"),
            ),
          ),
          SizedBox(width: 12.r),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue100,
                foregroundColor: AppColors.blue500,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 12.r),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text("Lihat Detail Invetaris"),
            ),
          ),
        ],
      ),
    );
  }

  // Transaction Cards Widget
  Widget _buildTransactionCards() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.r),
      child: Row(
        children: [
          Expanded(
            child: _buildTransactionCard(
              iconPath: 'assets/icons/pembelian.png',
              iconColor: Colors.amber,
              title: "Pembelian Sampah",
              amount: _registrationState == 0 ? "Rp0" : "Rp10.000",
              status: _registrationState == 0 ? "Belum ada transaksi" : "10 Transaksi Hari ini",
            ),
          ),
          SizedBox(width: 12.r),
          Expanded(
            child: _buildTransactionCard(
              iconPath: 'assets/icons/penjualan.png',
              iconColor: Colors.orange,
              title: "Penjualan Sampah",
              amount: "Rp0",
              status: "Belum ada transaksi",
            ),
          ),
        ],
      ),
    );
  }

  // Single Transaction Card Widget
  Widget _buildTransactionCard({
    required String iconPath,
    required Color iconColor,
    required String title,
    required String amount,
    required String status,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFCACACA)),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.r),
          Row(
            children: [
              Image.asset(
                iconPath,
                width: 40.r,
                height: 40.r,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading $iconPath: $error');
                  return Icon(
                    iconPath.contains('beli') ? Icons.shopping_cart : Icons.shopping_bag,
                    color: iconColor,
                    size: 40.r,
                  );
                },
              ),
              SizedBox(width: 8.r),
              Expanded(
                child: GlobalText(
                  text: title,
                  variant: TextVariant.xSmallRegular,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.r),
          GlobalText(
            text: amount,
            variant: TextVariant.smallBold,
          ),
          SizedBox(height: 8.r),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.r),
            decoration: BoxDecoration(
              color: AppColors.gray200,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: GlobalText(
                text: status,
                variant: TextVariant.xSmallRegular,
                color: AppColors.gray600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Schedule Card Widget (mengadopsi style dari NasabahHomeScreen)
  Widget _buildScheduleCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFCACACA)),
      ),
      padding: EdgeInsets.all(12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Squared date box with fixed dimensions
          Container(
            width: 70.r,
            height: 90.r,
            decoration: BoxDecoration(
              color: AppColors.blue500,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalText(
                  text: "18",
                  variant: TextVariant.h4,
                  color: Colors.white,
                ),
                GlobalText(
                  text: "Sep",
                  variant: TextVariant.smallRegular,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.r),
                  padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 2.r),
                  decoration: BoxDecoration(
                    color: AppColors.blue900,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: GlobalText(
                    text: "Selasa",
                    variant: TextVariant.xSmallRegular,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.r),
          
          // Konten sebelah kanan
          Expanded(
            child: _registrationState == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Added line to the left of text
                      Row(
                        children: [
                          Container(
                            width: 4.r,
                            height: 16.r,
                            color: AppColors.blue500,
                            margin: EdgeInsets.only(right: 8.r),
                          ),
                          Expanded(
                            child: GlobalText(
                              text: "Jadwal Penjualan Sampah Anda Belum Dibuat.",
                              variant: TextVariant.smallBold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.r),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue500,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.r),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: const Text("Atur Jadwal Penjualan"),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScheduleItem(
                        color: AppColors.blue500,
                        title: "Jadwal Penimbangan Sampah",
                        date: "30 Maret 2025 (12 hari lagi)",
                      ),
                      SizedBox(height: 12.r),
                      _buildScheduleItem(
                        color: Colors.green,
                        title: "Jadwal Setoran Bank Sampah Induk",
                        date: "30 Maret 2025 (12 hari lagi)",
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // Schedule Item Widget
  Widget _buildScheduleItem({
    required Color color,
    required String title,
    required String date,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.r,
              height: 16.r,
              color: color,
              margin: EdgeInsets.only(right: 8.r),
            ),
            Expanded(
              child: GlobalText(
                text: title,
                variant: TextVariant.smallBold,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.r),
          child: GlobalText(
            text: date,
            variant: TextVariant.xSmallRegular,
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }

  // Feature Icons Widget (seperti NasabahHomeScreen)
  Widget _buildFeatureIcons({required bool isMitraAI}) {
    final features = isMitraAI
        ? [
            {'label': 'Smart Voice', 'image': 'icons/smartvoice.png', 'icon': Icons.mic, 'screen': kWanigoSmartVoiceScreen},
            {'label': 'Smart Scan', 'image': 'icons/smartscan.png', 'icon': Icons.scanner, 'screen': kWanigoSmartScanScreen},
            {'label': 'Assistant AI', 'image': 'icons/assistant.png', 'icon': Icons.smart_toy, 'screen': kWanigoAssistantAIScreen},
          ]
        : [
            {'label': 'Katalog', 'image': 'icons/katalog.png', 'icon': Icons.shop, 'screen': kWasteItemCatalogScreen},
            {'label': 'Nasabah', 'image': 'icons/nasabah.png', 'icon': Icons.people, 'screen': kCustomerListScreen},
            {'label': 'Buku Kas', 'image': 'icons/bukukas.png', 'icon': Icons.book, 'screen': kCashbookScreen},
            {'label': 'Jual', 'image': 'icons/jual.png', 'icon': Icons.upload, 'screen': kSellWasteScreen},
            {'label': 'Beli', 'image': 'icons/beli.png', 'icon': Icons.shopping_cart, 'screen': kBuyWasteScreen},
          ];

    return Row(
      mainAxisAlignment: isMitraAI ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
      children: features.map((f) {
        Widget featureItem = Column(
          children: [
            // Icon gambar diperbesar tanpa background bulat
            GestureDetector(
              onTap: () {
                final screenName = f['screen'] as String;
                
                // Menggunakan Get.toNamed dengan route yang sudah didefinisikan di GetMaterialApp
                if (screenName == kWasteItemCatalogScreen) {
                  Get.toNamed('/waste-catalog');
                } else if (screenName == kBuyWasteScreen) {
                  // Navigasi ke MitraPembelianSampahScreen
                  Get.toNamed('/pembelian-sampah');
                } else if (screenName == kCustomerListScreen) {
                  // Tampilkan log saja sampai screen diimplementasikan
                  debugPrint('Navigasi ke: $screenName (belum diimplementasikan)');
                  // Get.toNamed('/customer-list');
                } else {
                  // Screen lain
                  debugPrint('Navigasi ke: $screenName (belum diimplementasikan)');
                }
              },
              child: Image.asset(
                'assets/${f['image']}',
                width: 48.r,
                height: 48.r,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading ${f['image']}: $error');
                  return Icon(
                    f['icon'] as IconData,
                    color: AppColors.blue600,
                    size: 48.r,
                  );
                },
              ),
            ),
            SizedBox(height: 4.h),
            GlobalText(
              text: f['label'] as String,
              variant: TextVariant.xSmallMedium,
            ),
          ],
        );
        
        return isMitraAI 
          ? Padding(
              padding: EdgeInsets.only(right: 24.r),
              child: featureItem,
            )
          : featureItem;
      }).toList(),
    );
  }

  // Current Deposit Section Widget
  Widget _buildDepositSection() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.r),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalText(
                text: "Setoran Sampah Terkini",
                variant: TextVariant.h5,
              ),
              _buildViewAllButton(
                count: _registrationState == 0 ? "01" : "10",
                onTap: () => Get.toNamed("#"),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _registrationState == 0
              ? _buildEmptyStateCard("Belum ada pesanan terkini yang harus diselesaikan!")
              : _buildDepositCard(),
        ],
      ),
    );
  }

  // Current Requests Section Widget
  Widget _buildRequestsSection() {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.r),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalText(
                text: "Permintaan Terkini",
                variant: TextVariant.h5,
              ),
              _buildViewAllButton(
                count: "01",
                onTap: () => Get.toNamed("#"),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildEmptyStateCard("Belum ada permintaan sampah terkini dari pihak lain yang harus diselesaikan!"),
        ],
      ),
    );
  }

  Widget _buildEmptyStateCard(String message) {
    return Column(
      children: [
        Image.asset(
          'assets/icons/empty_box.png',
          width: 64.r,
          height: 64.r,
          color: AppColors.blue500,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading empty_box.png: $error');
            return Icon(
              Icons.inventory_2_outlined, 
              color: AppColors.blue500, 
              size: 64.r
            );
          },
        ),
        SizedBox(height: 16.r),
        GlobalText(
          text: message,
          textAlign: TextAlign.center,
          variant: TextVariant.smallRegular,
          color: AppColors.gray600,
        ),
      ],
    );
  }

  // View All Button Widget
  Widget _buildViewAllButton({required String count, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 2.r),
            decoration: BoxDecoration(
              color: AppColors.blue100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GlobalText(
              text: count,
              variant: TextVariant.smallBold,
              color: AppColors.blue500,
            ),
          ),
          SizedBox(width: 8.r),
          GlobalText(
            text: "Lihat Semua",
            variant: TextVariant.smallBold,
            color: AppColors.blue500,
          ),
        ],
      ),
    );
  }

  // Deposit Card Widget
  Widget _buildDepositCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFCACACA)),
      ),
      padding: EdgeInsets.all(16.r),
      child: InkWell(
        onTap: () => Get.toNamed("#"),
        borderRadius: BorderRadius.circular(12.r),
        child: Row(
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: AppColors.blue500,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/icons/send.png',
                width: 30.r,
                height: 30.r,
                color: Colors.white,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading send.png: $error');
                  return Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 30.r,
                  );
                },
              ),
            ),
            SizedBox(width: 16.r),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GlobalText(
                        text: "Kode Setoran",
                        variant: TextVariant.xSmallRegular,
                        color: AppColors.gray600,
                      ),
                      GlobalText(
                        text: "KWNA000001",
                        variant: TextVariant.xSmallBold,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GlobalText(
                        text: "Adhitya Pratama",
                        variant: TextVariant.smallBold,
                        color: AppColors.blue500,
                      ),
                      Icon(Icons.chevron_right, color: AppColors.gray400, size: 20.r),
                    ],
                  ),
                  SizedBox(height: 4.r),
                  GlobalText(
                    text: "Diajukan pada 15 Maret 2025",
                    variant: TextVariant.xSmallRegular,
                    color: AppColors.gray600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    // Daftar item untuk bottom navigation
    final List<Map<String, dynamic>> items = [
      {'image': 'icons/beranda.png', 'icon': Icons.home, 'label': 'Beranda'},
      {'image': 'icons/riwayat.png', 'icon': Icons.history, 'label': 'Riwayat'},
      {'image': 'icons/penjualan.png', 'icon': Icons.shopping_bag, 'label': 'Penjualan'},
      {'image': 'icons/laporan.png', 'icon': Icons.receipt_long, 'label': 'Laporan'},
      {'image': 'icons/profil.png', 'icon': Icons.person, 'label': 'Profil'},
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      selectedItemColor: AppColors.blue600,
      unselectedItemColor: AppColors.gray900,
      items: List.generate(items.length, (index) {
        final isActive = index == _currentIndex;
        final color = isActive ? AppColors.blue600 : AppColors.gray900;
        
        // Special case for Penjualan button (middle button)
        if (index == 2) {
          return BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: isActive ? AppColors.blue600 : AppColors.gray900,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/${items[index]['image']}',
                width: 24.r,
                height: 24.r,
                color: Colors.white,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading ${items[index]['image']}: $error');
                  return Icon(
                    items[index]['icon'],
                    color: Colors.white,
                    size: 24.r,
                  );
                },
              ),
            ),
            label: items[index]['label'],
          );
        }
        
        // Regular navigation items
        return BottomNavigationBarItem(
          icon: Image.asset(
            'assets/${items[index]['image']}',
            width: 24.r,
            height: 24.r,
            color: color,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading ${items[index]['image']}: $error');
              return Icon(
                items[index]['icon'],
                color: color,
                size: 24.r,
              );
            },
          ),
          label: items[index]['label'],
        );
      }),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Navigasi ke halaman yang sesuai berdasarkan index menggunakan GetX
    switch (index) {
      case 0: // Beranda - sudah di halaman ini
        break;
      case 1: // Riwayat
        debugPrint('Navigasi ke: Riwayat (belum diimplementasikan)');
        // Get.toNamed('/history');
        break;
      case 2: // Penjualan
        debugPrint('Navigasi ke: Penjualan (belum diimplementasikan)');
        // Get.toNamed('/sales');
        break;
      case 3: // Laporan
        debugPrint('Navigasi ke: Laporan (belum diimplementasikan)');
        // Get.toNamed('/reports');
        break;
      case 4: // Profil
        debugPrint('Navigasi ke: Profil (belum diimplementasikan)');
        // Get.toNamed('/profile');
        break;
    }
  }
}