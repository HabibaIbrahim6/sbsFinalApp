import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = [
    'الكترونيات',
    'أثاث',
    'أدوات منزلية',
    'ملابس',
    'أخرى'
  ];

  List<XFile> _selectedImages = [];
  XFile? _selectedVideo;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء اختيار الصور: ${e.toString()}')),
      );
    }
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        setState(() {
          _selectedVideo = video;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء اختيار الفيديو: ${e.toString()}')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _removeVideo() {
    setState(() {
      _selectedVideo = null;
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF25488E),
        elevation: 4,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              'إضافة منتج جديد',
              style: GoogleFonts.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Product Name Field
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'اسم المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _productNameController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'أدخل اسم المنتج',
                  hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال اسم المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Category Field
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'اختر فئة المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                hint: Text(
                  'اختر الفئة',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(color: Colors.grey),
                ),
                items: _categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        textAlign: TextAlign.right, style: GoogleFonts.tajawal()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب اختيار فئة المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Price Field
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'سعر المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _productPriceController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'أدخل السعر اليومي',
                  hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: Text(
                      'ج.م',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.tajawal(
                        color: const Color(0xFF25488E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال سعر المنتج';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يجب إدخال سعر صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Description Field
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'وصف المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _productDescriptionController,
                textAlign: TextAlign.right,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'أدخل وصفاً تفصيلياً للمنتج',
                  hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال وصف المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Images Upload
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'صور المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Display selected images
              if (_selectedImages.isNotEmpty)
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              // Upload images button
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: const Color(0xFF25488E),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'إضافة صور للمنتج',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFF25488E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Product Video Upload
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'فيديو المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Display selected video
              if (_selectedVideo != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_selectedVideo!.path),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Center(
                          child: Icon(
                            Icons.play_circle_filled,
                            color: Colors.white.withOpacity(0.8),
                            size: 50,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _removeVideo,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Upload video button
              GestureDetector(
                onTap: _pickVideo,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.video_library,
                        color: const Color(0xFF25488E),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedVideo == null
                            ? 'إضافة فيديو للمنتج'
                            : 'تغيير الفيديو',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFF25488E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'تم إضافة المنتج بنجاح',
                            style: GoogleFonts.tajawal(),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Here you would typically upload the data to your backend
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF4C42D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'إضافة المنتج',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
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