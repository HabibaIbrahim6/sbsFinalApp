import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  // New color scheme
  final Color _primaryColor = const Color(0xFF25488E);
  final Color _secondaryColor = const Color(0xFFF4C42D);
  final Color _darkColor = const Color(0xFF212121);
  final Color _lightColor = const Color(0xFFF5F5F5);
  final Color _errorColor = const Color(0xFFE53935);

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // Text styles
  final TextStyle _headerStyle = GoogleFonts.tajawal(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  final TextStyle _subHeaderStyle = GoogleFonts.tajawal(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final TextStyle _bodyStyle = GoogleFonts.tajawal(
    fontSize: 16,
    color: Colors.white.withOpacity(0.9),
  );

  final TextStyle _buttonStyle = GoogleFonts.tajawal(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final TextStyle _darkTextStyle = GoogleFonts.tajawal(
    fontSize: 16,
    color: Color(0xFF212121),
  );

  final TextStyle _linkStyle = GoogleFonts.tajawal(
    fontSize: 14,

    fontWeight: FontWeight.w500,
  );

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
        ));

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
        ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _secondaryColor.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _secondaryColor.withOpacity(0.05),
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Header section
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
                            Icon(Icons.shopping_bag,
                              color: _secondaryColor,
                              size: 36,
                            ),
                            SizedBox(width: 8),
                            Text("إيجارك", style: _headerStyle),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text("أهلاً بعودتك!", style: _subHeaderStyle),
                        const SizedBox(height: 8),
                        Text("منصة تأجير المنتجات الأولى", style: _bodyStyle),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Login Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email Field
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
                          child: _buildTextField(
                            "البريد الإلكتروني",
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال البريد الإلكتروني';
                              }
                              if (!value.contains('@')) {
                                return 'البريد الإلكتروني غير صالح';
                              }
                              return null;
                            },
                            prefixIcon: Icons.email_outlined,
                          ),
                        ),

                        // Password Field
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
                          child: _buildTextField(
                            "كلمة المرور",
                            controller: _passwordController,
                            isPassword: true,
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال كلمة المرور';
                              }
                              if (value.length < 6) {
                                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white.withOpacity(0.6),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Forgot Password
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
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "نسيت كلمة المرور؟",
                                style: _linkStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Login Button
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
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform login
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _secondaryColor,
                              foregroundColor: _darkColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: _buttonStyle.copyWith(color: _darkColor),
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              shadowColor: _secondaryColor.withOpacity(0.5),
                            ),
                            child: const Text("تسجيل الدخول"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Divider with "OR"
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "أو",
                            style: _bodyStyle.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Social Login Buttons
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(Icons.g_mobiledata, const Color(0xFFDB4437)),
                        const SizedBox(width: 20),
                        _buildSocialButton(Icons.facebook, const Color(0xFF4267B2)),
                        const SizedBox(width: 20),
                        _buildSocialButton(Icons.apple, Colors.black),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Sign up link
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
                    child: Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("ليس لديك حساب؟",
                            style: _bodyStyle.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "سجل الآن",
                              style: _linkStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, {
        bool isPassword = false,
        bool obscureText = false,
        TextEditingController? controller,
        String? Function(String?)? validator,
        IconData? prefixIcon,
        Widget? suffixIcon,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        textAlign: TextAlign.right,
        style: _bodyStyle.copyWith(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: _bodyStyle.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
          filled: true,
          fillColor: _primaryColor.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _secondaryColor,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _errorColor,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _errorColor,
              width: 1.5,
            ),
          ),
          errorStyle: GoogleFonts.tajawal(
            color: _errorColor,
            fontSize: 12,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.white.withOpacity(0.7))
              : null,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, color: color, size: 32),
      ),
    );
  }
}