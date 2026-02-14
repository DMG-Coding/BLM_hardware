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

  // Conversion vers JSON pour storage
  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'price': price,
        'description': description,
        'category': category,
      };

  // Création depuis JSON
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'],
        image: json['image'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
      );
}
