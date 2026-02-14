import 'product.dart';
import 'pc_config.dart';
import 'component.dart';

// Type d'article dans le panier
enum CartItemType {
  simpleProduct, // Produit simple (téléphone, chargeur, etc.)
  configurablePC, // PC configurable
  component, // Composant individuel
}

// Modèle pour un article dans le panier
class CartItem {
  final String id;
  final CartItemType type;
  
  // Pour les produits simples
  final Product? product;
  
  // Pour les PC configurables
  final PCConfig? pcConfig;
  
  // Pour les composants individuels
  final Component? component;
  
  final int quantity;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.type,
    this.product,
    this.pcConfig,
    this.component,
    this.quantity = 1,
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();

  // Constructeur pour produit simple
  factory CartItem.fromProduct(Product product, {int quantity = 1}) {
    return CartItem(
      id: 'prod_${product.name}_${DateTime.now().millisecondsSinceEpoch}',
      type: CartItemType.simpleProduct,
      product: product,
      quantity: quantity,
    );
  }

  // Constructeur pour PC configurable
  factory CartItem.fromPCConfig(PCConfig pcConfig, {int quantity = 1}) {
    return CartItem(
      id: 'pc_${pcConfig.id}_${DateTime.now().millisecondsSinceEpoch}',
      type: CartItemType.configurablePC,
      pcConfig: pcConfig,
      quantity: quantity,
    );
  }

  // Constructeur pour composant individuel
  factory CartItem.fromComponent(Component component, {int quantity = 1}) {
    return CartItem(
      id: 'comp_${component.id}_${DateTime.now().millisecondsSinceEpoch}',
      type: CartItemType.component,
      component: component,
      quantity: quantity,
    );
  }

  // Obtenir le nom de l'article
  String getName() {
    switch (type) {
      case CartItemType.simpleProduct:
        return product?.name ?? 'Produit inconnu';
      case CartItemType.configurablePC:
        return pcConfig?.name ?? 'PC inconnu';
      case CartItemType.component:
        return component?.name ?? 'Composant inconnu';
    }
  }

  // Obtenir l'image de l'article
  String getImage() {
    switch (type) {
      case CartItemType.simpleProduct:
        return product?.image ?? '';
      case CartItemType.configurablePC:
        return pcConfig?.image ?? '';
      case CartItemType.component:
        return component?.image ?? '';
    }
  }

  // Obtenir le prix unitaire
  double getUnitPrice() {
    switch (type) {
      case CartItemType.simpleProduct:
        if (product == null) return 0.0;
        final priceStr = product!.price.replaceAll('\$', '').replaceAll(',', '').trim();
        return double.tryParse(priceStr) ?? 0.0;
      case CartItemType.configurablePC:
        return pcConfig?.getTotalPrice() ?? 0.0;
      case CartItemType.component:
        return component?.price ?? 0.0;
    }
  }

  // Obtenir le prix total (unitaire × quantité)
  double getTotalPrice() {
    return getUnitPrice() * quantity;
  }

  // Obtenir la description/configuration
  String getDescription() {
    switch (type) {
      case CartItemType.simpleProduct:
        return product?.description ?? '';
      case CartItemType.configurablePC:
        return pcConfig?.getConfigSummary() ?? '';
      case CartItemType.component:
        return component?.description ?? '';
    }
  }

  // Obtenir la catégorie
  String getCategory() {
    switch (type) {
      case CartItemType.simpleProduct:
        return product?.category ?? '';
      case CartItemType.configurablePC:
        return pcConfig?.category ?? '';
      case CartItemType.component:
        return component?.getTypeDisplayName() ?? '';
    }
  }

  // Conversion vers JSON pour le stockage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'product': product?.toJson(),
      'pcConfig': pcConfig?.toJson(),
      'component': component?.toJson(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  // Création depuis JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    CartItemType type;
    switch (json['type']) {
      case 'CartItemType.simpleProduct':
        type = CartItemType.simpleProduct;
        break;
      case 'CartItemType.configurablePC':
        type = CartItemType.configurablePC;
        break;
      case 'CartItemType.component':
        type = CartItemType.component;
        break;
      default:
        type = CartItemType.simpleProduct;
    }

    return CartItem(
      id: json['id'] ?? '',
      type: type,
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      pcConfig: json['pcConfig'] != null ? PCConfig.fromJson(json['pcConfig']) : null,
      component: json['component'] != null ? Component.fromJson(json['component']) : null,
      quantity: json['quantity'] ?? 1,
      addedAt: json['addedAt'] != null 
          ? DateTime.parse(json['addedAt']) 
          : DateTime.now(),
    );
  }

  // Copier avec modifications
  CartItem copyWith({
    String? id,
    CartItemType? type,
    Product? product,
    PCConfig? pcConfig,
    Component? component,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      type: type ?? this.type,
      product: product ?? this.product,
      pcConfig: pcConfig ?? this.pcConfig,
      component: component ?? this.component,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  // Vérifier si deux items sont identiques (même produit/config)
  bool isSameItem(CartItem other) {
    if (type != other.type) return false;
    
    switch (type) {
      case CartItemType.simpleProduct:
        return product?.name == other.product?.name;
      case CartItemType.configurablePC:
        // Compare la configuration complète
        return pcConfig?.id == other.pcConfig?.id &&
               pcConfig?.selectedCpu?.id == other.pcConfig?.selectedCpu?.id &&
               pcConfig?.selectedGpu?.id == other.pcConfig?.selectedGpu?.id &&
               pcConfig?.selectedRam?.id == other.pcConfig?.selectedRam?.id &&
               pcConfig?.selectedStorage?.id == other.pcConfig?.selectedStorage?.id;
      case CartItemType.component:
        return component?.id == other.component?.id;
    }
  }
}