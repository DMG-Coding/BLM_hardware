import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../models/pc_config.dart';
import '../models/component.dart';

class CartService {
  static const String _cartKey = 'cart_items';

  
  
  /// pati pou ajoute yon pwodui senp
  static Future<void> addProduct(Product product, {int quantity = 1}) async {
    final cartItem = CartItem.fromProduct(product, quantity: quantity);
    await _addCartItem(cartItem);
  }

  /// ajoute yon PC konfigire
  static Future<void> addPCConfig(PCConfig pcConfig, {int quantity = 1}) async {
    final cartItem = CartItem.fromPCConfig(pcConfig, quantity: quantity);
    await _addCartItem(cartItem);
  }

  /// Ajoute yon konpozan PC nn panye a
  static Future<void> addComponent(Component component, {int quantity = 1}) async {
    final cartItem = CartItem.fromComponent(component, quantity: quantity);
    await _addCartItem(cartItem);
  }

  
  static Future<void> _addCartItem(CartItem newItem) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    
    // Vérifier si un item identique existe déjà
    bool itemFound = false;
    List<CartItem> cartItems = cart.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
    
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].isSameItem(newItem)) {
        // Augmente kanitite a an fonksyon de pri konpozan
        cartItems[i] = cartItems[i].copyWith(
          quantity: cartItems[i].quantity + newItem.quantity,
        );
        itemFound = true;
        break;
      }
    }
    
    // Sil pa egziste kreyel
    if (!itemFound) {
      cartItems.add(newItem);
    }
    
    //save paye a
    cart = cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_cartKey, cart);
  }

 
  
  /// Rekipere tt bgy ki nn panye a
  static Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    return cart.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
  }

  /// Rekipre pwodui senp yo pou plis lwil poul
  static Future<List<Product>> getProducts() async {
    final cartItems = await getCartItems();
    return cartItems
        .where((item) => item.type == CartItemType.simpleProduct)
        .map((item) => item.product!)
        .toList();
  }

 
  
  /// Retire yon bgy nn panye a
  static Future<void> removeItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      await prefs.setStringList(_cartKey, cart);
    }
  }

  /// Retire yon pwodui ansyen
  static Future<void> removeProduct(int index) async {
    await removeItem(index);
  }

  ///  update kanite pri pwodui nn panye a
  static Future<void> updateQuantity(int index, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(index);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    
    if (index >= 0 && index < cart.length) {
      List<CartItem> cartItems = cart.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
      cartItems[index] = cartItems[index].copyWith(quantity: newQuantity);
      cart = cartItems.map((item) => jsonEncode(item.toJson())).toList();
      await prefs.setStringList(_cartKey, cart);
    }
  }

  /// Vide sak nn panye a
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

 
  
  /// kalkile prix total bgy ki nn panye a
  static Future<double> calculateCartTotal() async {
    final cartItems = await getCartItems();
    return cartItems.fold<double>(0.0, (total, item) => total + item.getTotalPrice());
  }

 
  static double calculateTotal(List<Product> products) {
    return products.fold(0, (total, product) {
      final priceStr = product.price.replaceAll('\$', '').replaceAll(',', '').trim();
      return total + (double.tryParse(priceStr) ?? 0);
    });
  }

  /// we nonb total bgy ki nn panye a
  static Future<int> getCartItemCount() async {
    final cartItems = await getCartItems();
    return cartItems.fold<int>(0, (total, item) => total + item.quantity);
  }

  
  
  /// Obtenir les statistiques du panier
  static Future<Map<String, dynamic>> getCartStats() async {
    final cartItems = await getCartItems();
    
    int productCount = 0;
    int pcConfigCount = 0;
    int componentCount = 0;
    double total = 0.0;
    
    for (var item in cartItems) {
      total += item.getTotalPrice();
      
      switch (item.type) {
        case CartItemType.simpleProduct:
          productCount += item.quantity;
          break;
        case CartItemType.configurablePC:
          pcConfigCount += item.quantity;
          break;
        case CartItemType.component:
          componentCount += item.quantity;
          break;
      }
    }
    
    return {
      'totalItems': cartItems.length,
      'productCount': productCount,
      'pcConfigCount': pcConfigCount,
      'componentCount': componentCount,
      'totalPrice': total,
    };
  }

 
  
  /// gade si panier a vid anavan afiche
  static Future<bool> isCartEmpty() async {
    final cartItems = await getCartItems();
    return cartItems.isEmpty;
  }

  /// verifye si yon pwodui nn panye a deja
  static Future<bool> isProductInCart(Product product) async {
    final cartItems = await getCartItems();
    return cartItems.any((item) => 
      item.type == CartItemType.simpleProduct && 
      item.product?.name == product.name
    );
  }

  /// verifye si yon konpozan nn panye a deja
  static Future<bool> isComponentInCart(Component component) async {
    final cartItems = await getCartItems();
    return cartItems.any((item) => 
      item.type == CartItemType.component && 
      item.component?.id == component.id
    );
  }
}