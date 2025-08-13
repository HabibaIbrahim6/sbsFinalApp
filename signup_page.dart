import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'MainPage.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  // تعريف أنماط الخطوط المخصصة
  final TextStyle _headerStyle = GoogleFonts.tajawal(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF1C3D5A),
  );

  final TextStyle _subHeaderStyle = GoogleFonts.tajawal(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF1C3D5A),
  );

  final TextStyle _bodyStyle = GoogleFonts.tajawal(
    fontSize: 16,
    color: const Color(0xFF1C3D5A).withOpacity(0.8),
  );

  final TextStyle _buttonStyle = GoogleFonts.tajawal(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final TextStyle _linkStyle = GoogleFonts.tajawal(
    fontSize: 14,
    color: const Color(0xFF1C3D5A),
    fontWeight: FontWeight.w500,
  );

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nationalIdController = TextEditingController();
  final birthDateController = TextEditingController();

  String? gender;
  File? personalImage;
  File? cardImage;
  Uint8List? personalImageWeb;
  Uint8List? cardImageWeb;
  DateTime? selectedDate;

  bool isObscure = true;
  bool isConfirmObscure = true;
  bool isLoading = false; // إضافة متغير لتحميل الحالة

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  Future<void> _pickImage(bool isPersonalImage) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            if (isPersonalImage) {
              personalImageWeb = bytes;
            } else {
              cardImageWeb = bytes;
            }
          });
        } else {
          setState(() {
            if (isPersonalImage) {
              personalImage = File(pickedFile.path);
            } else {
              cardImage = File(pickedFile.path);
            }
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ أثناء رفع الصورة: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildImagePreview(bool isPersonalImage) {
    if (kIsWeb) {
      final imageBytes = isPersonalImage ? personalImageWeb : cardImageWeb;
      return imageBytes != null
          ? Image.memory(imageBytes, fit: BoxFit.cover, width: double.infinity)
          : _buildPlaceholder(isPersonalImage);
    } else {
      final imageFile = isPersonalImage ? personalImage : cardImage;
      return imageFile != null
          ? Image.file(imageFile!, fit: BoxFit.cover, width: double.infinity)
          : _buildPlaceholder(isPersonalImage);
    }
  }

  Widget _buildPlaceholder(bool isPersonalImage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isPersonalImage ? Icons.add_a_photo : Icons.credit_card,
            color: const Color(0xFF1C3D5A).withOpacity(0.6),
          ),
          Text(
            isPersonalImage ? "رفع صورة" : "رفع صورة البطاقة",
            style: _bodyStyle.copyWith(color: const Color(0xFF1C3D5A).withOpacity(0.6)),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("كلمات المرور غير متطابقة"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if ((kIsWeb ? personalImageWeb == null : personalImage == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء رفع الصورة الشخصية"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if ((kIsWeb ? cardImageWeb == null : cardImage == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء رفع صورة البطاقة الشخصية"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    // محاكاة عملية التسجيل (استبدل هذا بطلب API الحقيقي)
    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);

    // عرض رسالة النجاح
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم إنشاء الحساب بنجاح!"),
        backgroundColor: Colors.green,
      ),
    );

    // الانتقال إلى الصفحة الرئيسية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  HomePage()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nationalIdController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1C3D5A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shopping_cart, color: Color(0xFFFFA726), size: 32),
                        const SizedBox(width: 8),
                        Text("إيجارك", style: _headerStyle),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("إنشاء حساب جديد", style: _subHeaderStyle),
                    const SizedBox(height: 8),
                    Text("انضم إلى مجتمع إيجارك الآن", style: _bodyStyle),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Name Field
              _buildAnimatedField(
                _buildTextField(
                  controller: nameController,
                  label: "الاسم الكامل",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال الاسم";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Email Field
              _buildAnimatedField(
                _buildTextField(
                  controller: emailController,
                  label: "البريد الإلكتروني",
                  validator: (value) {
                    if (value == null || !value.contains("@")) {
                      return "بريد إلكتروني غير صالح";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Phone Field
              _buildAnimatedField(
                _buildTextField(
                  controller: phoneController,
                  label: "رقم الهاتف",
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return "رقم هاتف غير صالح";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // WhatsApp Field
              _buildAnimatedField(
                _buildTextField(
                  controller: whatsappController,
                  label: "رقم الواتساب",
                  validator: (value) => null,
                ),
              ),

              const SizedBox(height: 16),

              // National ID Field
              _buildAnimatedField(
                _buildTextField(
                  controller: nationalIdController,
                  label: "الرقم القومي",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال الرقم القومي";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Birth Date Field
              _buildAnimatedField(
                TextFormField(
                  controller: birthDateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  style: const TextStyle(color: Color(0xFF1C3D5A)),
                  decoration: InputDecoration(
                    labelText: "تاريخ الميلاد",
                    labelStyle: _bodyStyle.copyWith(color: const Color(0xFF1C3D5A).withOpacity(0.6)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF1C3D5A).withOpacity(0.2)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1C3D5A),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: const Color(0xFF1C3D5A).withOpacity(0.6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Gender Field
              _buildAnimatedField(
                DropdownButtonFormField<String>(
                  value: gender,
                  hint: Text(
                    "اختر النوع",
                    style: _bodyStyle.copyWith(color: const Color(0xFF1C3D5A).withOpacity(0.6)),
                  ),
                  items: ["ذكر", "أنثى"]
                      .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender, style: _bodyStyle),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "الرجاء اختيار النوع";
                    }
                    return null;
                  },
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF1C3D5A).withOpacity(0.2)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1C3D5A),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Personal Image Upload
              _buildAnimatedField(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الصورة الشخصية",
                      style: _bodyStyle,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _pickImage(true),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF1C3D5A).withOpacity(0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildImagePreview(true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Card Image Upload
              _buildAnimatedField(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "صورة البطاقة الشخصية",
                      style: _bodyStyle,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _pickImage(false),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF1C3D5A).withOpacity(0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildImagePreview(false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Password Field
              _buildAnimatedField(
                _buildPasswordField(
                  controller: passwordController,
                  label: "كلمة المرور",
                  isObscure: isObscure,
                  onToggle: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Confirm Password Field
              _buildAnimatedField(
                _buildPasswordField(
                  controller: confirmPasswordController,
                  label: "تأكيد كلمة المرور",
                  isObscure: isConfirmObscure,
                  onToggle: () {
                    setState(() {
                      isConfirmObscure = !isConfirmObscure;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Sign Up Button
              _buildAnimatedField(
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF66BB6A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: _buttonStyle,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("إنشاء الحساب"),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Already have an account
              _buildAnimatedField(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("لديك حساب بالفعل؟", style: _bodyStyle),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text("تسجيل الدخول", style: _linkStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedField(Widget child) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Color(0xFF1C3D5A)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: _bodyStyle.copyWith(color: const Color(0xFF1C3D5A).withOpacity(0.6)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0xFF1C3D5A).withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE68088),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.length < 6) {
          return "يجب أن تكون كلمة المرور 6 أحرف على الأقل";
        }
        return null;
      },
      style: const TextStyle(color: Color(0xFF1C3D5A)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: _bodyStyle.copyWith(color: const Color(0xFF1C3D5A).withOpacity(0.6)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0xFF1C3D5A).withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF1C3D5A),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF1C3D5A).withOpacity(0.6),
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}