import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../models/pc_config.dart';
import '../models/component.dart';
import '../data/product_data.dart';

class ApiService {
  //pati kach pou evite rechajeman done yo 
  static List<Product>? _cachedProducts;
  static List<PCConfig>? _cachedPCConfigs;
  static List<Component>? _cachedComponents;

  
  
  /// Rekipere tt pwodui depi lokal
  static Future<List<Product>> fetchProducts() async {
    if (_cachedProducts != null) {
      return _cachedProducts!;
    }

    try {
      // la nou fh an itilize donne lokal yo nn plas done JSON yo
      _cachedProducts = ProductData.getLocalProducts();
      return _cachedProducts!;
    } catch (e) {
      print('Erreur chargement produits: $e');
      return _getFallbackProducts();
    }
  }

  /// Rekipre pwodui yo p kategori
  static Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final allProducts = await fetchProducts();
      
      // epi filtre yo
      return allProducts.where((product) => 
        product.category.toLowerCase() == category.toLowerCase()
      ).toList();
    } catch (e) {
      print('Erreur catégorie: $e');
      return [];
    }
  }

  /// Rekipere kategori ki disponib yo
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
  
  
  static Future<List<PCConfig>> fetchConfigurablePCs() async {
    if (_cachedPCConfigs != null) {
      return _cachedPCConfigs!;
    }

    try {
      // load fichye JSon nn depi lokal
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

  /// Rekipre yon PC ke itilizate a ka konfigire avek ID an
  static Future<PCConfig?> fetchPCConfigById(String id) async {
    final pcs = await fetchConfigurablePCs();
    try {
      return pcs.firstWhere((pc) => pc.id == id);
    } catch (e) {
      return null;
    }
  }

  // ========== COMPOSANTS INDIVIDUELS ==========
  
  
  static Future<List<Component>> fetchComponents() async {
    if (_cachedComponents != null) {
      return _cachedComponents!;
    }

    try {
      // fel pran done yo depi PRODUCT_DATA.DART
      final componentProducts = ProductData.getComponents();
      
      
      _cachedComponents = componentProducts.map((product) {
        // Detemine nn klas components lan
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

  /// we or kapab detekste composant a led de pri ak deskripsyon
  static String _detectComponentType(String name, String description) {
    final nameLower = name.toLowerCase();
    final descLower = description.toLowerCase();
    
    
    if (nameLower.contains('ryzen') || 
        nameLower.contains('intel') || 
        nameLower.contains('core') ||
        nameLower.contains('i9') ||
        nameLower.contains('i7') ||
        nameLower.contains('i5') ||
        nameLower.contains('i3')) {
      return 'cpu';
    }
    
    
    if (nameLower.contains('rtx') || 
        nameLower.contains('radeon') || 
        nameLower.contains('geforce') ||
        nameLower.contains('nvidia') ||
        nameLower.contains('rx ') ||
        (nameLower.contains('amd') && (nameLower.contains('7900') || nameLower.contains('9070')))) {
      return 'gpu';
    }
    
   
    if (nameLower.contains('ddr') || 
        descLower.contains('ram') ||
        nameLower.contains('memory') ||
        nameLower.contains('vengeance') ||
        nameLower.contains('trident')) {
      return 'ram';
    }
    
    
    if (descLower.contains('ssd') || 
        descLower.contains('nvme') ||
        (nameLower.contains('samsung') && descLower.contains('pro')) ||
        nameLower.contains('crucial') ||
        nameLower.contains('wd black')) {
      return 'storage';
    }
    
    
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
    
    
    if (descLower.contains('w,') || 
        descLower.contains('watt') || 
        descLower.contains('titanium') ||
        descLower.contains('platinum') ||
        (descLower.contains('modular') && (nameLower.contains('corsair') || nameLower.contains('seasonic') || nameLower.contains('asus')))) {
      return 'psu';
    }
    
    
    if (nameLower.contains('lian li') || 
        nameLower.contains('cooler master') ||
        nameLower.contains('fractal') ||
        descLower.contains('mid-tower') ||
        descLower.contains('mini-itx') ||
        descLower.contains('full-tower')) {
      return 'case';
    }
    
    
    if (nameLower.contains('noctua') || 
        nameLower.contains('deepcool') ||
        nameLower.contains('arctic') ||
        descLower.contains('cooling') ||
        descLower.contains('cooler') ||
        (descLower.contains('tower') && descLower.contains('fans'))) {
      return 'cooling';
    }
    
    
    return 'cpu';
  }

  /// Récupérer les composants par type
  static Future<List<Component>> fetchComponentsByType(String type) async {
    final components = await fetchComponents();
    return components.where((c) => c.type.toLowerCase() == type.toLowerCase()).toList();
  }

  // powodui kreye an ka sekou or si yo pa vle load si ta gn mesaj ere or ere
  static List<Product> _getFallbackProducts() {
    return ProductData.getLocalProducts().take(10).toList();
  }

  /// pati kategori a
  static List<String> _getFallbackCategories() {
    return [
      'Téléphones',
      'Laptops',
      'PC Gaming',
      'Composants',
      'Accessoires',
    ];
  }

  // pati RECHERCHE kote kapab cheche pa non
  
  
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

  
  static void clearCache() {
    _cachedProducts = null;
    _cachedPCConfigs = null;
    _cachedComponents = null;
  }
}