import '../models/cart_item.dart';
import '../models/component.dart';


class PCAssemblyService {
  
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
  
  /// we si panye gn minimum 3 konpoze pou bouton an akstive
  static bool canShowPC3D(List<CartItem> cartItems) {
    
    final components = cartItems
        .where((item) => item.type == CartItemType.component)
        .toList();
    
    if (components.isEmpty) return false;
    
    // konte konbyen konpozan ki gn pou we si boutton 3D a ka afiche
    final componentTypes = components
        .map((item) => item.component?.type.toLowerCase())
        .where((type) => type != null)
        .toSet();
    
    // fh an kelke sot fow gn pou pi piti 3 konpozan poul k bay yon previzyon 3D lew pral achte an
    
    return componentTypes.length >= 3;
  }
  
  /// gn konpozan PC nn panye an
  static List<Component> getPCComponents(List<CartItem> cartItems) {
    return cartItems
        .where((item) => item.type == CartItemType.component)
        .map((item) => item.component)
        .where((comp) => comp != null)
        .cast<Component>()
        .toList();
  }
  
  /// Verifye si gn tt konpozan esasyel yo pou PC an
  static bool hasCompletePC(List<CartItem> cartItems) {
    final components = getPCComponents(cartItems);
    final types = components.map((c) => c.type.toLowerCase()).toSet();
    
    
    return essentialComponentTypes.every((type) => types.contains(type));
  }
  
  
  static double getCompletionLevel(List<CartItem> cartItems) {
    final components = getPCComponents(cartItems);
    final types = components.map((c) => c.type.toLowerCase()).toSet();
    
    int essentialCount = essentialComponentTypes
        .where((type) => types.contains(type))
        .length;
    
    return essentialCount / essentialComponentTypes.length;
  }
  
  /// jwenn konpozan manke yo
  static List<String> getMissingComponents(List<CartItem> cartItems) {
    final components = getPCComponents(cartItems);
    final types = components.map((c) => c.type.toLowerCase()).toSet();
    
    return essentialComponentTypes
        .where((type) => !types.contains(type))
        .toList();
  }
  
  /// bay mesaj sou eta PC a
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
  
  /// pou kapab gnyn nom konpozan ki afiche an
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
      return 0xFF4CAF50; 
    } else if (completion >= 0.6) {
      return 0xFFFFC107; 
    } else if (completion >= 0.4) {
      return 0xFF2196F3; 
    } else {
      return 0xFF9E9E9E; 
    }
  }
}