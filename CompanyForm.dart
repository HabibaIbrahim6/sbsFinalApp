import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class CompanyForm extends StatefulWidget {
  const CompanyForm({Key? key}) : super(key: key);

  @override
  _CompanyFormState createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final _formKey = GlobalKey<FormState>();
  final companyNameController = TextEditingController();
  final companyFieldController = TextEditingController();
  final companyRightsController = TextEditingController();
  final responsibleNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final nationalIdController = TextEditingController();
  final taxCardController = TextEditingController();
  final proofOfActivityController = TextEditingController();
  final commercialRegisterController = TextEditingController();

  File? taxCardImage;
  File? proofOfActivityImage;
  File? commercialRegisterImage;
  File? nationalIdImage;
  Uint8List? taxCardImageWeb;
  Uint8List? proofOfActivityImageWeb;
  Uint8List? commercialRegisterImageWeb;
  Uint8List? nationalIdImageWeb;

  bool isLoading = false;
  final Color primaryColor = Color(0xFF25488E); // اللون الأساسي الأزرق الغامق (#25488E)
  final Color secondaryColor = Color(0xFF212121); // اللون الثانوي الأسود الداكن (#212121)
  final Color accentColor = Color(0xFFF4C42D); // اللون التمييزي الذهبي (#F4C42D)
  final Color backgroundColor = Color(0xFFF5F5F5); // لون الخلفية (لم يتغير)

  @override
  void dispose() {
    companyNameController.dispose();
    companyFieldController.dispose();
    companyRightsController.dispose();
    responsibleNameController.dispose();
    jobTitleController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nationalIdController.dispose();
    taxCardController.dispose();
    proofOfActivityController.dispose();
    commercialRegisterController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(int imageType) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            switch (imageType) {
              case 1: taxCardImageWeb = bytes; break;
              case 2: proofOfActivityImageWeb = bytes; break;
              case 3: commercialRegisterImageWeb = bytes; break;
              case 4: nationalIdImageWeb = bytes; break;
            }
          });
        } else {
          setState(() {
            switch (imageType) {
              case 1: taxCardImage = File(pickedFile.path); break;
              case 2: proofOfActivityImage = File(pickedFile.path); break;
              case 3: commercialRegisterImage = File(pickedFile.path); break;
              case 4: nationalIdImage = File(pickedFile.path); break;
            }
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ: ${e.toString()}"),
          backgroundColor: accentColor,
        ),
      );
    }
  }

  Widget _buildImagePreview(int imageType) {
    String placeholderText;
    IconData icon;

    switch (imageType) {
      case 1:
        placeholderText = "بطاقة الضريبة";
        icon = Icons.receipt;
        if (kIsWeb) {
          return taxCardImageWeb != null
              ? Image.memory(taxCardImageWeb!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        } else {
          return taxCardImage != null
              ? Image.file(taxCardImage!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        }
      case 2:
        placeholderText = "إثبات النشاط";
        icon = Icons.work;
        if (kIsWeb) {
          return proofOfActivityImageWeb != null
              ? Image.memory(proofOfActivityImageWeb!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        } else {
          return proofOfActivityImage != null
              ? Image.file(proofOfActivityImage!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        }
      case 3:
        placeholderText = "السجل التجاري";
        icon = Icons.business;
        if (kIsWeb) {
          return commercialRegisterImageWeb != null
              ? Image.memory(commercialRegisterImageWeb!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        } else {
          return commercialRegisterImage != null
              ? Image.file(commercialRegisterImage!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        }
      case 4:
        placeholderText = "البطاقة الشخصية";
        icon = Icons.credit_card;
        if (kIsWeb) {
          return nationalIdImageWeb != null
              ? Image.memory(nationalIdImageWeb!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        } else {
          return nationalIdImage != null
              ? Image.file(nationalIdImage!, fit: BoxFit.cover)
              : _buildPlaceholder(placeholderText, icon);
        }
      default: return Container();
    }
  }

  Widget _buildPlaceholder(String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: primaryColor.withOpacity(0.5)),
            SizedBox(height: 8),
            Text(text, style: GoogleFonts.tajawal(
              color: primaryColor.withOpacity(0.7),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadField(String label, int imageType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.tajawal(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        )),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickImage(imageType),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: primaryColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildImagePreview(imageType),
            ),
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _pickImage(imageType),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor.withOpacity(0.1),
            foregroundColor: primaryColor,
            minimumSize: Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 20),
              SizedBox(width: 8),
              Text("اختر ملف", style: GoogleFonts.tajawal()),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم تسجيل الشركة بنجاح!"),
        backgroundColor: secondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Color(0xFF25488E),
          elevation: 4,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),

              Text(
                'تسجيل حساب شركة جديد',
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
                // معلومات الشركة
                Text("معلومات الشركة", style: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                )),
                SizedBox(height: 16),

                _buildTextField(companyNameController, "اسم الشركة"),
                SizedBox(height: 16),

                _buildTextField(companyFieldController, "مجال الشركة"),
                SizedBox(height: 16),

                _buildTextField(companyRightsController, "حقوق الشركة"),
                SizedBox(height: 16),

                _buildTextField(responsibleNameController, "اسم الشخص المسؤول"),
                SizedBox(height: 16),

                _buildTextField(jobTitleController, "الوظيفة"),
                SizedBox(height: 16),

                _buildTextField(phoneController, "رقم الهاتف", keyboardType: TextInputType.phone),
                SizedBox(height: 16),

                _buildTextField(emailController, "البريد الإلكتروني", keyboardType: TextInputType.emailAddress),
                SizedBox(height: 16),

                _buildTextField(nationalIdController, "الرقم القومي"),
                SizedBox(height: 16),

                // البطاقة الشخصية
                _buildFileUploadField("صورة البطاقة الشخصية", 4),
                SizedBox(height: 16),

                // المستندات المطلوبة
                Text("المستندات المطلوبة", style: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                )),
                SizedBox(height: 16),

                _buildTextField(taxCardController, "رقم البطاقة الضريبية"),
                SizedBox(height: 16),

                _buildFileUploadField("صورة البطاقة الضريبية", 1),
                SizedBox(height: 16),

                _buildTextField(proofOfActivityController, "إثبات النشاط"),
                SizedBox(height: 16),

                _buildFileUploadField("صورة إثبات النشاط", 2),
                SizedBox(height: 16),

                _buildTextField(commercialRegisterController, "السجل التجاري"),
                SizedBox(height: 16),

                _buildFileUploadField("صورة السجل التجاري", 3),
                SizedBox(height: 24),

                // زر التسجيل
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                      shadowColor: primaryColor.withOpacity(0.3),
                    ),
                    child: isLoading
                        ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                        : Text("تسجيل الشركة", style: GoogleFonts.tajawal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.tajawal(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.tajawal(color: primaryColor.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
}