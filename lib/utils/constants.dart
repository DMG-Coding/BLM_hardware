import 'package:flutter/material.dart';

class AppColors {
  // pou koule nwa
  static const darkBg = Color(0xFF1a1a2e);
  static const darkCard = Color(0xFF16213e);
  static const darkAccent = Color(0xFF0f3460);
  
  // kole aksan
  static const cyan = Color(0xFF00d4ff);
  static const blue = Color(0xFF0066ff);
  static const purple = Color(0xFF7f00ff);
  
  // koule Gradients
  static const bgGradient = [darkBg, darkCard, darkAccent];
  static const accentGradient = [cyan, blue, purple];
}

class AppStyles {
  static final cardRadius = BorderRadius.circular(16);
  static final buttonRadius = BorderRadius.circular(12);
  
  static final cardShape = RoundedRectangleBorder(
    borderRadius: cardRadius,
  );
}
