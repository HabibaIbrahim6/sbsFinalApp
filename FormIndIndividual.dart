import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class IndividualForm extends StatefulWidget {
  const IndividualForm({Key? key}) : super(key: key);

  @override
  _IndividualFormState createState() => _IndividualFormState();
}

class _IndividualFormState extends State<IndividualForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  File? profileImage;
  Uint8List? profileImageWeb;

  bool isObscure = true;
  bool isConfirmObscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    streetController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() => profileImageWeb = bytes);
        } else {
          setState(() => profileImage = File(pickedFile.path));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ: ${e.toString()}"),
          backgroundColor: Color(0xFF25488E),
        ),
      );
    }
  }

  Widget _buildImagePreview() {
    if (kIsWeb) {
      return profileImageWeb != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(profileImageWeb!, fit: BoxFit.cover),
      )
          : _buildPlaceholder();
    } else {
      return profileImage != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(profileImage!, fit: BoxFit.cover),
      )
          : _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, color: Color(0xFF25488E)),
            SizedBox(height: 8),
            Text("صورة الملف الشخصي",
              style: GoogleFonts.tajawal(
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("كلمة المرور غير متطابقة"),
          backgroundColor: Color(0xFF25488E),
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم التسجيل بنجاح!"),
        backgroundColor: Color(0xFF25488E),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF25488E),
          elevation: 4,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),

              Text(
                'تسجيل فرد',
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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("إنشاء حساب فردي",
                  style: GoogleFonts.tajawal(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF25488E),
                  ),
                ),
                SizedBox(height: 20),

                _buildTextField(nameController, "الاسم الكامل", Icons.person),
                SizedBox(height: 16),

                _buildTextField(emailController, "البريد الإلكتروني", Icons.email),
                SizedBox(height: 16),

                _buildTextField(phoneController, "رقم الهاتف", Icons.phone),
                SizedBox(height: 16),


                _buildTextField(cityController, "المدينة", Icons.location_city),
                SizedBox(height: 16),

                _buildTextField(streetController, "الشارع", Icons.streetview),
                SizedBox(height: 16),

                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF25488E).withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: _buildImagePreview(),
                  ),
                ),
                SizedBox(height: 24),

                // Password


                _buildPasswordField(passwordController, "كلمة المرور", isObscure, () {
                  setState(() => isObscure = !isObscure);
                }),
                SizedBox(height: 16),

                _buildPasswordField(confirmPasswordController, "تأكيد كلمة المرور", isConfirmObscure, () {
                  setState(() => isConfirmObscure = !isConfirmObscure);
                }),
                SizedBox(height: 32),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF4C42D),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      shadowColor: Color(0xFF25488E).withOpacity(0.3),
                    ),
                    child: isLoading
                        ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add, size: 22),
                        SizedBox(width: 10),
                        Text("تسجيل",
                          style: GoogleFonts.tajawal(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.tajawal(color: Color(0xFF212121)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.tajawal(color: Color(0xFF25488E).withOpacity(0.8)),
        prefixIcon: Icon(icon, color: Color(0xFF25488E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF25488E).withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF25488E).withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF25488E)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        if (label.contains("بريد") && !value.contains("@")) {
          return 'بريد إلكتروني غير صالح';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller,
      String label,
      bool obscureText,
      VoidCallback onToggle,
      ) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.tajawal(color: Color(0xFF212121)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.tajawal(color: Color(0xFF25488E).withOpacity(0.8)),
        prefixIcon: Icon(Icons.lock, color: Color(0xFF25488E)),
        suffixIcon: IconButton(
          icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Color(0xFF25488E)),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF25488E).withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF25488E).withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF25488E)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        if (label.contains("كلمة المرور") && value.length < 6) {
          return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
        }
        return null;
      },
    );
  }
}