class Product {
  final List<String> images;
  final String? time;
  final int price;
  final int decount;
  final String description;

  Product({
    required this.images,
    required this.price,
    required this.decount,
    required this.description,
    this.time,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      images: List<String>.from(json['images']),
      time: json['time'],
      price: json['price'],
      decount: json['decount'],
      description: json['description'],
    );
  }
}
