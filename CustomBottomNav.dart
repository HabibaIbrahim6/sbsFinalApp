// widgets/custom_bottom_nav.dart
import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF1C3D5A),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_mail),
          label: 'تواصل معنا',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'الفئات',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'من نحن',
        ),
      ],
    );
  }
}