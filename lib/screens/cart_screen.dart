import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

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

  @override
  Widget build(BuildContext context) {
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
                      Expanded(child: _buildCartList()),
                      _buildCheckoutSection(),
                    ],
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
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
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
                
                // Infos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type badge
                      Row(
                        children: [
                          _buildTypeBadge(item.type),
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
                      
                      // Nom
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
                      
                      // Catégorie
                      Text(
                        item.getCategory(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      
                      // Prix
                      Row(
                        children: [
                          Text(
                            '\$${item.getUnitPrice().toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (item.quantity > 1) ...[
                            Text(
                              ' × ${item.quantity}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Configuration pour PC configurés
            if (item.type == CartItemType.configurablePC && item.pcConfig != null) ...[
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings, size: 16, color: AppColors.cyan),
                        SizedBox(width: 6),
                        Text(
                          'Configuration personnalisée',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    _buildConfigLine('CPU', item.pcConfig!.selectedCpu?.name),
                    _buildConfigLine('GPU', item.pcConfig!.selectedGpu?.name),
                    _buildConfigLine('RAM', item.pcConfig!.selectedRam?.name),
                    _buildConfigLine('Stockage', item.pcConfig!.selectedStorage?.name),
                  ],
                ),
              ),
            ],
            
            // Contrôles de quantité
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${item.getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      color: Colors.blue[700],
                      onPressed: item.quantity > 1
                          ? () => _updateQuantity(index, item.quantity - 1)
                          : null,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      color: Colors.blue[700],
                      onPressed: () => _updateQuantity(index, item.quantity + 1),
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
      case CartItemType.configurablePC:
        label = 'PC Config';
        color = AppColors.cyan;
        break;
      case CartItemType.component:
        label = 'Composant';
        color = Colors.orange;
        break;
      case CartItemType.simpleProduct:
        label = 'Produit';
        color = Colors.green;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
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

  Widget _buildConfigLine(String label, String? value) {
    if (value == null) return SizedBox.shrink();
    
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Résumé
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sous-total (${_cartItems.length} articles)',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${_total.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.cyan,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Bouton de paiement
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (c) => AlertDialog(
                      title: Text('Confirmer l\'achat'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Articles: ${_cartItems.length}'),
                          SizedBox(height: 8),
                          Text(
                            'Total: \$${_total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Annuler'),
                          onPressed: () => Navigator.pop(c),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text('Confirmer'),
                          onPressed: () {
                            Navigator.pop(c);
                            _clearCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Commande confirmée! Merci!'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'ACHETER MAINTENANT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}