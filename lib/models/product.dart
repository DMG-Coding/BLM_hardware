class Product {
  final String name;
  final String image;
  final String price;
  final String description;
  final String category;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });

  // konvesyon depi JSON le nap itilize storage la
  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'price': price,
        'description': description,
        'category': category,
      };

  // kreyasyon depi JSON
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'],
        image: json['image'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
      );
}
