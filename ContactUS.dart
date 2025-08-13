import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<Offset> _formAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _formAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuart,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality( // إضافة Directionality هنا لتطبيقها على الصفحة كاملة
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SlideTransition(
                  position: _formAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildFormSection(),
                  ),
                ),
                const SizedBox(height: 30),
                _buildContactInfoSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: const Color(0xFF25488E).withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'أرسل رسالتك',
                  style: GoogleFonts.tajawal(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF25488E),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              TextFormField(
                controller: _nameController,
                style: GoogleFonts.tajawal(),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'الاسم بالكامل',
                  labelStyle: GoogleFonts.tajawal(
                    color: const Color(0xFF25488E).withOpacity(0.8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF25488E),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email Field
              TextFormField(
                controller: _emailController,
                style: GoogleFonts.tajawal(),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  labelStyle: GoogleFonts.tajawal(
                    color: const Color(0xFF25488E).withOpacity(0.8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color(0xFF25488E),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }
                  if (!value.contains('@')) {
                    return 'البريد الإلكتروني غير صالح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Subject Field
              TextFormField(
                controller: _subjectController,
                style: GoogleFonts.tajawal(),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'الموضوع',
                  labelStyle: GoogleFonts.tajawal(
                    color: const Color(0xFF25488E).withOpacity(0.8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.subject,
                    color: Color(0xFF25488E),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الموضوع';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Message Field
              TextFormField(
                controller: _messageController,
                style: GoogleFonts.tajawal(),
                textAlign: TextAlign.right,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'رسالتك',
                  labelStyle: GoogleFonts.tajawal(
                    color: const Color(0xFF25488E).withOpacity(0.8),
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء كتابة الرسالة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _sendMessage(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF4C42D),
                    foregroundColor: const Color(0xFF212121),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    shadowColor: const Color(0xFFF4C42D).withOpacity(0.3),
                  ),
                  child: Text(
                    'إرسال الرسالة',
                    style: GoogleFonts.tajawal(
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

  Widget _buildContactInfoSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xFF25488E),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'معلومات التواصل',
                  style: GoogleFonts.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Address
              _buildContactItem(
                icon: Icons.location_on,
                title: 'العنوان',
                subtitle: 'مصر: القاهرة',
                iconColor: const Color(0xFFF4C42D),
                onTap: () => _launchMaps('مصر: القاهرة'),
              ),
              const Divider(color: Colors.white54, height: 24),

              // Email
              _buildContactItem(
                icon: Icons.email,
                title: 'البريد الإلكتروني',
                subtitle: 'ejarkcompany@gmail.com',
                iconColor: const Color(0xFFF4C42D),
                onTap: () => _launchEmail('ejarkcompany@gmail.com'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: GoogleFonts.tajawal(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Align(
        alignment: Alignment.centerRight,
        child: Text(
          subtitle,
          style: GoogleFonts.tajawal(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _sendMessage(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'تم الإرسال بنجاح',
              style: GoogleFonts.tajawal(
                color: const Color(0xFF25488E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'شكراً لتواصلك معنا، سنرد عليك في أقرب وقت ممكن.',
              style: GoogleFonts.tajawal(
                color: const Color(0xFF212121),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
                _messageController.clear();
                _nameController.clear();
                _emailController.clear();
                _subjectController.clear();
              },
              child: Text(
                'حسناً',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF25488E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    }
  }

  Future<void> _launchMaps(String address) async {
    final Uri params = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps/search/',
      queryParameters: {'query': address},
    );
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    }
  }
}