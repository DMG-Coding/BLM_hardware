import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/component.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';
import '../widgets/pc_assembly_3d_viewer.dart';
import '../services/pc_assembly_service.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];
  bool _isLoading = true;
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final items = await CartService.getCartItems();
    final total = await CartService.calculateCartTotal();
    
    setState(() {
      _cartItems = items;
      _total = total;
      _isLoading = false;
    });
  }

  Future<void> _removeItem(int index) async {
    await CartService.removeItem(index);
    _loadCart();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Article retiré'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _updateQuantity(int index, int newQuantity) async {
    await CartService.updateQuantity(index, newQuantity);
    _loadCart();
  }

  Future<void> _clearCart() async {
    await CartService.clearCart();
    _loadCart();
  }

  /// Ouvrir la vue du PC assemblé
  void _openPCAssembly3D() {
    final components = PCAssemblyService.getPCComponents(_cartItems);
    
    if (components.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Aucun composant PC dans le panier'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PCAssembly3DViewer(components: components),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canShow3D = PCAssemblyService.canShowPC3D(_cartItems);
    final assemblyMessage = PCAssemblyService.getAssemblyMessage(_cartItems);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier (${_cartItems.length})'),
        backgroundColor: Colors.blue[700],
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (c) => AlertDialog(
                    title: Text('Vider le panier?'),
                    content: Text('Supprimer tous les articles?'),
                    actions: [
                      TextButton(
                        child: Text('Non'),
                        onPressed: () => Navigator.pop(c),
                      ),
                      TextButton(
                        child: Text('Oui', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          _clearCart();
                          Navigator.pop(c);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[50]!, Colors.white],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _cartItems.isEmpty
                ? _buildEmptyCart()
                : Column(
                    children: [
                      if (canShow3D) _buildPC3DButton(assemblyMessage),
                      Expanded(child: _buildCartList()),
                      _buildCheckoutSection(),
                    ],
                  ),
      ),
    );
  }

  Widget _buildPC3DButton(String message) {
    final hasCompletePC = PCAssemblyService.hasCompletePC(_cartItems);
    final componentCount = PCAssemblyService.getPCComponents(_cartItems).length;
    
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasCompletePC
              ? [Color(0xFF4CAF50), Color(0xFF45a049)]
              : [Color(0xFF2196F3), Color(0xFF1976D2)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (hasCompletePC ? Colors.green : Colors.blue).withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _openPCAssembly3D,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.visibility,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasCompletePC ? 'PC Complet !' : 'Prévisualisation PC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '$componentCount composant(s) • $message',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Colors.grey[600],
          ),
          SizedBox(height: 20),
          Text(
            'Votre panier est vide',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Ajoutez des composants PC\npour voir la prévisualisation',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _cartItems.length,
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return _buildCartItemCard(item, index);
      },
    );
  }

  Widget _buildCartItemCard(CartItem item, int index) {
    final isComponent = item.type == CartItemType.component;
    
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isComponent 
            ? BorderSide(color: Colors.blue[300]!, width: 2)
            : BorderSide.none,
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.getImage(),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[800],
                        child: Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildTypeBadge(item.type),
                          if (isComponent) ...[
                            SizedBox(width: 8),
                            Icon(Icons.visibility, color: Colors.blue[700], size: 16),
                          ],
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () => _removeItem(index),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.getName(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.getCategory(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '\$${item.getUnitPrice().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${item.getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        if (item.quantity > 1) {
                          _updateQuantity(index, item.quantity - 1);
                        }
                      },
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        _updateQuantity(index, item.quantity + 1);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(CartItemType type) {
    String label;
    Color color;
    
    switch (type) {
      case CartItemType.simpleProduct:
        label = 'Produit';
        color = Colors.blue;
        break;
      case CartItemType.configurablePC:
        label = 'PC Config';
        color = Colors.purple;
        break;
      case CartItemType.component:
        label = 'Composant PC';
        color = Colors.orange;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '\$${_total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                icon: Icon(Icons.shopping_bag, size: 24),
                label: Text(
                  'COMMANDER',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 32),
                          SizedBox(width: 12),
                          Text('Commande confirmée!'),
                        ],
                      ),
                      content: Text(
                        'Merci pour votre commande de \$${_total.toStringAsFixed(2)}',
                      ),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            _clearCart();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}