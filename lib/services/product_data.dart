import '../models/product.dart';

class ProductData {
  // LAPTOPS (40 laptops)
  static final List<Product> laptops = [
    // MacBook
    Product(name: 'MacBook Pro M3 Max 16"', image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', price: '\$3,499', description: 'M3 Max, 48GB RAM, 1TB SSD, 16" Liquid Retina XDR', category: 'Laptops'),
    Product(name: 'MacBook Pro M3 Pro 14"', image: 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=400', price: '\$2,499', description: 'M3 Pro, 18GB RAM, 512GB SSD, 14" Retina', category: 'Laptops'),
    Product(name: 'MacBook Air M3 15"', image: 'https://images.unsplash.com/photo-1606229365485-93a3b8ee0385?w=400', price: '\$1,499', description: 'M3, 16GB RAM, 512GB SSD, 15.3" display', category: 'Laptops'),
    Product(name: 'MacBook Air M2 13"', image: 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', price: '\$1,199', description: 'M2, 8GB RAM, 256GB SSD, 13.6" Retina', category: 'Laptops'),
    Product(name: 'MacBook Pro M1 13"', image: 'https://images.unsplash.com/photo-1629131726692-1accd0c53ce0?w=400', price: '\$999', description: 'M1, 8GB RAM, 256GB SSD, Touch Bar', category: 'Laptops'),
    
    // Dell
    Product(name: 'Dell XPS 17 9730', image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', price: '\$2,899', description: 'Intel i9-13900H, RTX 4070, 32GB RAM, 1TB SSD, 17"', category: 'Laptops'),
    Product(name: 'Dell XPS 15 9530', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$2,199', description: 'Intel i7-13700H, RTX 4050, 16GB RAM, 512GB SSD', category: 'Laptops'),
    Product(name: 'Dell XPS 13 Plus', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$1,499', description: 'Intel i7-1360P, 16GB RAM, 512GB SSD, 13.4"', category: 'Laptops'),
    Product(name: 'Dell Inspiron 16 Plus', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$1,299', description: 'Intel i7-13700H, RTX 3050, 16GB RAM, 512GB', category: 'Laptops'),
    Product(name: 'Dell Precision 5680', image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', price: '\$2,599', description: 'Intel i9-13950HX, RTX 3000 Ada, 32GB RAM', category: 'Laptops'),
    
    // HP
    Product(name: 'HP Spectre x360 16"', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$2,099', description: 'Intel i7-13700H, Arc A370M, 32GB RAM, 2-in-1', category: 'Laptops'),
    Product(name: 'HP Envy 17', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$1,599', description: 'Intel i7-1355U, 16GB RAM, 1TB SSD, 17.3"', category: 'Laptops'),
    Product(name: 'HP Pavilion Plus 14', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$999', description: 'Intel i7-13700H, 16GB RAM, 512GB SSD, OLED', category: 'Laptops'),
    Product(name: 'HP Omen 17', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$1,899', description: 'Intel i9-13900HX, RTX 4070, 32GB RAM, Gaming', category: 'Laptops'),
    Product(name: 'HP Victus 15', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$899', description: 'AMD Ryzen 5 7535HS, RTX 3050, 16GB RAM', category: 'Laptops'),
    
    // Alienware
    Product(name: 'Alienware M18 R2', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$3,999', description: 'Intel i9-14900HX, RTX 4090, 64GB RAM, 18"', category: 'Laptops'),
    Product(name: 'Alienware X16 R2', image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', price: '\$3,299', description: 'Intel i9-13900HK, RTX 4080, 32GB RAM, 16"', category: 'Laptops'),
    Product(name: 'Alienware M16 R2', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$2,499', description: 'Intel i7-13700HX, RTX 4060, 16GB RAM', category: 'Laptops'),
    Product(name: 'Alienware X14 R2', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$1,999', description: 'Intel i7-13620H, RTX 4050, 16GB RAM, Thin', category: 'Laptops'),
    
    // ASUS
    Product(name: 'ASUS ROG Zephyrus G16', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$2,899', description: 'Intel i9-13900H, RTX 4090, 32GB RAM, OLED', category: 'Laptops'),
    Product(name: 'ASUS ROG Strix G18', image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', price: '\$2,499', description: 'Intel i9-13980HX, RTX 4080, 32GB RAM, 18"', category: 'Laptops'),
    Product(name: 'ASUS TUF Gaming A15', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$1,399', description: 'AMD Ryzen 9 7940HS, RTX 4060, 16GB RAM', category: 'Laptops'),
    Product(name: 'ASUS Zenbook Pro 14', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$1,799', description: 'Intel i9-13900H, RTX 4060, 32GB RAM, OLED', category: 'Laptops'),
    Product(name: 'ASUS VivoBook S15', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$899', description: 'Intel i7-1355U, 16GB RAM, 512GB SSD', category: 'Laptops'),
    
    // MSI
    Product(name: 'MSI Titan 18 HX', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$4,999', description: 'Intel i9-14900HX, RTX 4090, 128GB RAM, 18"', category: 'Laptops'),
    Product(name: 'MSI Raider GE78 HX', image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', price: '\$3,499', description: 'Intel i9-13980HX, RTX 4080, 64GB RAM, RGB', category: 'Laptops'),
    Product(name: 'MSI Stealth 17 Studio', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$2,899', description: 'Intel i9-13900H, RTX 4070, 32GB RAM', category: 'Laptops'),
    Product(name: 'MSI Katana 15', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$1,299', description: 'Intel i7-13620H, RTX 4060, 16GB RAM', category: 'Laptops'),
    Product(name: 'MSI Prestige 16', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$1,899', description: 'Intel i7-13700H, RTX 4050, 32GB RAM, Creator', category: 'Laptops'),
    
    // Acer
    Product(name: 'Acer Predator Helios 18', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$2,999', description: 'Intel i9-13900HX, RTX 4080, 32GB RAM, 18"', category: 'Laptops'),
    Product(name: 'Acer Nitro 17', image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', price: '\$1,499', description: 'AMD Ryzen 7 7840HS, RTX 4060, 16GB RAM', category: 'Laptops'),
    Product(name: 'Acer Swift X 14', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$1,199', description: 'Intel i7-1360P, RTX 4050, 16GB RAM, Thin', category: 'Laptops'),
    Product(name: 'Acer Aspire 5', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$699', description: 'AMD Ryzen 5 7520U, 8GB RAM, 512GB SSD', category: 'Laptops'),
    
    // Gigabyte
    Product(name: 'Gigabyte AORUS 17X', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$3,299', description: 'Intel i9-13900HX, RTX 4090, 32GB RAM, 17.3"', category: 'Laptops'),
    Product(name: 'Gigabyte G5 KF', image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', price: '\$1,099', description: 'Intel i5-12500H, RTX 4060, 16GB RAM', category: 'Laptops'),
    
    // Samsung
    Product(name: 'Samsung Galaxy Book4 Ultra', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$2,399', description: 'Intel i9-13900H, RTX 4070, 32GB RAM, AMOLED', category: 'Laptops'),
    Product(name: 'Samsung Galaxy Book3 Pro', image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', price: '\$1,599', description: 'Intel i7-1360P, 16GB RAM, 512GB SSD, OLED', category: 'Laptops'),
    
    // Lenovo (bonus)
    Product(name: 'Lenovo Legion Pro 7i', image: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', price: '\$2,799', description: 'Intel i9-13900HX, RTX 4080, 32GB RAM', category: 'Laptops'),
    Product(name: 'Lenovo ThinkPad X1 Carbon', image: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', price: '\$1,899', description: 'Intel i7-1365U, 32GB RAM, 1TB SSD, Business', category: 'Laptops'),
  ];

  // SMARTPHONES (40 téléphones)
  static final List<Product> smartphones = [
    // iPhone
    Product(name: 'iPhone 15 Pro Max', image: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400', price: '\$1,199', description: '256GB, Titanium Blue, A17 Pro chip, USB-C', category: 'Smartphones'),
    Product(name: 'iPhone 15 Pro', image: 'https://tse1.mm.bing.net/th/id/OIP.fd06aKpmfDXtrVOsMTeTgAHaEK?cb=defcache2&defcache=1&rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$999', description: '128GB, Natural Titanium, A17 Pro', category: 'Smartphones'),
    Product(name: 'iPhone 15', image: 'https://tse1.mm.bing.net/th/id/OIP.IzmiqpMjQZluu3HpDJ9SeAHaEK?cb=defcache2&defcache=1&rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$799', description: '128GB, Pink, A16 Bionic', category: 'Smartphones'),
    Product(name: 'iPhone 14 Pro', image: 'https://cdn.shopify.com/s/files/1/0824/3121/t/204/assets/categories-banners01-1682510945446.png?v=1682511029', price: '\$899', description: '256GB, Deep Purple, A16 Bionic', category: 'Smartphones'),
    Product(name: 'iPhone 13', image: 'https://images.unsplash.com/photo-1632661674596-df8be070a5c5?w=400', price: '\$599', description: '128GB, Midnight, A15 Bionic', category: 'Smartphones'),
    
    // Samsung
    Product(name: 'Samsung Galaxy S24 Ultra', image: 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400', price: '\$1,299', description: '512GB, Titanium Gray, Snapdragon 8 Gen 3, S Pen', category: 'Smartphones'),
    Product(name: 'Samsung Galaxy S24+', image: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400', price: '\$999', description: '256GB, Onyx Black, 6.7" display', category: 'Smartphones'),
    Product(name: 'Samsung Galaxy S23 FE', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$599', description: '128GB, Graphite, Exynos 2200', category: 'Smartphones'),
    Product(name: 'Samsung Galaxy Z Fold 5', image: 'https://www.androidauthority.com/wp-content/uploads/2023/04/Samsung-Galaxy-Z-Fold-5-Render-2.jpeg', price: '\$1,799', description: '512GB, Phantom Black, Foldable', category: 'Smartphones'),
    Product(name: 'Samsung Galaxy Z Flip 5', image: 'https://static1.anpoimages.com/wordpress/wp-content/uploads/2023/07/supcase-ub-pro-galaxy-z-flip-5-case.jpg', price: '\$999', description: '256GB, Mint, Compact foldable', category: 'Smartphones'),
    Product(name: 'Samsung Galaxy A54', image: 'https://tse4.mm.bing.net/th/id/OIP.rhAlWgL6c-9rOWxRVbX79QHaE8?cb=defcache2&defcache=1&rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$449', description: '128GB, Awesome Violet, 5G', category: 'Smartphones'),
    
    // Google Pixel
    Product(name: 'Google Pixel 8 Pro', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$999', description: '256GB, Obsidian, Tensor G3, Best camera', category: 'Smartphones'),
    Product(name: 'Google Pixel 8', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$699', description: '128GB, Hazel, Tensor G3', category: 'Smartphones'),
    Product(name: 'Google Pixel 7a', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$499', description: '128GB, Sea, Tensor G2', category: 'Smartphones'),
    Product(name: 'Google Pixel Fold', image: 'https://www.androidauthority.com/wp-content/uploads/2022/12/Google-Pixel-Fold-How-to-I-Solve-3.jpg', price: '\$1,799', description: '256GB, Porcelain, Foldable', category: 'Smartphones'),
    
    // OnePlus
    Product(name: 'OnePlus 12', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$799', description: '256GB, Flowy Emerald, Snapdragon 8 Gen 3', category: 'Smartphones'),
    Product(name: 'OnePlus 11', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$699', description: '128GB, Titan Black, Snapdragon 8 Gen 2', category: 'Smartphones'),
    Product(name: 'OnePlus Nord 3', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$449', description: '128GB, Misty Green, Dimensity 9000', category: 'Smartphones'),
    Product(name: 'OnePlus Open', image: 'https://images.news9live.com/wp-content/uploads/2023/10/OnePlus-Open-2.jpg?w=1200&enlarge=true', price: '\$1,699', description: '512GB, Voyager Black, Foldable', category: 'Smartphones'),
    
    // Xiaomi
    Product(name: 'Xiaomi 14 Ultra', image: 'https://static1.anpoimages.com/wordpress/wp-content/uploads/2024/02/xiaomi-14-ultra-render-left-back-black.jpeg', price: '\$999', description: '512GB, Black, Snapdragon 8 Gen 3, Leica', category: 'Smartphones'),
    Product(name: 'Xiaomi 13 Pro', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$899', description: '256GB, Ceramic White, Leica camera', category: 'Smartphones'),
    Product(name: 'Xiaomi Redmi Note 13 Pro', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$349', description: '256GB, Midnight Black, 200MP camera', category: 'Smartphones'),
    Product(name: 'Xiaomi Poco X6 Pro', image: 'https://www.mobiledokan.com/media/xiaomi-poco-x6-pro-poco-yellow-official-image.webp', price: '\$399', description: '256GB, Yellow, Dimensity 8300 Ultra', category: 'Smartphones'),
    
    // Huawei
    Product(name: 'Huawei P60 Pro', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$899', description: '256GB, Rococo Pearl, Snapdragon 8+ Gen 1', category: 'Smartphones'),
    Product(name: 'Huawei Mate 60 Pro', image: 'https://tse2.mm.bing.net/th/id/OIP.M6n0hAxTlOGPpBRSEI9n4QHaE4?cb=defcache2&defcache=1&rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$999', description: '512GB, Black, Kirin 9000s, Satellite', category: 'Smartphones'),
    Product(name: 'Huawei Nova 12 Pro', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$549', description: '256GB, Green, Kirin 9000SL', category: 'Smartphones'),
    
    // Honor
    Product(name: 'Honor Magic 6 Pro', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$849', description: '512GB, Epi Green, Snapdragon 8 Gen 3', category: 'Smartphones'),
    Product(name: 'Honor 90 Pro', image: 'https://tse2.mm.bing.net/th/id/OIP.nawq4ZCiYqG-dxyRCGbC0gHaFj?cb=defcache2&defcache=1&rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$599', description: '256GB, Diamond Silver, Snapdragon 8+ Gen 1', category: 'Smartphones'),
    Product(name: 'Honor X9b', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$349', description: '256GB, Midnight Black, Snapdragon 6 Gen 1', category: 'Smartphones'),
    
    // Sony
    Product(name: 'Sony Xperia 1 V', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$1,399', description: '256GB, Black, Snapdragon 8 Gen 2, 4K display', category: 'Smartphones'),
    Product(name: 'Sony Xperia 5 V', image: 'https://m.media-amazon.com/images/I/41mwushixWL._AC_.jpg', price: '\$999', description: '128GB, Blue, Compact flagship', category: 'Smartphones'),
    
    // RedMagic
    Product(name: 'RedMagic 9 Pro', image: 'https://static1.pocketlintimages.com/wordpress/wp-content/uploads/2023/12/redmagic-9-pro-tag.jpg', price: '\$649', description: '256GB, Snowfall, Snapdragon 8 Gen 3, Gaming', category: 'Smartphones'),
    Product(name: 'RedMagic 8S Pro', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$579', description: '256GB, Midnight, 165Hz display, Cooling fan', category: 'Smartphones'),
    
    // Tecno
    Product(name: 'Tecno Phantom X2 Pro', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$699', description: '256GB, Mars Orange, Dimensity 9000', category: 'Smartphones'),
    
    // ZTE
    Product(name: 'ZTE Axon 50 Ultra', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$599', description: '256GB, Black, Snapdragon 8+ Gen 1', category: 'Smartphones'),
    
    // BLU
    Product(name: 'BLU G91 Max', image: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', price: '\$199', description: '128GB, Blue, Helio G95, Budget flagship', category: 'Smartphones'),
    Product(name: 'BLU F91 5G', image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400', price: '\$249', description: '128GB, Black, Dimensity 810, 5G', category: 'Smartphones'),
    
  
  ];

  // COMPOSANTS PC (40 composants)
  static final List<Product> components = [
    // CPU AMD
    Product(name: 'AMD Ryzen 9 9800X3D', image: 'https://th.bing.com/th/id/OIP.wxbA6AZG9uOualTOgmHODgHaE8?w=252&h=180&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', price: '\$499', description: '8-Core, 16-Thread, 5.2GHz, 96MB Cache, 3D V-Cache', category: 'Components'),
    Product(name: 'AMD Ryzen 7 7800X3D', image: 'https://th.bing.com/th/id/OIP.DLSgoZRTAyP4Ah3m3n-s0QHaFj?w=222&h=180&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', price: '\$399', description: '8-Core, 16-Thread, 5.0GHz, Best gaming CPU', category: 'Components'),
    Product(name: 'AMD Ryzen 5 7600X', image: 'https://tse4.mm.bing.net/th/id/OIP.iFUlBNWLi50ybhydYf4j4gHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5&o=7&rm=3', price: '\$249', description: '6-Core, 12-Thread, 5.3GHz, Zen 4', category: 'Components'),
    
    
    // GPU NVIDIA
    Product(name: 'NVIDIA RTX 5090', image: 'https://tse3.mm.bing.net/th/id/OIP.HLNNjZZ5XJpE6kxy2bvxZAHaEU?pid=ImgDet&w=181&h=105&c=7&dpr=1.5&o=7&rm=3', price: '\$1,999', description: '32GB GDDR7, 21,760 CUDA cores, Blackwell', category: 'Components'),
    Product(name: 'NVIDIA RTX 4090', image: 'https://th.bing.com/th/id/OIP.apCfB8iG2oZ5MEQoFlwLgQHaEK?w=304&h=180&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', price: '\$1,599', description: '24GB GDDR6X, 16,384 CUDA, Ray Tracing beast', category: 'Components'),
    Product(name: 'NVIDIA RTX 4080', image: 'https://tse1.mm.bing.net/th/id/OIP.JgWp6kkxjoDrq65OhcxICwHaF1?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$1,199', description: '16GB GDDR6X, 9,728 CUDA, High-end', category: 'Components'),
    Product(name: 'NVIDIA RTX 5070 Ti', image: 'https://tse2.mm.bing.net/th/id/OIP.esAjwkapx7PdnmyVtaO7dQHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$749', description: '12GB GDDR7, Upper mid-range, Blackwell', category: 'Components'),
    
    // GPU AMD
    Product(name: 'AMD Radeon RX 7900 XTX', image: 'https://th.bing.com/th/id/OIP.Co-TXNpLD23gtiIpSufSAgHaHa?w=158&h=180&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', price: '\$999', description: '24GB GDDR6, 96 Compute Units, RDNA 3 flagship', category: 'Components'),
    Product(name: 'AMD Radeon RX 9070 XT', image: 'https://tse1.mm.bing.net/th/id/OIP.-hv6uOt4fmHfvzPvtAbXLgHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$649', description: '16GB GDDR6, RDNA 4, FSR 4', category: 'Components'),
    Product(name: 'AMD Radeon RX 7900 XT', image: 'https://tse1.mm.bing.net/th/id/OIP.Fkk5_tTWAHeG5wXAahqqIwHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$849', description: '20GB GDDR6, 84 CU, Great for 4K', category: 'Components'),
    
    // Power Supply
    Product(name: 'Corsair WS3000 3000W', image: 'https://th.bing.com/th/id/OIP.GevWFv_38FtXm0vG4EqUVAHaEK?w=319&h=180&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', price: '\$799', description: '3000W, 80+ Titanium, Modular, Extreme workstation', category: 'Components'),
    Product(name: 'ASUS Pro WS Platinum 3000W', image: 'https://tse1.mm.bing.net/th/id/OIP.bJK9Z2XDn5B9VXehoBjMjgHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$849', description: '3000W, 80+ Platinum, Professional grade', category: 'Components'),
    Product(name: 'Seasonic Prime TX-1600', image: 'https://tse2.mm.bing.net/th/id/OIP.6qpjC6W0-93waQeUidKaBwHaEV?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$599', description: '1600W, 80+ Titanium, Noctua Edition, Silent', category: 'Components'),
    
    
    // Motherboard Intel
    Product(name: 'ASUS ROG Maximus Z790 Extreme', image: 'https://tse3.mm.bing.net/th/id/OIP.32Fi_eoE3wqWkMTWYeGHIQHaGF?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$799', description: 'Z790, LGA1700, DDR5, PCIe 5.0, WiFi 7, Flagship', category: 'Components'),
    Product(name: 'MSI MEG Z790 Godlike', image: 'https://tse3.mm.bing.net/th/id/OIP.EX7iLJ2cbqKUIauo3K9KYQHaFp?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$899', description: 'Z790, Premium EATX, 10GbE LAN, Extreme OC', category: 'Components'),
    
    
    // Motherboard AMD
    Product(name: 'ASUS ROG Crosshair X670E Extreme', image: 'https://tse3.mm.bing.net/th/id/OIP.rMP6hT8c5uBvZg_uaEG6sQHaGF?w=1048&h=862&rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$699', description: 'X670E, AM5, DDR5, PCIe 5.0, Premium', category: 'Components'),
    Product(name: 'MSI MEG X670E Godlike', image: 'https://tse2.mm.bing.net/th/id/OIP.MEx4pD_A_JxLYr3ZE43WJwHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5&o=7&rm=3', price: '\$799', description: 'X670E, Extreme EATX, 10GbE, OC champion', category: 'Components'),
    
    
    // PC Cases (Mini-ITX, Mid-Tower, Full-Tower)
    Product(name: 'Lian Li A4-H2O', image: 'https://tse4.mm.bing.net/th/id/OIP.45cx5ZvPnGaDVSEWzycMdAHaEK?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$149', description: 'Mini-ITX, 11L, AIO support, Compact gaming', category: 'Components'),
    Product(name: 'Cooler Master NR200P', image: 'https://tse1.mm.bing.net/th/id/OIP.qHVBrKw738IwlPkAf1qoUAHaHa?pid=ImgDet&w=181&h=181&c=7&dpr=1.5&o=7&rm=3', price: '\$99', description: 'Mini-ITX, 18L, Tempered glass, Best ITX', category: 'Components'),
    Product(name: 'Lian Li O11 Dynamic EVO', image: 'https://tse4.mm.bing.net/th/id/OIP.6E5bdPj7EczFhc7KF5EvugHaK9?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$179', description: 'Mid-Tower, Dual chamber, Showcase design', category: 'Components'),
    
    
    // CPU Coolers (Air)
    Product(name: 'Noctua NH-D15', image: 'https://tse1.mm.bing.net/th/id/OIP.Oz72oIVS4ksLKObTsm02QgHaEK?rs=1&pid=ImgDetMain&o=7&rm=3', price: '\$109', description: 'Dual tower, 140mm fans, Best air cooler', category: 'Components'),
    Product(name: 'DeepCool Assassin IV', image: 'https://th.bing.com/th/id/OIP.tb5FCTUWuaHYGSDIKJkL_AHaHa?w=228&h=180&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', price: '\$89', description: 'Dual tower, 140mm fans, High performance', category: 'Components'),
    
  ];

  // ACCESSOIRES
  static final List<Product> accessories = [
    Product(
      name: 'Logitech MX Master 3S',
      image: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400',
      price: '\$99',
      description: 'Wireless, 8K DPI, USB-C',
      category: 'Accessories',
    ),
    Product(
      name: 'HyperX Cloud III',
      image: 'https://images.unsplash.com/photo-1599669454699-248893623440?w=400',
      price: '\$129',
      description: 'Gaming headset, 7.1 surround',
      category: 'Accessories',
    ),
  ];

  // PC COMPLETS (15 PC Gaming et Bureau)
  static final List<Product> pcComplets = [
    Product(
      name: 'Corsair Vengeance i7600',
      image: 'https://images.unsplash.com/photo-1587202372634-32a178d1f648?w=400',
      price: '\$2,999',
      description: 'i7-14700KF, RTX 4070 Ti, 32GB DDR5, 1TB NVMe, RGB',
      category: 'PC Complets',
    ),
    Product(
      name: 'ASUS ROG G700',
      image: 'https://images.unsplash.com/photo-1587202372583-49330a15584d?w=400',
      price: '\$3,499',
      description: 'i9-14900K, RTX 4080, 64GB DDR5, 2TB SSD, Premium case',
      category: 'PC Complets',
    ),
    Product(
      name: 'Skytech Rampage Gaming PC',
      image: 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400',
      price: '\$2,499',
      description: 'Ryzen 9 7900X, RTX 4070, 32GB DDR5, 1TB SSD, RGB',
      category: 'PC Complets',
    ),
    Product(
      name: 'Gaming Desktop i7-14700KF RTX 4070',
      image: 'https://images.unsplash.com/photo-1587202372634-32a178d1f648?w=400',
      price: '\$2,299',
      description: 'Intel i7-14700KF, RTX 4070, 32GB RAM, 1TB + 2TB HDD',
      category: 'PC Complets',
    ),
    Product(
      name: 'CyberPowerPC Gamer Xtreme VR',
      image: 'https://images.unsplash.com/photo-1587202372583-49330a15584d?w=400',
      price: '\$1,999',
      description: 'i7-13700F, RTX 4060 Ti, 16GB DDR5, 1TB NVMe, VR Ready',
      category: 'PC Complets',
    ),
    Product(
      name: 'Lenovo Legion Tower 5i',
      image: 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400',
      price: '\$1,799',
      description: 'i7-13700F, RTX 4060, 16GB DDR5, 512GB SSD, Clean design',
      category: 'PC Complets',
    ),
    Product(
      name: 'MSI Codex Z2 Gaming PC',
      image: 'https://images.unsplash.com/photo-1587202372634-32a178d1f648?w=400',
      price: '\$2,799',
      description: 'i9-14900KF, RTX 4070 Ti, 32GB DDR5, 2TB SSD, Compact',
      category: 'PC Complets',
    ),
    Product(
      name: 'Skytech Gaming Azure 3',
      image: 'https://images.unsplash.com/photo-1587202372583-49330a15584d?w=400',
      price: '\$1,599',
      description: 'Ryzen 7 7700X, RX 7700 XT, 16GB DDR5, 1TB NVMe, Blue LED',
      category: 'PC Complets',
    ),
    Product(
      name: 'Thermaltake LCGS View i560T-170',
      image: 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400',
      price: '\$1,899',
      description: 'i5-14600KF, RTX 4060 Ti, 16GB DDR5, 1TB, Tempered glass',
      category: 'PC Complets',
    ),
    Product(
      name: 'AOACE Gaming PC Desktop',
      image: 'https://images.unsplash.com/photo-1587202372634-32a178d1f648?w=400',
      price: '\$1,499',
      description: 'Ryzen 5 7600X, RTX 4060, 16GB DDR5, 512GB SSD, Entry gaming',
      category: 'PC Complets',
    ),
    Product(
      name: 'HP OMEN 45L Gaming Desktop',
      image: 'https://images.unsplash.com/photo-1587202372583-49330a15584d?w=400',
      price: '\$3,299',
      description: 'i9-14900K, RTX 4080, 64GB DDR5, 2TB + 2TB, Premium RGB',
      category: 'PC Complets',
    ),
    Product(
      name: 'Dell XPS Desktop 8960',
      image: 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400',
      price: '\$1,799',
      description: 'i7-14700, RTX 4060, 32GB DDR5, 1TB SSD, Productivity + Gaming',
      category: 'PC Complets',
    ),
    Product(name: 'Alienware Aurora R16', image: 'https://images.unsplash.com/photo-1587202372634-32a178d1f648?w=400', price: '\$4,199', description: 'i9-14900KF, RTX 4090, 64GB DDR5, 4TB SSD, Legend 3.0 Design', category: 'PC Complets'),
    Product(
      name: 'NZXT Player Three Prime',
      image: 'https://images.unsplash.com/photo-1587202372583-49330a15584d?w=400',
      price: '\$2,199',
      description: 'i5-14600KF, RTX 4070, 16GB DDR5, 1TB, H7 Flow case',
      category: 'PC Complets',
    ),
    Product(
      name: 'iBUYPOWER Trace 7 MR',
      image: 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400',
      price: '\$1,999',
      description: 'Ryzen 7 7700, RTX 4060 Ti, 16GB DDR5, 1TB, RGB fans',
      category: 'PC Complets',
    ),
  ];

  // Tous les produits
  static List<Product> get allProducts => [
        ...laptops,
        ...smartphones,
        ...components,
        ...accessories,
        ...pcComplets,
      ];

  // Produits par catégorie
  static List<Product> getByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'laptops':
        return laptops;
      case 'smartphones':
        return smartphones;
      case 'components':
        return components;
      case 'accessories':
        return accessories;
      case 'pc complets':
      case 'pc gaming':
      case 'pc bureau':
        return pcComplets;
      default:
        return [];
    }
  }
}
