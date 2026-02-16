class Component {
  final String id;
  final String name;
  final String type; 
  final double price;
  final String image;
  final String description;
  final Map<String, dynamic> specs; 

  Component({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    required this.description,
    this.specs = const {},
  });

  // konvesyon depi fichye JSON nn
  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      specs: json['specs'] ?? {},
    );
  }

  // konvesyon bay fichye JSON nn
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'price': price,
        'image': image,
        'description': description,
        'specs': specs,
      };

  // kopyel ak modifikasyon
  Component copyWith({
    String? id,
    String? name,
    String? type,
    double? price,
    String? image,
    String? description,
    Map<String, dynamic>? specs,
  }) {
    return Component(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      specs: specs ?? this.specs,
    );
  }

  
  String getTypeDisplayName() {
    switch (type.toLowerCase()) {
      case 'cpu':
        return 'Processeur';
      case 'gpu':
        return 'Carte Graphique';
      case 'ram':
        return 'Mémoire RAM';
      case 'storage':
        return 'Stockage';
      case 'motherboard':
        return 'Carte Mère';
      case 'psu':
        return 'Alimentation';
      case 'case':
        return 'Boîtier';
      case 'cooling':
        return 'Refroidissement';
      default:
        return type;
    }
  }
}