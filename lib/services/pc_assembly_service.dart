import '../models/cart_item.dart';
import '../models/component.dart';

/// Service pour gérer la logique d'assemblage PC 3D
class PCAssemblyService {
  /// Types de composants nécessaires pour un PC complet
  static const List<String> essentialComponentTypes = [
    'cpu',
    'gpu',
    'motherboard',
    'ram',
    'storage',
  ];
  
  /// Composants optionnels
  static const List<String> optionalComponentTypes = [
    'psu',
    'case',
    'cooling',
  ];
  
  /// Vérifier si le panier contient assez de composants pour activer la vue 3D
  static bool canShowPC3D(List<CartItem> cartItems) {
    // Récupérer uniquement les composants
    final components = cartItems
        .where((item) => item.type == CartItemType.component)
        .toList();
    
    if (components.isEmpty) return false;
    
    // Compter les types de composants uniques
    final componentTypes = components
        .map((item) => item.component?.type.toLowerCase())
        .where((type) => type != null)
        .toSet();
    
    // Il faut au moins 3 composants différents pour activer la vue 3D
    // Par exemple: CPU + GPU + RAM ou CPU + Motherboard + Storage
    return componentTypes.length >= 3;
  }
  
  /// Obtenir les composants PC du panier
  static List<Component> getPCComponents(List<CartItem> cartItems) {
    return cartItems
        .where((item) => item.type == CartItemType.component)
        .map((item) => item.component)
        .where((comp) => comp != null)
        .cast<Component>()
        .toList();
  }
  
  /// Vérifier si on a tous les composants essentiels
  static bool hasCompletePC(List<CartItem> cartItems) {
    final components = getPCComponents(cartItems);
    final types = components.map((c) => c.type.toLowerCase()).toSet();
    
    // Vérifier qu'on a tous les composants essentiels
    return essentialComponentTypes.every((type) => types.contains(type));
  }
  
  /// Obtenir le niveau de complétude du PC (0.0 à 1.0)
  static double getCompletionLevel(List<CartItem> cartItems) {
    final components = getPCComponents(cartItems);
    final types = components.map((c) => c.type.toLowerCase()).toSet();
    
    int essentialCount = essentialComponentTypes
        .where((type) => types.contains(type))
        .length;
    
    return essentialCount / essentialComponentTypes.length;
  }
  
  /// Obtenir les composants manquants
  static List<String> getMissingComponents(List<CartItem> cartItems) {
    final components = getPCComponents(cartItems);
    final types = components.map((c) => c.type.toLowerCase()).toSet();
    
    return essentialComponentTypes
        .where((type) => !types.contains(type))
        .toList();
  }
  
  /// Obtenir un message informatif sur l'état du PC
  static String getAssemblyMessage(List<CartItem> cartItems) {
    final components = getPCComponents(cartItems);
    
    if (components.isEmpty) {
      return "Ajoutez des composants PC pour voir l'assemblage 3D";
    }
    
    final types = components.map((c) => c.type.toLowerCase()).toSet();
    final count = types.length;
    
    if (count < 3) {
      return "Ajoutez ${3 - count} composant(s) supplémentaire(s) pour activer la vue 3D";
    }
    
    if (hasCompletePC(cartItems)) {
      return "PC complet ! Voir l'assemblage 3D";
    }
    
    final missing = getMissingComponents(cartItems);
    if (missing.length == 1) {
      return "Presque complet ! Ajouter : ${_getComponentDisplayName(missing[0])}";
    }
    
    return "Voir l'assemblage 3D de votre configuration";
  }
  
  /// Obtenir le nom d'affichage d'un composant
  static String _getComponentDisplayName(String type) {
    switch (type.toLowerCase()) {
      case 'cpu': return 'Processeur';
      case 'gpu': return 'Carte Graphique';
      case 'motherboard': return 'Carte Mère';
      case 'ram': return 'Mémoire RAM';
      case 'storage': return 'Stockage';
      case 'psu': return 'Alimentation';
      case 'case': return 'Boîtier';
      case 'cooling': return 'Refroidissement';
      default: return type;
    }
  }
  
  /// Obtenir la couleur du badge selon le niveau de complétude
  static int getBadgeColor(List<CartItem> cartItems) {
    final completion = getCompletionLevel(cartItems);
    
    if (completion >= 1.0) {
      return 0xFF4CAF50; // Vert - Complet
    } else if (completion >= 0.6) {
      return 0xFFFFC107; // Orange - Presque complet
    } else if (completion >= 0.4) {
      return 0xFF2196F3; // Bleu - En cours
    } else {
      return 0xFF9E9E9E; // Gris - Début
    }
  }
}