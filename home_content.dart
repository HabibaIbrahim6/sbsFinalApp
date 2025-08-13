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