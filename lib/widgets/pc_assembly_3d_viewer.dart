import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../models/component.dart';

/// VERSION FINALE OPTIMISÉE - Modèles légers + Timeout long + Mode Image
class PCAssembly3DViewer extends StatefulWidget {
  final List<Component> components;

  PCAssembly3DViewer({required this.components});

  @override
  _PCAssembly3DViewerState createState() => _PCAssembly3DViewerState();
}

class _PCAssembly3DViewerState extends State<PCAssembly3DViewer>
    with SingleTickerProviderStateMixin {
  
  bool _autoRotate = true;
  bool _use3D = true;
  int _currentModelIndex = 0;
  bool _isLoading = true;
  
  late AnimationController _rotationController;
  
  // Modèles 3D LÉGERS qui chargent rapidement
  final List<Map<String, String>> _models = [
    {
      'url': 'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Box/glTF/Box.gltf',
      'name': 'Boîtier PC',
    },
    {
      'url': 'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Duck/glTF/Duck.gltf',
      'name': 'Modèle Test',
    },
    {
      'url': 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
      'name': 'Astronaute',
    },
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat();
    
    // Timeout LONG pour donner le temps de charger
    Future.delayed(Duration(seconds: 15), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  String get _currentModelUrl => _models[_currentModelIndex]['url']!;
  String get _currentModelName => _models[_currentModelIndex]['name']!;

  void _nextModel() {
    setState(() {
      _currentModelIndex = (_currentModelIndex + 1) % _models.length;
      _isLoading = true;
    });
    
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _toggle3DMode() {
    setState(() {
      _use3D = !_use3D;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_use3D ? '📦 Mode 3D activé' : '🖼️ Mode Image activé'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  double _getTotalPrice() {
    return widget.components.fold(0.0, (sum, c) => sum + c.price);
  }

  Map<String, List<Component>> _groupComponents() {
    Map<String, List<Component>> grouped = {};
    for (var c in widget.components) {
      final type = c.type.toLowerCase();
      grouped.putIfAbsent(type, () => []).add(c);
    }
    return grouped;
  }

  bool _isComplete() {
    final types = widget.components.map((c) => c.type.toLowerCase()).toSet();
    return types.contains('cpu') && types.contains('ram');
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupComponents();
    final isComplete = _isComplete();
    
    return Scaffold(
      backgroundColor: Color(0xFF0a0e27),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Zone principale
          _use3D ? _build3DView() : _buildImageView(),
          
          // Overlay de chargement (seulement en mode 3D)
          if (_isLoading && _use3D) _buildLoadingOverlay(),
          
          // Badge statut
          if (!_isLoading) _buildStatusBadge(isComplete),
          
          // Info modèle actuel
          if (!_isLoading && _use3D) _buildModelInfo(),
          
          // Panneau composants
          _buildPanel(grouped),
        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF1a1f3a),
      elevation: 0,
      title: Text(
        'Assemblage PC 3D',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        // Toggle 3D/Image
        IconButton(
          icon: Icon(
            _use3D ? Icons.image : Icons.view_in_ar,
            color: Colors.white,
          ),
          onPressed: _toggle3DMode,
          tooltip: _use3D ? 'Mode Image' : 'Mode 3D',
        ),
        // Changer modèle
        if (_use3D)
          IconButton(
            icon: Icon(Icons.swap_horiz, color: Colors.white),
            onPressed: _nextModel,
            tooltip: 'Changer modèle',
          ),
        // Rotation
        if (_use3D)
          IconButton(
            icon: Icon(
              _autoRotate ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _autoRotate = !_autoRotate;
              });
            },
            tooltip: _autoRotate ? 'Pause' : 'Lecture',
          ),
      ],
    );
  }

  Widget _build3DView() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF1a1f3a), Color(0xFF0a0e27)],
        ),
      ),
      child: ModelViewer(
        src: _currentModelUrl,
        alt: 'PC 3D Model',
        ar: false,
        autoRotate: _autoRotate,
        cameraControls: true,
        backgroundColor: Color(0xFF0a0e27),
        loading: Loading.eager,
        reveal: Reveal.auto,
        shadowIntensity: 1.0,
        exposure: 1.2,
        autoRotateDelay: 0,
        rotationPerSecond: '30deg',
        interactionPrompt: InteractionPrompt.none,
        cameraOrbit: '0deg 75deg 105%',
      ),
    );
  }

  Widget _buildImageView() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF1a1f3a), Color(0xFF0a0e27)],
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_rotationController.value * 6.28),
              child: Container(
                width: 280,
                height: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF00d4ff), Color(0xFF0066ff)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00d4ff).withOpacity(0.5),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.computer, size: 120, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'PC GAMING',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${widget.components.length} composants',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '\$${_getTotalPrice().toStringAsFixed(2)}',
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Color(0xFF0a0e27).withOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(0xFF00d4ff)),
              strokeWidth: 3,
            ),
            SizedBox(height: 20),
            Text(
              'Chargement du modèle 3D...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              _currentModelName,
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'Peut prendre 5-15 secondes',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
            SizedBox(height: 8),
            Text(
              'Si rien ne se passe, cliquez sur 📷',
              style: TextStyle(color: Colors.white38, fontSize: 11, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isComplete) {
    return Positioned(
      top: 20,
      left: 20,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isComplete
                ? [Color(0xFF4CAF50), Color(0xFF45a049)]
                : [Color(0xFF00d4ff), Color(0xFF0066ff)],
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: (isComplete ? Color(0xFF4CAF50) : Color(0xFF00d4ff))
                  .withOpacity(0.5),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isComplete ? Icons.check_circle : Icons.build,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              isComplete ? 'PC Complet' : 'En Construction',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModelInfo() {
    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.view_in_ar, color: Colors.white, size: 16),
            SizedBox(width: 6),
            Text(
              _currentModelName,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel(Map<String, List<Component>> grouped) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.15,
      maxChildSize: 0.8,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF1a1f3a),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vos Composants',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.components.length} composant(s)',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF45a049)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '\$${_getTotalPrice().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white10, height: 1),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: EdgeInsets.all(20),
                  children: grouped.entries.map((e) {
                    return _buildSection(e.key, e.value);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(String type, List<Component> comps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            type.toUpperCase(),
            style: TextStyle(
              color: Color(0xFF00d4ff),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        ...comps.map((c) => _buildCard(c)),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCard(Component c) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF252b4a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              c.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 50,
                height: 50,
                color: Color(0xFF1a1f3a),
                child: Icon(Icons.memory, color: Colors.white30, size: 24),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  c.description,
                  style: TextStyle(color: Colors.white60, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            '\$${c.price.toStringAsFixed(0)}',
            style: TextStyle(
              color: Color(0xFF4CAF50),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: _toggle3DMode,
      backgroundColor: Color(0xFFFF6B6B),
      icon: Icon(_use3D ? Icons.image : Icons.view_in_ar),
      label: Text(_use3D ? 'Mode Image' : 'Mode 3D'),
    );
  }
}