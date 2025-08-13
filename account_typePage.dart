
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountTypePage extends StatefulWidget {
  @override
  _AccountTypePageState createState() => _AccountTypePageState();
}

class _AccountTypePageState extends State<AccountTypePage> with SingleTickerProviderStateMixin {
  double _loginButtonScale = 1.0;

  void _onLoginTapDown(TapDownDetails details) {
    setState(() {
      _loginButtonScale = 1.05;
    });
  }

  void _onLoginTapUp(TapUpDetails details) {
    setState(() {
      _loginButtonScale = 1.0;
    });
  }

  void _onLoginTapCancel() {
    setState(() {
      _loginButtonScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // اللوجو والعنوان
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_work_outlined, size: 36, color: Color(0xFF25488E)),
                  SizedBox(width: 10),
                  Text(
                    'إيجارك',
                    style: GoogleFonts.tajawal(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25488E),
                      letterSpacing: 1.3,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Text(
                'منصة التأجير الأولى في مصر',
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 40),

              // بطاقة الاختيارات بشكل Grid أنيق
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'هل لديك شيء لتؤجره؟',
                      style: GoogleFonts.tajawal(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF25488E),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'انضم إلى منصة إيجارك وابدأ بكسب المال من الأشياء التي لا تستخدمها',
                      style: GoogleFonts.tajawal(
                        fontSize: 15,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),

                    // أزرار التسجيل بشكل عرضي متناسق
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            context,
                            icon: Icons.person_add_alt_1,
                            label: 'تسجيل فرد',
                            color: Color(0xFF25488E),
                            route: '/formI',
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildActionButton(
                            context,
                            icon: Icons.business_center,
                            label: 'تسجيل شركة',
                            color: Color(0xFFF4C42D),
                            textColor: Color(0xFF212121),
                            route: '/formC',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // وصف التطبيق داخل بطاقة هادية
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  'منصة إيجارك هي الحل الأمثل لتأجير واستئجار مختلف المنتجات والعقارات بكل سهولة وأمان. '
                      'نوفر لك تجربة سلسة وآمنة لإتمام عمليات التأجير بثقة وراحة بال.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 60),

              // زر تسجيل الدخول مع أنيميشن وحجم مناسب
              GestureDetector(
                onTapDown: _onLoginTapDown,
                onTapUp: (details) {
                  _onLoginTapUp(details);
                  Navigator.pushNamed(context, '/login');
                },
                onTapCancel: _onLoginTapCancel,
                child: AnimatedScale(
                  scale: _loginButtonScale,
                  duration: Duration(milliseconds: 160),
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF25488E),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF25488E).withOpacity(0.45),
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 54, vertical: 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.login, size: 24, color: Color(0xFFF4C42D)),
                        SizedBox(width: 14),
                        Text(
                          'تسجيل الدخول',
                          style: GoogleFonts.tajawal(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFF4C42D),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
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

  Widget _buildActionButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        Color textColor = Colors.white,
        required String route,
      }) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.pushNamed(context, route),
      icon: Icon(icon, size: 22, color: textColor),
      label: Text(
        label,
        style: GoogleFonts.tajawal(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 5,
        shadowColor: color.withOpacity(0.35),
      ),
    );
  }
}
