import 'component.dart';

// configuration PC complète
class PCConfig {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category; 
  final double basePrice;
  
  // konfigirasyon bazik yo le pral achte an
  final Component defaultCpu;
  final Component defaultGpu;
  final Component defaultRam;
  final Component defaultStorage;
  final Component? defaultMotherboard; 
  final Component? defaultPsu; 
  final Component? defaultCase; 
  final Component? defaultCooling; 
  
  //  personnalisation
  final List<Component> cpuOptions;
  final List<Component> gpuOptions;
  final List<Component> ramOptions;
  final List<Component> storageOptions;
  final List<Component> motherboardOptions;
  final List<Component> psuOptions;
  final List<Component> caseOptions;
  final List<Component> coolingOptions;
  
  
  Component? selectedCpu;
  Component? selectedGpu;
  Component? selectedRam;
  Component? selectedStorage;
  Component? selectedMotherboard;
  Component? selectedPsu;
  Component? selectedCase;
  Component? selectedCooling;

  PCConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.basePrice,
    required this.defaultCpu,
    required this.defaultGpu,
    required this.defaultRam,
    required this.defaultStorage,
    this.defaultMotherboard,
    this.defaultPsu,
    this.defaultCase,
    this.defaultCooling,
    this.cpuOptions = const [],
    this.gpuOptions = const [],
    this.ramOptions = const [],
    this.storageOptions = const [],
    this.motherboardOptions = const [],
    this.psuOptions = const [],
    this.caseOptions = const [],
    this.coolingOptions = const [],
    this.selectedCpu,
    this.selectedGpu,
    this.selectedRam,
    this.selectedStorage,
    this.selectedMotherboard,
    this.selectedPsu,
    this.selectedCase,
    this.selectedCooling,
  });

  // Initialiser avec les composants par défaut
  PCConfig withDefaults() {
    return copyWith(
      selectedCpu: defaultCpu,
      selectedGpu: defaultGpu,
      selectedRam: defaultRam,
      selectedStorage: defaultStorage,
      selectedMotherboard: defaultMotherboard,
      selectedPsu: defaultPsu,
      selectedCase: defaultCase,
      selectedCooling: defaultCooling,
    );
  }

  
  double getTotalPrice() {
    double total = basePrice;
    
    // Ajouter la différence de prix par rapport aux composants par défaut
    if (selectedCpu != null) {
      total += (selectedCpu!.price - defaultCpu.price);
    }
    if (selectedGpu != null) {
      total += (selectedGpu!.price - defaultGpu.price);
    }
    if (selectedRam != null) {
      total += (selectedRam!.price - defaultRam.price);
    }
    if (selectedStorage != null) {
      total += (selectedStorage!.price - defaultStorage.price);
    }
    if (selectedMotherboard != null && defaultMotherboard != null) {
      total += (selectedMotherboard!.price - defaultMotherboard!.price);
    }
    if (selectedPsu != null && defaultPsu != null) {
      total += (selectedPsu!.price - defaultPsu!.price);
    }
    if (selectedCase != null && defaultCase != null) {
      total += (selectedCase!.price - defaultCase!.price);
    }
    if (selectedCooling != null && defaultCooling != null) {
      total += (selectedCooling!.price - defaultCooling!.price);
    }
    
    return total;
  }

  // fh an sot jwenn konfigirasyon an sou fom de teks
  String getConfigSummary() {
    final buffer = StringBuffer();
    
    if (selectedCpu != null) {
      buffer.writeln('CPU: ${selectedCpu!.name}');
    }
    if (selectedGpu != null) {
      buffer.writeln('GPU: ${selectedGpu!.name}');
    }
    if (selectedRam != null) {
      buffer.writeln('RAM: ${selectedRam!.name}');
    }
    if (selectedStorage != null) {
      buffer.writeln('Stockage: ${selectedStorage!.name}');
    }
    if (selectedMotherboard != null) {
      buffer.writeln('Carte Mère: ${selectedMotherboard!.name}');
    }
    if (selectedPsu != null) {
      buffer.writeln('Alimentation: ${selectedPsu!.name}');
    }
    if (selectedCase != null) {
      buffer.writeln('Boîtier: ${selectedCase!.name}');
    }
    if (selectedCooling != null) {
      buffer.writeln('Refroidissement: ${selectedCooling!.name}');
    }
    
    return buffer.toString();
  }

  // ki fh kopi a depi fichye JSON nn
  factory PCConfig.fromJson(Map<String, dynamic> json) {
    return PCConfig(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      basePrice: (json['basePrice'] is num) 
          ? (json['basePrice'] as num).toDouble() 
          : 0.0,
      defaultCpu: Component.fromJson(json['defaultCpu'] ?? {}),
      defaultGpu: Component.fromJson(json['defaultGpu'] ?? {}),
      defaultRam: Component.fromJson(json['defaultRam'] ?? {}),
      defaultStorage: Component.fromJson(json['defaultStorage'] ?? {}),
      defaultMotherboard: json['defaultMotherboard'] != null
          ? Component.fromJson(json['defaultMotherboard'])
          : null,
      defaultPsu: json['defaultPsu'] != null
          ? Component.fromJson(json['defaultPsu'])
          : null,
      defaultCase: json['defaultCase'] != null
          ? Component.fromJson(json['defaultCase'])
          : null,
      defaultCooling: json['defaultCooling'] != null
          ? Component.fromJson(json['defaultCooling'])
          : null,
      cpuOptions: (json['cpuOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
      gpuOptions: (json['gpuOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
      ramOptions: (json['ramOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
      storageOptions: (json['storageOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
      motherboardOptions: (json['motherboardOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
      psuOptions: (json['psuOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
      caseOptions: (json['caseOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
      coolingOptions: (json['coolingOptions'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e))
              .toList() ??
          [],
    );
  }

  // ki fh kopi a bay JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'category': category,
        'basePrice': basePrice,
        'defaultCpu': defaultCpu.toJson(),
        'defaultGpu': defaultGpu.toJson(),
        'defaultRam': defaultRam.toJson(),
        'defaultStorage': defaultStorage.toJson(),
        'defaultMotherboard': defaultMotherboard?.toJson(),
        'defaultPsu': defaultPsu?.toJson(),
        'defaultCase': defaultCase?.toJson(),
        'defaultCooling': defaultCooling?.toJson(),
        'cpuOptions': cpuOptions.map((e) => e.toJson()).toList(),
        'gpuOptions': gpuOptions.map((e) => e.toJson()).toList(),
        'ramOptions': ramOptions.map((e) => e.toJson()).toList(),
        'storageOptions': storageOptions.map((e) => e.toJson()).toList(),
        'motherboardOptions': motherboardOptions.map((e) => e.toJson()).toList(),
        'psuOptions': psuOptions.map((e) => e.toJson()).toList(),
        'caseOptions': caseOptions.map((e) => e.toJson()).toList(),
        'coolingOptions': coolingOptions.map((e) => e.toJson()).toList(),
        'selectedCpu': selectedCpu?.toJson(),
        'selectedGpu': selectedGpu?.toJson(),
        'selectedRam': selectedRam?.toJson(),
        'selectedStorage': selectedStorage?.toJson(),
        'selectedMotherboard': selectedMotherboard?.toJson(),
        'selectedPsu': selectedPsu?.toJson(),
        'selectedCase': selectedCase?.toJson(),
        'selectedCooling': selectedCooling?.toJson(),
      };

  // kopyel ak modifikasyon yo
  PCConfig copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? category,
    double? basePrice,
    Component? defaultCpu,
    Component? defaultGpu,
    Component? defaultRam,
    Component? defaultStorage,
    Component? defaultMotherboard,
    Component? defaultPsu,
    Component? defaultCase,
    Component? defaultCooling,
    List<Component>? cpuOptions,
    List<Component>? gpuOptions,
    List<Component>? ramOptions,
    List<Component>? storageOptions,
    List<Component>? motherboardOptions,
    List<Component>? psuOptions,
    List<Component>? caseOptions,
    List<Component>? coolingOptions,
    Component? selectedCpu,
    Component? selectedGpu,
    Component? selectedRam,
    Component? selectedStorage,
    Component? selectedMotherboard,
    Component? selectedPsu,
    Component? selectedCase,
    Component? selectedCooling,
  }) {
    return PCConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      category: category ?? this.category,
      basePrice: basePrice ?? this.basePrice,
      defaultCpu: defaultCpu ?? this.defaultCpu,
      defaultGpu: defaultGpu ?? this.defaultGpu,
      defaultRam: defaultRam ?? this.defaultRam,
      defaultStorage: defaultStorage ?? this.defaultStorage,
      defaultMotherboard: defaultMotherboard ?? this.defaultMotherboard,
      defaultPsu: defaultPsu ?? this.defaultPsu,
      defaultCase: defaultCase ?? this.defaultCase,
      defaultCooling: defaultCooling ?? this.defaultCooling,
      cpuOptions: cpuOptions ?? this.cpuOptions,
      gpuOptions: gpuOptions ?? this.gpuOptions,
      ramOptions: ramOptions ?? this.ramOptions,
      storageOptions: storageOptions ?? this.storageOptions,
      motherboardOptions: motherboardOptions ?? this.motherboardOptions,
      psuOptions: psuOptions ?? this.psuOptions,
      caseOptions: caseOptions ?? this.caseOptions,
      coolingOptions: coolingOptions ?? this.coolingOptions,
      selectedCpu: selectedCpu ?? this.selectedCpu,
      selectedGpu: selectedGpu ?? this.selectedGpu,
      selectedRam: selectedRam ?? this.selectedRam,
      selectedStorage: selectedStorage ?? this.selectedStorage,
      selectedMotherboard: selectedMotherboard ?? this.selectedMotherboard,
      selectedPsu: selectedPsu ?? this.selectedPsu,
      selectedCase: selectedCase ?? this.selectedCase,
      selectedCooling: selectedCooling ?? this.selectedCooling,
    );
  }
}