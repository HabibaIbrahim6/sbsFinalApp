import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'product_details.dart';
import 'account_typePage.dart';
import 'aboutUs.dart';
import 'ContactUS.dart';
import 'FilterPage.dart'; // Corrected import path2

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final ValueNotifier<Map<String, dynamic>> _filterNotifier = ValueNotifier({
    'searchQuery': '',
    'selectedCategory': null,
    'selectedLocation': null,
    'minPrice': 0.0,
    'maxPrice': 5000.0,
  });

  final List<Map<String, dynamic>> adsList = [
    {
      'title': 'خصم 20% على إيجار السيارات',
      'body': 'لا تفوت فرصة الحصول على خصم كبير عند إيجار أي سيارة اليوم! العرض سارٍ لمدة 24 ساعة فقط.',
      'buttonText': 'احصل على الخصم الآن',
      'imageUrl': 'assets/images/car_ad.png',
    },
    {
      'title': 'أثاث جديد للإيجار',
      'body': 'أضف لمسة جمالية لمنزلك مع أحدث قطع الأثاث. خصومات تصل إلى 30% على جميع الإيجارات.',
      'buttonText': 'تصفح الآن',
      'imageUrl': 'assets/images/R.jpeg',
    },
    {
      'title': 'كاميرات احترافية للإيجار',
      'body': 'التقط أجمل لحظاتك بأحدث الكاميرات. خصم خاص للمحترفين والمصورين الهواة.',
      'buttonText': 'اكتشف المزيد',
      'imageUrl': 'assets/images/camera.webp',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          _showRandomAdModal(context);
        }
      });
    });
  }

  void _showRandomAdModal(BuildContext context) {
    if (adsList.isEmpty) return;
    final random = Random();
    final randomAd = adsList[random.nextInt(adsList.length)];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        child: Image.asset(
                          randomAd['imageUrl'],
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                          splashRadius: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          randomAd['title'],
                          style: GoogleFonts.tajawal(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF25488E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          randomAd['body'],
                          style: GoogleFonts.tajawal(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            randomAd['buttonText'],
                            style: GoogleFonts.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF4C42D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final List<Widget> _pages = [
    HomeContent(),
    AccountTypePage(),
    ContactUsPage(),
    AboutUsPage(),
  ];

  final List<Product> staticProducts = [
    Product(
      id: '1',
      name: 'تويوتا كورولا 2022',
      category: 'سيارات',
      location: 'القاهرة',
      description: 'سيارة تويوتا كورولا موديل 2022، ناقل حركة أوتوماتيك، مكيف هواء، استهلاك بنزين اقتصادي',
      price: 1500,
      imageUrl: 'assets/images/car.png',
      rating: 4.5,
      ownerName: 'أحمد محمد',
      ownerPhone: '01234567890',
      images: ['assets/images/car.png', 'assets/images/car2.jpg', 'assets/images/car3.jpg'],
    ),
    Product(
      id: '2',
      name: 'كاميرا كانون EOS R5',
      category: 'أجهزة إلكترونية',
      location: 'الجيزة',
      description: 'كاميرا احترافية مع عدسات متعددة، دقة 45 ميجابكسل، تصوير 8K',
      price: 1200,
      imageUrl: 'assets/images/camera.webp',
      rating: 4.8,
      ownerName: 'مصطفى محمود',
      ownerPhone: '01123456789',
      images: ['assets/images/camera.webp', 'assets/images/camera2.jpg'],
    ),
    Product(
      id: '3',
      name: 'شقة مفروشة بالمعادي',
      category: 'شقق',
      location: 'المعادي',
      description: 'شقة فاخرة مفروشة بالكامل، 3 غرف نوم، 2 حمام، مطبخ مجهز، إطلالة على النيل',
      price: 2500,
      imageUrl: 'assets/images/OIP.webp',
      rating: 4.7,
      ownerName: 'شركة النخبة العقارية',
      ownerPhone: '01098765432',
      images: ['assets/images/apartment.jpg', 'assets/images/apartment2.jpg', 'assets/images/apartment3.jpg'],
    ),
    Product(
      id: '4',
      name: 'فستان زفاف فاخر',
      category: 'ملابس',
      location: 'المنصورة',
      description: 'فستان زفاف بتصميم فرنسي، مقاس 48، لون أبيض لؤلؤي، مع تطريز يدوي',
      price: 800,
      imageUrl: 'assets/images/dress.jpg',
      rating: 4.3,
      ownerName: 'صالون روز',
      ownerPhone: '01554321098',
      images: ['assets/images/dress.jpg', 'assets/images/dress2.jpg'],
    ),
  ];

  List<Product> get filteredProducts {
    final filters = _filterNotifier.value;
    return staticProducts.where((product) {
      final String searchQuery = filters['searchQuery']?.toLowerCase() ?? '';
      final String? selectedCategory = filters['selectedCategory'];
      final String? selectedLocation = filters['selectedLocation'];
      final double minPrice = filters['minPrice'];
      final double maxPrice = filters['maxPrice'];

      bool matchesSearch = true;
      if (searchQuery.isNotEmpty) {
        matchesSearch = product.name.toLowerCase().contains(searchQuery) ||
            product.category.toLowerCase().contains(searchQuery) ||
            product.description.toLowerCase().contains(searchQuery);
      }

      final isAllCategories = selectedCategory == 'كل الفئات' || selectedCategory == null;
      final matchesCategory = isAllCategories || product.category == selectedCategory;
      final matchesLocation = selectedLocation == null || product.location == selectedLocation;
      final matchesPrice = product.price >= minPrice && product.price <= maxPrice;

      return matchesSearch && matchesCategory && matchesLocation && matchesPrice;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, color: Color(0xFFF4C42D)),
              SizedBox(width: 8),
              Text(
                'إيجارك',
                style: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF25488E),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'أهلاً بك في أكبر منصة للإيجارات اليومية',
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

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
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF25488E),
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'نوع الحساب',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'تواصل معنا',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'من نحن',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _productRequestFormKey = GlobalKey<FormState>();
  late TextEditingController _productNameController;
  late TextEditingController _productDescriptionController;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
    _productDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _HomePageState state = context.findAncestorStateOfType<_HomePageState>()!;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchBar(context, state),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state._filterNotifier.value['searchQuery'].isEmpty) ...[
                  Text(
                    'الفئات',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25488E),
                    ),
                  ),
                  _buildCategoriesRow(),
                  SizedBox(height: 16),
                  Text(
                    'أحدث المنتجات',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25488E),
                    ),
                  ),
                ],
              ],
            ),
          ),
          ValueListenableBuilder<Map<String, dynamic>>(
            valueListenable: state._filterNotifier,
            builder: (context, filters, child) {
              final filteredProducts = state.filteredProducts;

              if (filteredProducts.isEmpty) {
                return _buildProductNotFound(context, state);
              } else {
                return _buildProductsGrid(filteredProducts, context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, _HomePageState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                controller: state._searchController,
                onChanged: (value) {
                  state._filterNotifier.value = {
                    ...state._filterNotifier.value,
                    'searchQuery': value,
                  };
                },
                decoration: InputDecoration(
                  hintText: 'ابحث عن منتج للإيجار...',
                  hintStyle: GoogleFonts.tajawal(),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF25488E)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Color(0xFF25488E),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: Colors.white),
              onPressed: () async {
                final currentFilters = state._filterNotifier.value;
                final Map<String, dynamic>? newFilters = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdvancedFilterPage(
                      initialCategory: currentFilters['selectedCategory'],
                      initialLocation: currentFilters['selectedLocation'],
                      initialMinPrice: currentFilters['minPrice'],
                      initialMaxPrice: currentFilters['maxPrice'],
                    ),
                  ),
                );
                if (newFilters != null) {
                  state._filterNotifier.value = {
                    ...state._filterNotifier.value,
                    ...newFilters,
                  };
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductNotFound(BuildContext context, _HomePageState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 40),
          Icon(Icons.search_off, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'لم يتم العثور على المنتج',
            style: GoogleFonts.tajawal(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF25488E),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'لا يوجد منتج مطابق لبحثك',
            style: GoogleFonts.tajawal(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              state._searchController.clear();
              state._filterNotifier.value = {
                'searchQuery': '',
                'selectedCategory': null,
                'selectedLocation': null,
                'minPrice': 0.0,
                'maxPrice': 5000.0,
              };
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF25488E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'إعادة تعيين الفلاتر',
              style: GoogleFonts.tajawal(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Text(
            'يمكنك طلب هذا المنتج إذا كان غير متوفر',
            style: GoogleFonts.tajawal(
              fontSize: 16,
              color: Color(0xFF25488E),
            ),
          ),
          SizedBox(height: 20),
          _buildProductRequestForm(state),
        ],
      ),
    );
  }

  Widget _buildProductRequestForm(_HomePageState state) {
    return Form(
      key: _productRequestFormKey,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'اسم المنتج المطلوب',
                labelStyle: GoogleFonts.tajawal(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال اسم المنتج';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _productDescriptionController,
              decoration: InputDecoration(
                labelText: 'وصف المنتج المطلوب',
                labelStyle: GoogleFonts.tajawal(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 12),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال وصف المنتج';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_productRequestFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم إرسال طلب المنتج بنجاح'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _productNameController.clear();
                  _productDescriptionController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF25488E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'إرسال الطلب',
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesRow() {
    final categories = [
      {'name': 'السيارات', 'icon': Icons.directions_car, 'color': Color(0xFF4CAF50)},
      {'name': 'العقارات', 'icon': Icons.home, 'color': Color(0xFF2196F3)},
      {'name': 'أجهزة إلكترونية', 'icon': Icons.camera_alt, 'color': Color(0xFF9C27B0)},
      {'name': 'الملابس', 'icon': Icons.checkroom, 'color': Color(0xFFFF9800)},
    ];

    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: categories[index]['color'] as Color,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: (categories[index]['color'] as Color).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    categories[index]['icon'] as IconData,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  categories[index]['name'] as String,
                  style: GoogleFonts.tajawal(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(List<Product> products, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75, // تم تعديل هذه القيمة لاستيعاب الزر الجديد
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index], context);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[200],
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25488E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        product.location,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      ...List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < product.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          size: 16,
                          color: Color(0xFFF4C42D),
                        );
                      }),
                      SizedBox(width: 4),
                      Text(
                        '(${product.rating})',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${product.price} ج.م / اليوم',
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(product: product),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF25488E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Text(
                        'عرض التفاصيل',
                        style: GoogleFonts.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
}

class Product {
  final String id;
  final String name;
  final String category;
  final String location;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String ownerName;
  final String ownerPhone;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.ownerName,
    required this.ownerPhone,
    required this.images,
  });
}
