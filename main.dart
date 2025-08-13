import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/Dashboard.dart';

// استيراد الصفحات
import 'package:myapp/signup_page.dart';
import 'package:myapp/login_page.dart';
import 'package:myapp/splash_screen.dart';
import 'ContactUs.dart';
import 'add_product.dart';
import 'product_details.dart';  // استيراد صفحة تفاصيل المنتج بشكل مباشر

import 'CategoriesPage.dart';
import 'CompanyForm.dart';
import 'ContactUs.dart';
import 'FilterPage.dart';
import 'FormIndIndividual.dart';
import 'MainPage.dart' hide ProductDetailPage; // بدون hide عشان مفيش تعارض لو مش محتاج
import 'aboutUs.dart';
import 'home_page.dart';

void main() {
  runApp(const EjarkApp());
}

class EjarkApp extends StatelessWidget {
  const EjarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إيجارك',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: const Color(0xFF1C3D5A),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1C3D5A),
          secondary: Color(0xFF66BB6A),
        ),
        fontFamily: 'Cairo',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      initialRoute: '/splash',
      routes: {
        '/': (context) =>  HomePage(),
        '/ta2geer': (context) => HomePage2(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => RegisterPage(),
        '/about': (context) => AboutUsPage(),
        '/contact': (context) => ContactUsPage(),
        '/catagories': (context) => CategoriesPage(),
        '/formI': (context) => IndividualForm(),
        '/formC': (context) => CompanyForm(),
        '/splash': (context) => SplashScreen(),
        '/filterpage': (context) => AdvancedFilterPage(),
        '/dashboard':(context)=> DashboardApp(),
        '/add_product': (context) => AddProductScreen(),
      },
    );
  }
}