import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedFilterPage extends StatefulWidget {
  @override
  _AdvancedFilterPageState createState() => _AdvancedFilterPageState();
}

class _AdvancedFilterPageState extends State<AdvancedFilterPage> {
  String? selectedCategory;
  String? selectedLocation;
  double minPrice = 0;
  double maxPrice = 5000;
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  final List<String> categories = [
    'كل الفئات',
    'سيارات',
    'شقق',
    'أدوات كهربائية',
    'أثاث',
    'ملابس',
    'أجهزة إلكترونية'
  ];

  final List<String> locations = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'المنصورة',
    'الغردقة',
    'شرم الشيخ',
    'بورسعيد',
    'السويس',
    'طنطا',
    'المنيا'
  ];

  @override
  void initState() {
    super.initState();
    _minPriceController.text = minPrice.toStringAsFixed(0);
    _maxPriceController.text = maxPrice.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('فلاتر البحث',
              style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF25488E),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Filter
                    _buildSectionHeader('المنطقة'),
                    SizedBox(height: 8),
                    _buildLocationDropdown(),
                    SizedBox(height: 20),

                    // Category Filter
                    _buildSectionHeader('نوع الإيجار'),
                    SizedBox(height: 8),
                    _buildCategoryFilter(),
                    SizedBox(height: 20),

                    // Price Filter
                    _buildSectionHeader('نطاق السعر'),
                    SizedBox(height: 8),
                    _buildPriceRangeFilter(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Apply Button
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'location': selectedLocation,
                          'category': selectedCategory,
                          'minPrice': minPrice,
                          'maxPrice': maxPrice,
                        });
                      },
                      child: Text('تطبيق الفلاتر',
                          style: GoogleFonts.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)), // النص باللون الأبيض
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF25488E),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121)));
  }

  Widget _buildLocationDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: selectedLocation,
        isExpanded: true,
        underline: SizedBox(),
        hint: Text('اختر المنطقة',
            style: GoogleFonts.tajawal(color: Colors.grey)),
        items: locations.map((String location) {
          return DropdownMenuItem<String>(
            value: location,
            child: Text(location,
                style: GoogleFonts.tajawal(color: Color(0xFF212121))),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedLocation = newValue;
          });
        },
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = category == selectedCategory;
        return ChoiceChip(
          label: Text(category,
              style: GoogleFonts.tajawal(
                  color: isSelected ? Colors.white : Color(0xFF212121),
                  fontWeight: FontWeight.w500)),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedCategory = selected ? category : null;
            });
          },
          selectedColor: Color(0xFF25488E),
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
      }).toList(),
    );
  }

  Widget _buildPriceRangeFilter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          RangeSlider(
            values: RangeValues(minPrice, maxPrice),
            min: 0,
            max: 5000,
            divisions: 50,
            labels: RangeLabels(
              '${minPrice.toStringAsFixed(0)} ج.م',
              '${maxPrice.toStringAsFixed(0)} ج.م',
            ),
            activeColor: Color(0xFF25488E),
            inactiveColor: Color(0xFFF4C42D),
            onChanged: (values) {
              setState(() {
                minPrice = values.start;
                maxPrice = values.end;
                _minPriceController.text = minPrice.toStringAsFixed(0);
                _maxPriceController.text = maxPrice.toStringAsFixed(0);
              });
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPriceInputField(
                    controller: _minPriceController,
                    label: 'الحد الأدنى',
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        final newValue = double.tryParse(value) ?? minPrice;
                        if (newValue <= maxPrice) {
                          setState(() => minPrice = newValue);
                        }
                      }
                    }),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildPriceInputField(
                    controller: _maxPriceController,
                    label: 'الحد الأقصى',
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        final newValue = double.tryParse(value) ?? maxPrice;
                        if (newValue >= minPrice) {
                          setState(() => maxPrice = newValue);
                        }
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInputField({
    required TextEditingController controller,
    required String label,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.tajawal(color: Color(0xFF212121)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF25488E)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF25488E), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        suffixText: 'ج.م',
        suffixStyle: TextStyle(color: Color(0xFF212121)),
      ),
      onChanged: onChanged,
    );
  }
}