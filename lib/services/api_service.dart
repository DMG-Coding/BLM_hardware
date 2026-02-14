import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../models/pc_config.dart';
import '../models/component.dart';
import '../data/product_data.dart';

class ApiService {
  // Cache pour éviter de recharger les données
  static List<Product>? _cachedProducts;
  static List<PCConfig>? _cachedPCConfigs;
  static List<Component>? _cachedComponents;

  // ========== PRODUITS DEPUIS DONNÉES LOCALES ==========
  
  /// Récupérer tous les produits depuis les données locales
  static Future<List<Product>> fetchProducts() async {
    if (_cachedProducts != null) {
      return _cachedProducts!;
    }

    try {
      // UTILISER LES DONNÉES LOCALES au lieu de DummyJSON
      _cachedProducts = ProductData.getLocalProducts();
      return _cachedProducts!;
    } catch (e) {
      print('Erreur chargement produits: $e');
      return _getFallbackProducts();
    }
  }

  /// Récupérer les produits par catégorie
  static Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final allProducts = await fetchProducts();
      
      // Filtrer par catégorie
      return allProducts.where((product) => 
        product.category.toLowerCase() == category.toLowerCase()
      ).toList();
    } catch (e) {
      print('Erreur catégorie: $e');
      return [];
    }
  }

  /// Récupérer les catégories disponibles
  static Future<List<String>> fetchCategories() async {
    try {
      return ProductData.categories
          .map((cat) => cat['name'] as String)
          .toList();
    } catch (e) {
      print('Erreur catégories: $e');
      return _getFallbackCategories();
    }
  }

  // ========== PC CONFIGURABLES DEPUIS JSON LOCAL ==========
  
  /// Récupérer les PC configurables depuis le fichier JSON local
  static Future<List<PCConfig>> fetchConfigurablePCs() async {
    if (_cachedPCConfigs != null) {
      return _cachedPCConfigs!;
    }

    try {
      // Charger le fichier JSON depuis les assets
      final String jsonString = await rootBundle.loadString(
        'assets/data/configurable_pcs.json',
      );
      
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> pcsJson = jsonData['configurablePCs'] ?? [];
      
      _cachedPCConfigs = pcsJson.map((json) {
        return PCConfig.fromJson(json);
      }).toList();
      
      return _cachedPCConfigs!;
    } catch (e) {
      print('Erreur chargement PC configurables: $e');
      return [];
    }
  }

  /// Récupérer un PC configurable par ID
  static Future<PCConfig?> fetchPCConfigById(String id) async {
    final pcs = await fetchConfigurablePCs();
    try {
      return pcs.firstWhere((pc) => pc.id == id);
    } catch (e) {
      return null;
    }
  }

  // ========== COMPOSANTS INDIVIDUELS ==========
  
  /// Récupérer tous les composants individuels
  /// NOUVELLE VERSION : Charge depuis product_data.dart et convertit en Component
  static Future<List<Component>> fetchComponents() async {
    if (_cachedComponents != null) {
      return _cachedComponents!;
    }

    try {
      // CHARGER LES COMPOSANTS DEPUIS PRODUCT_DATA.DART
      final componentProducts = ProductData.getComponents();
      
      // CONVERTIR Product → Component
      _cachedComponents = componentProducts.map((product) {
        // Déterminer le type de composant
        String type = _detectComponentType(product.name, product.description);
        
        // Extraire le prix numérique
        final priceStr = product.price.replaceAll('\$', '').replaceAll(',', '').trim();
        final price = double.tryParse(priceStr) ?? 0.0;
        
        // Créer le Component
        return Component(
          id: 'comp_${product.name.hashCode}',
          name: product.name,
          type: type,
          price: price,
          image: product.image,
          description: product.description,
          specs: {},
        );
      }).toList();
      
      return _cachedComponents!;
    } catch (e) {
      print('Erreur chargement composants: $e');
      return [];
    }
  }

  /// Détecter le type de composant à partir du nom et de la description
  static String _detectComponentType(String name, String description) {
    final nameLower = name.toLowerCase();
    final descLower = description.toLowerCase();
    
    // CPU
    if (nameLower.contains('ryzen') || 
        nameLower.contains('intel') || 
        nameLower.contains('core') ||
        nameLower.contains('i9') ||
        nameLower.contains('i7') ||
        nameLower.contains('i5') ||
        nameLower.contains('i3')) {
      return 'cpu';
    }
    
    // GPU
    if (nameLower.contains('rtx') || 
        nameLower.contains('radeon') || 
        nameLower.contains('geforce') ||
        nameLower.contains('nvidia') ||
        nameLower.contains('rx ') ||
        (nameLower.contains('amd') && (nameLower.contains('7900') || nameLower.contains('9070')))) {
      return 'gpu';
    }
    
    // RAM
    if (nameLower.contains('ddr') || 
        descLower.contains('ram') ||
        nameLower.contains('memory') ||
        nameLower.contains('vengeance') ||
        nameLower.contains('trident')) {
      return 'ram';
    }
    
    // Storage
    if (descLower.contains('ssd') || 
        descLower.contains('nvme') ||
        (nameLower.contains('samsung') && descLower.contains('pro')) ||
        nameLower.contains('crucial') ||
        nameLower.contains('wd black')) {
      return 'storage';
    }
    
    // Motherboard
    if ((nameLower.contains('asus') || 
         nameLower.contains('msi') || 
         nameLower.contains('gigabyte')) && 
        (descLower.contains('z790') || 
         descLower.contains('x670') ||
         descLower.contains('b760') ||
         descLower.contains('motherboard') ||
         descLower.contains('lga') ||
         descLower.contains('am5'))) {
      return 'motherboard';
    }
    
    // PSU (Alimentation)
    if (descLower.contains('w,') || 
        descLower.contains('watt') || 
        descLower.contains('titanium') ||
        descLower.contains('platinum') ||
        (descLower.contains('modular') && (nameLower.contains('corsair') || nameLower.contains('seasonic') || nameLower.contains('asus')))) {
      return 'psu';
    }
    
    // Case (Boîtier)
    if (nameLower.contains('lian li') || 
        nameLower.contains('cooler master') ||
        nameLower.contains('fractal') ||
        descLower.contains('mid-tower') ||
        descLower.contains('mini-itx') ||
        descLower.contains('full-tower')) {
      return 'case';
    }
    
    // Cooling
    if (nameLower.contains('noctua') || 
        nameLower.contains('deepcool') ||
        nameLower.contains('arctic') ||
        descLower.contains('cooling') ||
        descLower.contains('cooler') ||
        (descLower.contains('tower') && descLower.contains('fans'))) {
      return 'cooling';
    }
    
    // Défaut : CPU si on ne sait pas
    return 'cpu';
  }

  /// Récupérer les composants par type
  static Future<List<Component>> fetchComponentsByType(String type) async {
    final components = await fetchComponents();
    return components.where((c) => c.type.toLowerCase() == type.toLowerCase()).toList();
  }

  // ========== DONNÉES DE SECOURS ==========
  
  /// Produits de secours en cas d'erreur
  static List<Product> _getFallbackProducts() {
    return ProductData.getLocalProducts().take(10).toList();
  }

  /// Catégories de secours
  static List<String> _getFallbackCategories() {
    return [
      'Téléphones',
      'Laptops',
      'PC Gaming',
      'Composants',
      'Accessoires',
    ];
  }

  // ========== RECHERCHE ==========
  
  /// Rechercher des produits par nom
  static Future<List<Product>> searchProducts(String query) async {
    try {
      final allProducts = await fetchProducts();
      final queryLower = query.toLowerCase();
      
      return allProducts.where((product) => 
        product.name.toLowerCase().contains(queryLower) ||
        product.description.toLowerCase().contains(queryLower) ||
        product.category.toLowerCase().contains(queryLower)
      ).toList();
    } catch (e) {
      print('Erreur recherche: $e');
      return [];
    }
  }

  // ========== UTILITAIRES ==========
  
  /// Vider le cache
  static void clearCache() {
    _cachedProducts = null;
    _cachedPCConfigs = null;
    _cachedComponents = null;
  }
}