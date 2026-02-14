import '../models/product.dart';

/// Données locales complètes
class ProductData {
  // Catégories principales de la boutique
  static const List<Map<String, dynamic>> categories = [
    {
      'name': 'PC Gaming',
      'icon': 'computer',
      'description': 'PC configurables haute performance',
      'image': 'https://images.unsplash.com/photo-1587202372634-32705e3bf49c?w=400',
    },
    {
      'name': 'Laptops',
      'icon': 'laptop',
      'description': 'Ordinateurs portables gaming et bureautique',
      'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    },
    {
      'name': 'Composants',
      'icon': 'memory',
      'description': 'CPU, GPU, RAM, SSD et plus',
      'image': 'https://images.unsplash.com/photo-1591488320449-011701bb6704?w=400',
    },
    {
      'name': 'Téléphones',
      'icon': 'smartphone',
      'description': 'Smartphones dernière génération',
      'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    },
    {
      'name': 'Accessoires',
      'icon': 'devices',
      'description': 'Claviers, souris, écrans, casques et plus',
      'image': 'https://images.unsplash.com/photo-1593640495253-23196b27a87f?w=400',
    },
  ];

  // ==================== TÉLÉPHONES ====================
  static List<Product> getPhones() {
    return [
      // Apple iPhones
      Product(name: 'iPhone 15 Pro Max 256GB', image: 'https://m.media-amazon.com/images/I/81SigpJN1KL._AC_SX679_.jpg', price: '\$1199.00', description: 'A17 Pro, Titanium, 48MP', category: 'Téléphones'),
      Product(name: 'iPhone 15 Pro 128GB', image: 'https://m.media-amazon.com/images/I/81SigpJN1KL._AC_SX679_.jpg', price: '\$999.00', description: 'A17 Pro, Action Button', category: 'Téléphones'),
      Product(name: 'iPhone 15 Plus 256GB', image: 'https://m.media-amazon.com/images/I/71xb2xkN5qL._AC_SX679_.jpg', price: '\$899.00', description: '6.7" Super Retina XDR', category: 'Téléphones'),
      Product(name: 'iPhone 15 128GB', image: 'https://m.media-amazon.com/images/I/71xb2xkN5qL._AC_SX679_.jpg', price: '\$799.00', description: 'A16 Bionic, Dynamic Island', category: 'Téléphones'),
      Product(name: 'iPhone 14 Pro 256GB', image: 'https://m.media-amazon.com/images/I/61bK6PMOC3L._AC_SX679_.jpg', price: '\$899.00', description: 'A16 Bionic, 48MP ProRAW', category: 'Téléphones'),
      
      // Samsung Galaxy
      Product(name: 'Samsung Galaxy S24 Ultra 512GB', image: 'https://tse1.mm.bing.net/th/id/OIP.0xYvbthj0kdl2R5inU0tDgHaHa?rs=1&pid=ImgDetMain', price: '\$1399.00', description: 'Snapdragon 8 Gen 3, 200MP', category: 'Téléphones'),
      Product(name: 'Samsung Galaxy S24+ 256GB', image: 'https://tse1.mm.bing.net/th/id/OIP.9kAnD4nY3T0SHRzh9ZCMMAHaJP?w=721&h=900&rs=1&pid=ImgDetMain', price: '\$999.00', description: '6.7" AMOLED 120Hz', category: 'Téléphones'),
      Product(name: 'Samsung Galaxy S24 128GB', image: 'https://tse3.mm.bing.net/th/id/OIP.sXnay7Wcr_RVzCN5yWDdwQHaFj?rs=1&pid=ImgDetMain', price: '\$799.00', description: 'Compact flagship', category: 'Téléphones'),
      Product(name: 'Samsung Galaxy Z Fold5 512GB', image: 'https://tse2.mm.bing.net/th/id/OIP._Haad1v-M9I3CrNErUn7_QHaHa?rs=1&pid=ImgDetMain', price: '\$1799.00', description: 'Foldable 7.6" display', category: 'Téléphones'),
      
      // Google Pixel
      Product(name: 'Google Pixel 8 Pro 256GB', image: 'https://tse1.mm.bing.net/th/id/OIP.5apJ8p7yARb9hICi6vhbXAHaIz?rs=1&pid=ImgDetMain', price: '\$999.00', description: 'Tensor G3, Best Camera AI', category: 'Téléphones'),
      Product(name: 'Google Pixel 8 128GB', image: 'https://tse4.mm.bing.net/th/id/OIP.SFjKVkeGUJoDqV4rMaz4jwHaHa?rs=1&pid=ImgDetMain', price: '\$699.00', description: 'Tensor G3 Compact', category: 'Téléphones'),
    ];
  }

  // ==================== LAPTOPS ====================
  static List<Product> getLaptops() {
    return [
      // Apple MacBook
      Product(name: 'MacBook Pro 16" M3 Max 48GB', image: 'https://tse1.mm.bing.net/th/id/OIP.TO65-OjmC0jZiVjyNRvvlAHaFj?rs=1&pid=ImgDetMain', price: '\$3499.00', description: 'M3 Max 16-core, 40-core GPU', category: 'Laptops'),
      Product(name: 'MacBook Pro 14" M3 Pro 18GB', image: 'https://tse4.mm.bing.net/th/id/OIP.pJBZsLANCtfUmIZrsnSPjgHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5', price: '\$2499.00', description: 'M3 Pro 12-core', category: 'Laptops'),
      Product(name: 'MacBook Air 15" M3 16GB', image: 'https://tse2.mm.bing.net/th/id/OIP.QJYIxFXDqJt-p4tQYsrWfQHaEK?rs=1&pid=ImgDetMain', price: '\$1499.00', description: 'M3, fanless design', category: 'Laptops'),
      
      // Dell XPS
      Product(name: 'Dell XPS 17 9730', image: 'https://tse1.explicit.bing.net/th/id/OIP.FtIaAaICZnDfY9S5hbEz4QHaE8?pid=ImgDet&w=178&h=118&c=7&dpr=1.5', price: '\$2599.00', description: 'i9-13900H, RTX 4070, 32GB', category: 'Laptops'),
      
      // Gaming Laptops
      Product(name: 'Razer Blade 18', image: 'https://tse1.mm.bing.net/th/id/OIP.KFQb40c-A6d3ulEKkKJq8wHaEK?w=1920&h=1080&rs=1&pid=ImgDetMain', price: '\$3999.00', description: 'i9-13950HX, RTX 4090', category: 'Laptops'),
      Product(name: 'Acer Predator Helios 18', image: 'https://tse1.mm.bing.net/th/id/OIP.SAuYDqjsyN84_l0ur0fzzgHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5', price: '\$2899.00', description: 'i9-14900HX, RTX 4080', category: 'Laptops'),
      Product(name: 'Microsoft Surface Laptop Studio 2', image: 'https://tse4.mm.bing.net/th/id/OIP.PKsgyUgHi6nEDAiB-fiw5AHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5', price: '\$2999.00', description: 'i7-13800H, RTX 4060', category: 'Laptops'),
    ];
  }

  // ==================== ACCESSOIRES ====================
  static List<Product> getAccessories() {
    return [
      // CLAVIERS
      Product(name: 'Logitech MX Keys Advanced', image: 'https://tse2.mm.bing.net/th/id/OIP.kFKXAs0WyY9hyt6QZ0xLgQHaFj?rs=1&pid=ImgDetMain', price: '\$129.00', description: 'Clavier sans fil backlit', category: 'Accessoires'),
      Product(name: 'Corsair K100 RGB', image: 'https://tse3.mm.bing.net/th/id/OIP.VkRszy3To67uxJ3794BTqwHaEH?pid=ImgDet&w=181&h=100&c=7&dpr=1.5', price: '\$219.00', description: 'Cherry MX Speed', category: 'Accessoires'),
      
      // SOURIS
      Product(name: 'Logitech MX Master 3S', image: 'https://tse2.mm.bing.net/th/id/OIP.2bocloSu9qdI0y-mEkVNYgHaE0?pid=ImgDet&w=181&h=117&c=7&dpr=1.5', price: '\$99.99', description: 'Ergonomique pro', category: 'Accessoires'),
      Product(name: 'Razer Viper V3 Pro', image: 'https://th.bing.com/th/id/OIP.kvTNYvQ3naJ6JUCXzWWLEQHaHa?w=186&h=186&c=7&r=0', price: '\$159.00', description: 'Gaming 30K DPI', category: 'Accessoires'),
      
      // ÉCRANS
      Product(name: 'Samsung Odyssey G9 49"', image: 'https://tse4.mm.bing.net/th/id/OIP.FOUyTuHnYYj26VpCOP4_zgHaEK?pid=ImgDet&w=178&h=100&c=7&dpr=1.5', price: '\$1299.00', description: '5120x1440 240Hz', category: 'Accessoires'),
      Product(name: 'LG UltraGear 27" 4K', image: 'https://tse1.mm.bing.net/th/id/OIP.YWP3jw0J1e4TUzBOBsh85gHaJd?pid=ImgDet&w=178&h=227&c=7&dpr=1.5', price: '\$699.00', description: 'IPS Nano HDR600', category: 'Accessoires'),
      
      // CASQUES
      Product(name: 'Sony WH-1000XM5', image: 'https://tse2.mm.bing.net/th/id/OIP.1LQQiZablPAG-CAO_7AaqwAAAA?pid=ImgDet&w=181&h=181&c=7&dpr=1.5', price: '\$399.00', description: 'ANC premium', category: 'Accessoires'),
      Product(name: 'Bose QuietComfort Ultra', image: 'https://tse4.mm.bing.net/th/id/OIP.TkhaKhV8MrmB9Sk9ozg_owHaJ4?pid=ImgDet&w=181&h=241&c=7&dpr=1.5', price: '\$429.00', description: 'Spatial audio', category: 'Accessoires'),
    ];
  }

  // ==================== COMPOSANTS PC ====================
  static List<Product> getComponents() {
    return [
      // CPU AMD
      Product(name: 'AMD Ryzen 9 9800X3D', image: 'https://th.bing.com/th/id/OIP.wxbA6AZG9uOualTOgmHODgHaE8?w=252&h=180&c=7&r=0', price: '\$499.00', description: '8-Core, 16-Thread, 5.2GHz, 96MB Cache, 3D V-Cache', category: 'Composants'),
      Product(name: 'AMD Ryzen 7 7800X3D', image: 'https://th.bing.com/th/id/OIP.DLSgoZRTAyP4Ah3m3n-s0QHaFj?w=222&h=180&c=7&r=0', price: '\$399.00', description: '8-Core, 16-Thread, 5.0GHz, Best gaming CPU', category: 'Composants'),
      Product(name: 'AMD Ryzen 5 7600X', image: 'https://tse4.mm.bing.net/th/id/OIP.iFUlBNWLi50ybhydYf4j4gHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5', price: '\$249.00', description: '6-Core, 12-Thread, 5.3GHz, Zen 4', category: 'Composants'),
      
      // GPU NVIDIA
      Product(name: 'NVIDIA RTX 5090', image: 'https://tse3.mm.bing.net/th/id/OIP.HLNNjZZ5XJpE6kxy2bvxZAHaEU?pid=ImgDet&w=181&h=105&c=7&dpr=1.5', price: '\$1999.00', description: '32GB GDDR7, 21,760 CUDA cores, Blackwell', category: 'Composants'),
      Product(name: 'NVIDIA RTX 4090', image: 'https://th.bing.com/th/id/OIP.apCfB8iG2oZ5MEQoFlwLgQHaEK?w=304&h=180&c=7&r=0', price: '\$1599.00', description: '24GB GDDR6X, 16,384 CUDA, Ray Tracing beast', category: 'Composants'),
      Product(name: 'NVIDIA RTX 4080', image: 'https://tse1.mm.bing.net/th/id/OIP.JgWp6kkxjoDrq65OhcxICwHaF1?rs=1&pid=ImgDetMain', price: '\$1199.00', description: '16GB GDDR6X, 9,728 CUDA, High-end', category: 'Composants'),
      Product(name: 'NVIDIA RTX 5070 Ti', image: 'https://tse2.mm.bing.net/th/id/OIP.esAjwkapx7PdnmyVtaO7dQHaHa?rs=1&pid=ImgDetMain', price: '\$749.00', description: '12GB GDDR7, Upper mid-range, Blackwell', category: 'Composants'),
      
      // GPU AMD
      Product(name: 'AMD Radeon RX 7900 XTX', image: 'https://th.bing.com/th/id/OIP.Co-TXNpLD23gtiIpSufSAgHaHa?w=158&h=180&c=7&r=0', price: '\$999.00', description: '24GB GDDR6, 96 Compute Units, RDNA 3 flagship', category: 'Composants'),
      Product(name: 'AMD Radeon RX 9070 XT', image: 'https://tse1.mm.bing.net/th/id/OIP.-hv6uOt4fmHfvzPvtAbXLgHaHa?rs=1&pid=ImgDetMain', price: '\$649.00', description: '16GB GDDR6, RDNA 4, FSR 4', category: 'Composants'),
      Product(name: 'AMD Radeon RX 7900 XT', image: 'https://tse1.mm.bing.net/th/id/OIP.Fkk5_tTWAHeG5wXAahqqIwHaHa?rs=1&pid=ImgDetMain', price: '\$849.00', description: '20GB GDDR6, 84 CU, Great for 4K', category: 'Composants'),
      
      // ALIMENTATIONS (PSU)
      Product(name: 'Corsair WS3000 3000W', image: 'https://th.bing.com/th/id/OIP.GevWFv_38FtXm0vG4EqUVAHaEK?w=319&h=180&c=7&r=0', price: '\$799.00', description: '3000W, 80+ Titanium, Modular, Extreme workstation', category: 'Composants'),
      Product(name: 'ASUS Pro WS Platinum 3000W', image: 'https://tse1.mm.bing.net/th/id/OIP.bJK9Z2XDn5B9VXehoBjMjgHaHa?rs=1&pid=ImgDetMain', price: '\$849.00', description: '3000W, 80+ Platinum, Professional grade', category: 'Composants'),
      Product(name: 'Seasonic Prime TX-1600', image: 'https://tse2.mm.bing.net/th/id/OIP.6qpjC6W0-93waQeUidKaBwHaEV?rs=1&pid=ImgDetMain', price: '\$599.00', description: '1600W, 80+ Titanium, Noctua Edition, Silent', category: 'Composants'),
      
      // CARTES MÈRES Intel
      Product(name: 'ASUS ROG Maximus Z790 Extreme', image: 'https://tse3.mm.bing.net/th/id/OIP.32Fi_eoE3wqWkMTWYeGHIQHaGF?rs=1&pid=ImgDetMain', price: '\$799.00', description: 'Z790, LGA1700, DDR5, PCIe 5.0, WiFi 7, Flagship', category: 'Composants'),
      Product(name: 'MSI MEG Z790 Godlike', image: 'https://tse3.mm.bing.net/th/id/OIP.EX7iLJ2cbqKUIauo3K9KYQHaFp?rs=1&pid=ImgDetMain', price: '\$899.00', description: 'Z790, Premium EATX, 10GbE LAN, Extreme OC', category: 'Composants'),
      
      // CARTES MÈRES AMD
      Product(name: 'ASUS ROG Crosshair X670E Extreme', image: 'https://tse3.mm.bing.net/th/id/OIP.rMP6hT8c5uBvZg_uaEG6sQHaGF?w=1048&h=862&rs=1&pid=ImgDetMain', price: '\$699.00', description: 'X670E, AM5, DDR5, PCIe 5.0, Premium', category: 'Composants'),
      Product(name: 'MSI MEG X670E Godlike', image: 'https://tse2.mm.bing.net/th/id/OIP.MEx4pD_A_JxLYr3ZE43WJwHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5', price: '\$799.00', description: 'X670E, Extreme EATX, 10GbE, OC champion', category: 'Composants'),
      
      // BOÎTIERS PC
      Product(name: 'Lian Li A4-H2O', image: 'https://tse4.mm.bing.net/th/id/OIP.45cx5ZvPnGaDVSEWzycMdAHaEK?rs=1&pid=ImgDetMain', price: '\$149.00', description: 'Mini-ITX, 11L, AIO support, Compact gaming', category: 'Composants'),
      Product(name: 'Cooler Master NR200P', image: 'https://tse1.mm.bing.net/th/id/OIP.qHVBrKw738IwlPkAf1qoUAHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5', price: '\$99.00', description: 'Mini-ITX, 18L, Tempered glass, Best ITX', category: 'Composants'),
      Product(name: 'Lian Li O11 Dynamic EVO', image: 'https://tse4.mm.bing.net/th/id/OIP.6E5bdPj7EczFhc7KF5EvugHaK9?rs=1&pid=ImgDetMain', price: '\$179.00', description: 'Mid-Tower, Dual chamber, Showcase design', category: 'Composants'),
      
      // REFROIDISSEURS CPU
      Product(name: 'Noctua NH-D15', image: 'https://tse1.mm.bing.net/th/id/OIP.Oz72oIVS4ksLKObTsm02QgHaEK?rs=1&pid=ImgDetMain', price: '\$109.00', description: 'Dual tower, 140mm fans, Best air cooler', category: 'Composants'),
      Product(name: 'DeepCool Assassin IV', image: 'https://th.bing.com/th/id/OIP.tb5FCTUWuaHYGSDIKJkL_AHaHa?w=228&h=180&c=7&r=0', price: '\$89.00', description: 'Dual tower, 140mm fans, High performance', category: 'Composants'),
    ];
  }

  // Obtenir tous les produits locaux
  static List<Product> getLocalProducts() {
    return [
      ...getPhones(),
      ...getLaptops(),
      ...getAccessories(),
      ...getComponents(), // ← IMPORTANT: Inclure les composants!
    ];
  }

  // Types de composants disponibles
  static const List<Map<String, String>> componentTypes = [
    {'name': 'CPU', 'type': 'cpu', 'icon': 'memory'},
    {'name': 'GPU', 'type': 'gpu', 'icon': 'videogame_asset'},
    {'name': 'RAM', 'type': 'ram', 'icon': 'storage'},
    {'name': 'Stockage', 'type': 'storage', 'icon': 'save'},
    {'name': 'Carte Mère', 'type': 'motherboard', 'icon': 'developer_board'},
    {'name': 'Alimentation', 'type': 'psu', 'icon': 'power'},
    {'name': 'Boîtier', 'type': 'case', 'icon': 'inventory_2'},
    {'name': 'Refroidissement', 'type': 'cooling', 'icon': 'ac_unit'},
  ];

  // Obtenir les icônes Material pour les catégories
  static String getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'pc gaming':
        return 'computer';
      case 'laptops':
        return 'laptop';
      case 'composants':
        return 'memory';
      case 'téléphones':
        return 'smartphone';
      case 'accessoires':
        return 'devices';
      default:
        return 'shopping_bag';
    }
  }
}