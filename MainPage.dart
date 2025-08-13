import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_details.dart';
import  'account_typePage.dart';
import 'aboutUs.dart';
import 'ContactUS.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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
      category: 'الكترونيات',
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
      category: 'عقارات',
      location: 'المعادي',
      description: 'شقة فاخرة مفروشة بالكامل، 3 غرف نوم، 2 حمام، مطبخ مجهز، إطلالة على النيل',
      price: 2500,
      imageUrl: 'assets/images/apartment.jpg',
      rating: 4.7,
      ownerName: 'شركة النخبة العقارية',
      ownerPhone: '01098765432',
      images: ['assets/images/apartment.jpg', 'assets/images/apartment2.jpg', 'assets/images/apartment3.jpg'],
    ),
    Product(
      id: '4',
      name: 'فستان زفاف فاخر',
      category: 'ملابس',
      location: 'المعادي',
      description: 'فستان زفاف بتصميم فرنسي، مقاس 48، لون أبيض لؤلؤي، مع تطريز يدوي',
      price: 800,
      imageUrl: 'assets/images/dress.jpg',
      rating: 4.3,
      ownerName: 'صالون روز',
      ownerPhone: '01554321098',
      images: ['assets/images/dress.jpg', 'assets/images/dress2.jpg'],
    ),
  ];

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
    ),
    body: IndexedStack(
    index: _currentIndex,
    children: _pages,
    ),
    bottomNavigationBar: _buildBottomNavBar(),
    ));

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

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _HomePageState state = context.findAncestorStateOfType<_HomePageState>()!;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchBar(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            ),
          ),
          _buildProductsGrid(state.staticProducts, context),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
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
              onPressed: () {
                Navigator.pushNamed(context, '/filterpage');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesRow() {
    final categories = [
      {'name': 'السيارات', 'icon': Icons.directions_car, 'color': Color(0xFF4CAF50)},
      {'name': 'العقارات', 'icon': Icons.home, 'color': Color(0xFF2196F3)},
      {'name': 'الالكترونيات', 'icon': Icons.camera_alt, 'color': Color(0xFF9C27B0)},
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
          childAspectRatio: 0.7,
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
            builder: (context) => ProductDetailsPage(product: ),
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
                height: 120,
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