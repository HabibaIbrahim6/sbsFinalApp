import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تفاصيل المنتج', style: GoogleFonts.tajawal()),
          backgroundColor: Color(0xFF25488E),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // عرض الصور بانر
              Container(
                height: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            product.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${product.images.length} صور',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان والتقييم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: GoogleFonts.tajawal(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 4),
                              Text(
                                product.rating.toString(),
                                style: GoogleFonts.tajawal(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),


                    // الموقع
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey, size: 20),
                        SizedBox(width: 4),
                        Text(
                          product.location,
                          style: GoogleFonts.tajawal(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // سعر اليوم
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF25488E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'سعر اليوم',
                            style: GoogleFonts.tajawal(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product.price} ج.م / اليوم',
                            style: GoogleFonts.tajawal(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF25488E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // الوصف
                    Text(
                      'الوصف',
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product.description,
                        style: GoogleFonts.tajawal(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // الميزات
                    Text(
                      'الميزات',
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.features.map((feature) {
                        return Chip(
                          label: Text(feature),
                          backgroundColor: Color(0xFF25488E).withOpacity(0.1),
                          labelStyle: GoogleFonts.tajawal(
                            color: Color(0xFF25488E),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF25488E),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // إجراء حجز المنتج
                  },
                  icon: Icon(Icons.chat, color: Colors.white),
                  label: Text(
                    'تأجير عبر الواتساب',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // إجراء حجز المنتج
                  },
                  child: Text(
                    'احجز الآن',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
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
}

// نموذج Product للمثال
class Product {
  final String name;
  final List<String> images;
  final String location;
  final double price;
  final String description;
  final double rating;
  final List<String> features;

  Product({
    required this.name,
    required this.images,
    required this.location,
    required this.price,
    required this.description,
    required this.rating,
    required this.features,
  });
}