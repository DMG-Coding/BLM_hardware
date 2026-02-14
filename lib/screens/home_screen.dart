import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../data/product_data.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import '../models/pc_config.dart';
import 'product_list_screen.dart';
import 'cart_screen.dart';
import 'login_screen.dart';
import 'pc_config_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _featuredProducts = [];
  List<PCConfig> _configurablePCs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    try {
      // Charger les produits depuis les données locales (pas DummyJSON!)
      final products = await ApiService.fetchProducts();
      final pcs = await ApiService.fetchConfigurablePCs();
      
      setState(() {
        // Prendre 6 produits variés de différentes catégories
        _featuredProducts = _getFeaturedProductsMix(products);
        _configurablePCs = pcs;
        _isLoading = false;
      });
    } catch (e) {
      print('Erreur chargement: $e');
      setState(() {
        _featuredProducts = ProductData.getLocalProducts().take(6).toList();
        _isLoading = false;
      });
    }
  }

  /// Obtenir un mix de produits de différentes catégories
  List<Product> _getFeaturedProductsMix(List<Product> allProducts) {
    final featured = <Product>[];
    
    // 2 téléphones
    final phones = allProducts.where((p) => p.category == 'Téléphones').take(2);
    featured.addAll(phones);
    
    // 2 laptops
    final laptops = allProducts.where((p) => p.category == 'Laptops').take(2);
    featured.addAll(laptops);
    
    // 2 accessoires
    final accessories = allProducts.where((p) => p.category == 'Accessoires').take(2);
    featured.addAll(accessories);
    
    return featured;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.computer, size: 28),
            SizedBox(width: 10),
            Text('BLM Hardware', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[50]!, Colors.white],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadData,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroBanner(context),
                      SizedBox(height: 20),
                      _buildCategoriesSection(context),
                      SizedBox(height: 20),
                      if (_configurablePCs.isNotEmpty) ...[
                        _buildConfigurablePCsSection(context),
                        SizedBox(height: 20),
                      ],
                      _buildFeaturedProducts(context),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(24),
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bienvenue chez',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'BLM HARDWARE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Votre boutique #1 pour matériel informatique',
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final categories = ProductData.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Catégories',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryCard(
                context,
                name: category['name'] as String,
                image: category['image'] as String,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, {required String name, required String image}) {
    final colors = [
      AppColors.cyan,
      Color(0xFFff6b6b),
      Color(0xFF4ecdc4),
      Color(0xFFffe66d),
      Color(0xFF9b59b6),
      Color(0xFF1abc9c),
    ];
    final color = colors[name.hashCode % colors.length];

    return GestureDetector(
      onTap: () async {
        // Navigation vers la liste de produits selon la catégorie
        if (name == 'PC Gaming' || name == 'Laptops') {
          // Afficher les PC configurables
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(
                category: name,
                products: [],
                configurablePCs: _configurablePCs.where((pc) => 
                  (name == 'PC Gaming' && pc.category == 'gaming') ||
                  (name == 'Laptops' && pc.category == 'laptop')
                ).toList(),
              ),
            ),
          );
        } else if (name == 'Composants') {
          // Afficher les composants individuels
          final components = await ApiService.fetchComponents();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(
                category: name,
                products: [],
                components: components,
              ),
            ),
          );
        } else {
          // Afficher les produits de la catégorie
          final products = await ApiService.fetchProductsByCategory(name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(
                category: name,
                products: products,
              ),
            ),
          );
        }
      },
      child: Container(
        width: 110,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                width: 110,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110,
                    height: 130,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 40),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 8,
              right: 8,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigurablePCsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PC Configurables',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(
                        category: 'PC Gaming',
                        products: [],
                        configurablePCs: _configurablePCs,
                      ),
                    ),
                  );
                },
                child: Text('Voir tout'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: _configurablePCs.take(5).length,
            itemBuilder: (context, index) {
              final pc = _configurablePCs[index].withDefaults();
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PCConfigScreen(pcConfig: pc),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          pc.image,
                          width: 200,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 200,
                              height: 150,
                              color: Colors.grey[800],
                              child: Icon(Icons.computer, color: Colors.white, size: 50),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pc.name,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text(
                              '\$${pc.getTotalPrice().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Configurable',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produits Populaires',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () async {
                  final products = await ApiService.fetchProducts();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(
                        category: 'Tous les produits',
                        products: products,
                      ),
                    ),
                  );
                },
                child: Text('Voir tout'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: _featuredProducts.length,
            itemBuilder: (context, index) {
              final product = _featuredProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Container(
                  width: 180,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          product.image,
                          width: 180,
                          height: 130,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 180,
                              height: 130,
                              color: Colors.grey[300],
                              child: Icon(Icons.image, size: 50),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Text(
                              product.price,
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[900]!],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.computer, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'BLM Hardware',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tech Store',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.home,
              title: 'Accueil',
              onTap: () => Navigator.pop(context),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'CATÉGORIES',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            ...ProductData.categories.map((cat) {
              return _buildDrawerItem(
                context,
                icon: Icons.category,
                title: cat['name'] as String,
                onTap: () async {
                  Navigator.pop(context);
                  final name = cat['name'] as String;
                  
                  if (name == 'PC Gaming' || name == 'Laptops') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          category: name,
                          products: [],
                          configurablePCs: _configurablePCs.where((pc) => 
                            (name == 'PC Gaming' && pc.category == 'gaming') ||
                            (name == 'Laptops' && pc.category == 'laptop')
                          ).toList(),
                        ),
                      ),
                    );
                  } else if (name == 'Composants') {
                    final components = await ApiService.fetchComponents();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          category: name,
                          products: [],
                          components: components,
                        ),
                      ),
                    );
                  } else {
                    final products = await ApiService.fetchProductsByCategory(name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          category: name,
                          products: products,
                        ),
                      ),
                    );
                  }
                },
              );
            }).toList(),
            Divider(),
            _buildDrawerItem(
              context,
              icon: Icons.shopping_cart,
              title: 'Panier',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
            ),
            Divider(),
            _buildDrawerItem(
              context,
              icon: Icons.logout,
              title: 'Déconnexion',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.blue[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      hoverColor: isLogout ? Colors.red[50] : Colors.blue[50],
    );
  }
}