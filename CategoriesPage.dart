import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String _searchQuery = '';
  String _selectedFilter = 'كل الفئات';

  final List<String> _filters = ['كل الفئات', 'السيارات', 'الشقق/ السكن ', 'الملابس', 'الأثاث'];
  final List<Map<String, dynamic>> _items = [
    {
      'name': 'تويوتا كورولا',
      'category': 'السيارات',
      'location': 'الرياض - النخيل',
      'rating': '★★★★★',
      'image': 'assets/car1.jpg',
    },
    {
      'name': 'شقة فاخرة',
      'category': 'الشقق',
      'location': 'جدة - الكورنيش',
      'rating': '★★★★☆',
      'image': 'assets/apartment1.jpg',
    },
    {
      'name': 'فساتين سهرة',
      'category': 'الملابس',
      'location': 'الإسكندرية - سان ستيفانو',
      'rating': '★★★★★',
      'image': 'assets/dress1.jpg',
    },
    {
      'name': 'كنبة 3 مقاعد',
      'category': 'الأثاث',
      'location': 'القاهرة - مدينة نصر',
      'rating': '★★★☆☆',
      'image': 'assets/furniture1.jpg',
    },
  ];

  List<Map<String, dynamic>> get _filteredItems {
    return _items.where((item) {
      final matchesSearch = item['name'].toString().contains(_searchQuery) ||
          item['location'].toString().contains(_searchQuery);
      final matchesFilter = _selectedFilter == 'كل الفئات' ||
          item['category'] == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الفئات'),
          backgroundColor: Color(0xFF1C3D5A),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'ابحث بالاسم أو المنطقة',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filters.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FilterChip(
                            label: Text(filter),
                            selected: _selectedFilter == filter,
                            onSelected: (selected) {
                              setState(() {
                                _selectedFilter = filter;
                              });
                            },
                            selectedColor: Color(0xFF1C3D5A),
                            labelStyle: TextStyle(
                              color: _selectedFilter == filter
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(child: Text('لا توجد نتائج'))
                  : ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(item['image']),
                      ),
                      title: Text(item['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['location']),
                          SizedBox(height: 4),
                          Text(item['rating'],
                              style: TextStyle(color: Colors.amber)),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // عرض التفاصيل
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1C3D5A),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Text('عرض التفاصيل'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}