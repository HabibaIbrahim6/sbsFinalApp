import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateAnimation;
  late Animation<Offset> _logoSlideAnimation;

  // الألوان
  static const Color primaryBlue = Color(0xFF25488E);
  static const Color accentGold = Color(0xFFF4C42D);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkText = Color(0xFF212121);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
        ));

    _translateAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0), // تغيير الاتجاه ليكون من اليسار
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedSection(Widget child, {double delay = 0.0}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _translateAnimation.value * (1 - delay)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 30),
            _buildAnimatedSection(
              _buildInfoCard(
                icon: Icons.group,
                title: 'من نحن',
                content: 'نحن فريق من المحترفين المتفانين الذين يجمعهم شغف تقديم حلول إيجارية مبتكرة. تأسست منصتنا برؤية واضحة لتبسيط عملية التأجير وجعلها أكثر كفاءة وموثوقية.',
              ),
              delay: 0.2,
            ),
            const SizedBox(height: 20),
            _buildAnimatedSection(
              _buildInfoCard(
                icon: Icons.leaderboard,
                title: 'قيادة رائدة',
                content: 'نقود من الأمام من خلال الابتكار المستمر وتبني أحدث التقنيات. نؤمن بأن القيادة الحقيقية تعني تمكين عملائنا وشركائنا لتحقيق أهدافهم.',
                color: accentGold,
                textColor: darkText,
              ),
              delay: 0.3,
            ),
            const SizedBox(height: 20),
            _buildAnimatedSection(
              _buildInfoCard(
                icon: Icons.star,
                title: 'ما نتميز به',
                content: 'نقدم تجربة مستخدم فريدة مع واجهة بسيطة وسهلة الاستخدام. نضمن الأمان والشفافية في كل معاملة، مع دعم فني متاح على مدار الساعة.',
                color: primaryBlue,
              ),
              delay: 0.4,
            ),
            const SizedBox(height: 20),
            _buildAnimatedSection(
              _buildTeamSection(),
              delay: 0.5,
            ),
            const SizedBox(height: 20),
            _buildAnimatedSection(
              _buildStrategySection(),
              delay: 0.6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.home_work_outlined,
                        size: 60,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: SlideTransition(
                    position: _logoSlideAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: primaryBlue.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: primaryBlue.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Text(
                        'إيجارك',
                        style: GoogleFonts.tajawal(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _translateAnimation.value),
                child: child,
              ),
            );
          },
          child: Text(
            'منصة التأجير الرائدة في مصر',
            style: GoogleFonts.tajawal(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    Color color = primaryBlue,
    Color textColor = Colors.white,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: color.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.9),
              color.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: textColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: textColor, size: 28),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    style: GoogleFonts.tajawal(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                content,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  height: 1.6,
                  color: textColor.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamSection() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: primaryBlue.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.people, color: primaryBlue, size: 28),
                ),
                const SizedBox(width: 15),
                Text(
                  'فريقنا',
                  style: GoogleFonts.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildTeamMember('أحمد هشام', 'المؤسس والرئيس التنفيذي', Icons.verified_user),
            _buildTeamMember('ساره حسام', 'رئيسة قسم التطوير', Icons.code),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String name, String position, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primaryBlue.withOpacity(0.2),
            child: Icon(icon, color: primaryBlue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                Text(
                  position,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_left, color: primaryBlue),
        ],
      ),
    );
  }

  Widget _buildStrategySection() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: accentGold.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentGold.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.auto_graph, color: accentGold, size: 28),
                ),
                const SizedBox(width: 15),
                Text(
                  'استراتيجيتنا',
                  style: GoogleFonts.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildStrategyItem('التركيز على العميل', Icons.person, primaryBlue),
            _buildStrategyItem('الابتكار المستمر', Icons.lightbulb, accentGold),
            _buildStrategyItem('الجودة والموثوقية', Icons.verified, primaryBlue),
            _buildStrategyItem('النمو المستدام', Icons.trending_up, accentGold),
          ],
        ),
      ),
    );
  }

  Widget _buildStrategyItem(String text, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}