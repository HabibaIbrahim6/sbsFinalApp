
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MainPage.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late AnimationController _bgController;
  late Animation<Color?> _bgColorAnimation;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // الصورة تبدأ صغيرة 0.5 وتكبر لـ 1.0
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutBack),
    );

    // الشفافية تبدأ من 0 لـ 1 تدريجياً
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeIn),
    );

    // الصورة تتحرك شوية لفوق (من 40 بكسل لتصبح في مكانها الطبيعي)
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _mainController, curve: Curves.easeOut));

    _mainController.forward();

    // أنيميشن الخلفية المتغيرة
    _bgController = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);

    _bgColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.grey.shade100,
    ).animate(_bgController);

    // أنيميشن البار السفلي (Pulse)
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 3.0, end: 6.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // الانتقال للصفحة الرئيسية بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomePage(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 700),
        ),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _bgController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgColorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _bgColorAnimation.value,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // الصورة مع الحركة
                    SlideTransition(
                      position: _slideAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Image.asset(
                            'images/logo.png',
                            width: 300,
                            height: 300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // النصوص
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'منصة التأجير الأولى',
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                color: const Color(0xFF212121).withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // مؤشر التحميل في الأسفل
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, _) {
                      return SizedBox(
                        width: 120,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey.shade300,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFF4C42D),
                          ),
                          minHeight: _pulseAnimation.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
