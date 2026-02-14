import 'package:flutter/material.dart';
import '../models/pc_config.dart';
import '../models/component.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

class PCConfigScreen extends StatefulWidget {
  final PCConfig pcConfig;

  PCConfigScreen({required this.pcConfig});

  @override
  _PCConfigScreenState createState() => _PCConfigScreenState();
}

class _PCConfigScreenState extends State<PCConfigScreen> {
  late PCConfig _currentConfig;

  @override
  void initState() {
    super.initState();
    // Initialiser avec les composants par défaut
    _currentConfig = widget.pcConfig.withDefaults();
  }

  void _selectComponent(String type, Component component) {
    setState(() {
      switch (type.toLowerCase()) {
        case 'cpu':
          _currentConfig = _currentConfig.copyWith(selectedCpu: component);
          break;
        case 'gpu':
          _currentConfig = _currentConfig.copyWith(selectedGpu: component);
          break;
        case 'ram':
          _currentConfig = _currentConfig.copyWith(selectedRam: component);
          break;
        case 'storage':
          _currentConfig = _currentConfig.copyWith(selectedStorage: component);
          break;
        case 'motherboard':
          _currentConfig = _currentConfig.copyWith(selectedMotherboard: component);
          break;
        case 'psu':
          _currentConfig = _currentConfig.copyWith(selectedPsu: component);
          break;
        case 'case':
          _currentConfig = _currentConfig.copyWith(selectedCase: component);
          break;
        case 'cooling':
          _currentConfig = _currentConfig.copyWith(selectedCooling: component);
          break;
      }
    });
  }

  void _showComponentSelector(String type, List<Component> options, Component? current) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.tune, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Choisir ${_getTypeName(type)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final component = options[index];
                    final isSelected = current?.id == component.id;
                    final priceDiff = component.price - _getDefaultPrice(type);

                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      elevation: isSelected ? 8 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected ? AppColors.cyan : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            component.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[300],
                                child: Icon(Icons.memory),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          component.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppColors.cyan : Colors.black87,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              component.description,
                              style: TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (priceDiff != 0) ...[
                              SizedBox(height: 4),
                              Text(
                                priceDiff > 0 
                                    ? '+\$${priceDiff.toStringAsFixed(2)}'
                                    : '\$${priceDiff.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: priceDiff > 0 ? Colors.orange : Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ],
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: AppColors.cyan, size: 32)
                            : Icon(Icons.circle_outlined, color: Colors.grey, size: 32),
                        onTap: () {
                          _selectComponent(type, component);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTypeName(String type) {
    switch (type.toLowerCase()) {
      case 'cpu': return 'Processeur';
      case 'gpu': return 'Carte Graphique';
      case 'ram': return 'Mémoire RAM';
      case 'storage': return 'Stockage';
      case 'motherboard': return 'Carte Mère';
      case 'psu': return 'Alimentation';
      case 'case': return 'Boîtier';
      case 'cooling': return 'Refroidissement';
      default: return type;
    }
  }

  double _getDefaultPrice(String type) {
    switch (type.toLowerCase()) {
      case 'cpu': return widget.pcConfig.defaultCpu.price;
      case 'gpu': return widget.pcConfig.defaultGpu.price;
      case 'ram': return widget.pcConfig.defaultRam.price;
      case 'storage': return widget.pcConfig.defaultStorage.price;
      case 'motherboard': return widget.pcConfig.defaultMotherboard?.price ?? 0;
      case 'psu': return widget.pcConfig.defaultPsu?.price ?? 0;
      case 'case': return widget.pcConfig.defaultCase?.price ?? 0;
      case 'cooling': return widget.pcConfig.defaultCooling?.price ?? 0;
      default: return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _currentConfig.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurer votre PC'),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[50]!, Colors.white],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: Column(
          children: [
            // En-tête avec image et prix
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      _currentConfig.image,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.grey[300],
                          child: Icon(Icons.computer, size: 80),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _currentConfig.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.cyan,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Prix total: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Liste des composants configurables
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildComponentTile(
                    'CPU',
                    _currentConfig.selectedCpu ?? _currentConfig.defaultCpu,
                    widget.pcConfig.cpuOptions,
                  ),
                  _buildComponentTile(
                    'GPU',
                    _currentConfig.selectedGpu ?? _currentConfig.defaultGpu,
                    widget.pcConfig.gpuOptions,
                  ),
                  _buildComponentTile(
                    'RAM',
                    _currentConfig.selectedRam ?? _currentConfig.defaultRam,
                    widget.pcConfig.ramOptions,
                  ),
                  _buildComponentTile(
                    'Storage',
                    _currentConfig.selectedStorage ?? _currentConfig.defaultStorage,
                    widget.pcConfig.storageOptions,
                  ),
                  if (widget.pcConfig.motherboardOptions.isNotEmpty)
                    _buildComponentTile(
                      'Motherboard',
                      _currentConfig.selectedMotherboard ?? _currentConfig.defaultMotherboard,
                      widget.pcConfig.motherboardOptions,
                    ),
                  if (widget.pcConfig.psuOptions.isNotEmpty)
                    _buildComponentTile(
                      'PSU',
                      _currentConfig.selectedPsu ?? _currentConfig.defaultPsu,
                      widget.pcConfig.psuOptions,
                    ),
                  if (widget.pcConfig.caseOptions.isNotEmpty)
                    _buildComponentTile(
                      'Case',
                      _currentConfig.selectedCase ?? _currentConfig.defaultCase,
                      widget.pcConfig.caseOptions,
                    ),
                  if (widget.pcConfig.coolingOptions.isNotEmpty)
                    _buildComponentTile(
                      'Cooling',
                      _currentConfig.selectedCooling ?? _currentConfig.defaultCooling,
                      widget.pcConfig.coolingOptions,
                    ),
                  SizedBox(height: 100), // Espace pour le bouton flottant
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
            ),
            icon: Icon(Icons.shopping_cart, size: 24),
            label: Text(
              'AJOUTER AU PANIER - \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              await CartService.addPCConfig(_currentConfig);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${_currentConfig.name} ajouté au panier!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildComponentTile(String type, Component? component, List<Component> options) {
    if (component == null || options.isEmpty) return SizedBox.shrink();

    final priceDiff = component.price - _getDefaultPrice(type);

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showComponentSelector(type, options, component),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  component.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[300],
                      child: Icon(Icons.memory),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTypeName(type),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      component.name,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (priceDiff != 0) ...[
                      SizedBox(height: 4),
                      Text(
                        priceDiff > 0 
                            ? '+\$${priceDiff.toStringAsFixed(2)}'
                            : '\$${priceDiff.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: priceDiff > 0 ? Colors.orange : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.edit, color: AppColors.cyan),
            ],
          ),
        ),
      ),
    );
  }
}