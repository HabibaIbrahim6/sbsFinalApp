
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'add_product.dart';

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    // احنا هنا من المفترض ان الـ MaterialApp يكون في ملف رئيسي main.dart
    // لو عايزة تشغلي التطبيق لوحده، خلي الكود هنا فقط لوحدة DashboardScreen بدون MaterialApp
    return const DashboardScreen();
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _showProfileOptions = false;
  String _name = "محمد أحمد";
  String _email = "mohamed@example.com";
  String _phone = "+20123456789";
  File? _profileImage;

  final List<Map<String, dynamic>> rentedItems = [
    {
      'title': 'آيفون 15 برو ماكس',
      'image': 'assets/images/iphone.png',
      'date': 'تم التأجير: 15/03/2023',
      'status': 'مكتمل',
    },
    {
      'title': 'كاميرا احترافية',
      'image': 'assets/images/camera.png',
      'date': 'تم التأجير: 22/03/2023',
      'status': 'مكتمل',
    },
  ];

  final List<Map<String, dynamic>> uploadedItems = [
    {
      'title': 'ماك بوك برو',
      'image': 'assets/images/macbook.png',
      'date': 'تم الرفع: 10/03/2023',
      'status': 'متاح',
    },
    {
      'title': 'درون DJI',
      'image': 'assets/images/drone.png',
      'date': 'تم الرفع: 05/03/2023',
      'status': 'متاح',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF25488E),
        elevation: 4,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),

            Text(
              'بيانات الحساب',
              style: GoogleFonts.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),


        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF212121)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showProfileOptions = !_showProfileOptions;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFFF5F5F5),
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : const AssetImage('assets/images/profile.jpg')
                            as ImageProvider,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF25488E),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _email,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildStatItem(
                                        uploadedItems.length.toString(),
                                        'عنصر مرفوع'),
                                    const SizedBox(width: 16),
                                    _buildStatItem(rentedItems.length.toString(),
                                        'تم تأجيره'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            _showProfileOptions
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 30,
                            color: const Color(0xFF25488E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_showProfileOptions)
                  AnimatedOpacity(
                    opacity: _showProfileOptions ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: _buildProfileOptions(),
                  ),
                const SizedBox(height: 20),
                _buildNavigationTabs(),
                const SizedBox(height: 20),
                _selectedIndex == 0
                    ? _buildUploadedItemsList()
                    : _buildRentedItemsList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_product');
        },
        backgroundColor: const Color(0xFFF4C42D),
        child: const Icon(Icons.add, color: Color(0xFF25488E)),
      ),
    );
  }

  Widget _buildProfileOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildProfileOptionTile(
            icon: Icons.camera_alt,
            title: 'تحديث الصورة الشخصية',
            onTap: _showImagePickerDialog,
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildProfileOptionTile(
            icon: Icons.lock,
            title: 'تغيير كلمة المرور',
            onTap: _showChangePasswordDialog,
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildProfileOptionTile(
            icon: Icons.phone,
            title: 'تحديث رقم الهاتف',
            onTap: _showUpdatePhoneDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF25488E)),
      title: Text(title, style: const TextStyle(color: Color(0xFF25488E))),
      onTap: onTap,
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF25488E),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(0, 'المنتجات المرفوعة'),
          ),
          Expanded(
            child: _buildTabButton(1, 'التأجيرات السابقة'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFF25488E) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : const Color(0xFF25488E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedItemsList() {
    return Column(
      children: uploadedItems.map((item) => _buildItemCard(item)).toList(),
    );
  }

  Widget _buildRentedItemsList() {
    return Column(
      children: rentedItems.map((item) => _buildItemCard(item)).toList(),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(item['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF25488E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['date'],
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: item['status'] == 'مكتمل' ? Colors.green[100] : Colors.orange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['status'],
                        style: TextStyle(
                          color: item['status'] == 'مكتمل' ? Colors.green[800] : Colors.orange[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showImagePickerDialog() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اختر صورة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('التقاط صورة بالكاميرا'),
                onTap: () async {
                  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop(photo);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('اختيار من المعرض'),
                onTap: () async {
                  final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop(photo);
                },
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String oldPassword = '';
        String newPassword = '';
        return AlertDialog(
          title: const Text('تغيير كلمة المرور'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'كلمة المرور القديمة'),
                onChanged: (value) {
                  oldPassword = value;
                },
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'كلمة المرور الجديدة'),
                onChanged: (value) {
                  newPassword = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('تحديث'),
              onPressed: () {
                // اكتب هنا منطق تحديث كلمة المرور لو عايزة
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdatePhoneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newPhone = '';
        return AlertDialog(
          title: const Text('تحديث رقم الهاتف'),
          content: TextField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'رقم الهاتف الجديد'),
            onChanged: (value) {
              newPhone = value;
            },
          ),
          actions: [
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('تحديث'),
              onPressed: () {
                setState(() {
                  _phone = newPhone;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
