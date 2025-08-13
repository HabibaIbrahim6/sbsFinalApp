import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MainPage.dart';
import 'aboutUs.dart';
import 'ContactUs.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  int _currentIndex = 0;
  bool userIsLoggedIn = false;
  String? userName;

  // قائمة الصفحات للتنقل
  final List<Widget> _pages = [
    HomePage(), // محتوى الصفحة الرئيسية
    ContactUsPage(), // صفحة تواصل معنا
    AboutUsPage(),   // صفحة من نحن
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),

        body: _pages[_currentIndex], // يعرض الصفحة الحالية حسب المؤشر
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  // شريط التنقل السفلي
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        // child: BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   type: BottomNavigationBarType.fixed,
        //   onTap: (index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        //   backgroundColor: Colors.white,
        //   selectedItemColor: Color(0xFF25488E),
        //   unselectedItemColor: Colors.grey[600],
        //   selectedLabelStyle: GoogleFonts.tajawal(
        //       fontWeight: FontWeight.bold),
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'الرئيسية',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.contact_mail),
        //       label: 'تواصل معنا',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.info),
        //       label: 'من نحن',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Image.asset(
              'assets/logo.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Text(
              'إيجارك',
              style: GoogleFonts.tajawal(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF25488E)),
            ),
            SizedBox(height: 10),
            Text(
              'منصة التأجير الأولى في مصر',
              style: GoogleFonts.tajawal(
                  fontSize: 16,
                  color: Color(0xFF212121)),
            ),
            SizedBox(height: 30),

            // بطاقة العرض الرئيسية
            _buildMainCard(context),
            SizedBox(height: 30),

            // وصف التطبيق
            _buildAppDescription(),
            SizedBox(height: 40),

            // زر تسجيل الدخول
            _buildLoginButton(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              'هل لديك شيء لتؤجره؟',
              style: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF25488E)),
            ),
            SizedBox(height: 10),
            Text(
              'انضم إلى منصة إيجارك وابدأ بكسب المال من الأشياء التي لا تستخدمها',
              style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: Color(0xFF212121)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر التسجيل الفردي
                _buildActionButton(
                  context,
                  icon: Icons.person_add,
                  label: 'تسجيل فرد',
                  color: Color(0xFF25488E),
                  route: '/formI',
                ),
                SizedBox(width: 5),
                // زر التسجيل كشركة
                _buildActionButton(
                  context,
                  icon: Icons.business,
                  label: 'تسجيل شركة',
                  color: Color(0xFFF4C42D),
                  textColor: Color(0xFF212121),
                  route: '/formC',
                ),
              ],
            ),
          ],
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
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          shadowColor: color.withOpacity(0.3)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.tajawal(
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAppDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'منصة إيجارك هي الحل الأمثل لتأجير واستئجار مختلف المنتجات والعقارات بكل سهولة وأمان. نوفر لك تجربة سلسة وآمنة لإتمام عمليات التأجير.',
        textAlign: TextAlign.center,
        style: GoogleFonts.tajawal(
            fontSize: 16,
            color: Color(0xFF212121)),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/login'),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF25488E),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          shadowColor: Color(0xFF25488E).withOpacity(0.3)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.login, size: 20),
          SizedBox(width: 8),
          Text(
            'تسجيل الدخول',
            style: GoogleFonts.tajawal(
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}