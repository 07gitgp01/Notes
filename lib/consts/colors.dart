import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Brand Identity)
  static const Color primary = Color(0xFF4361EE); // Vibrant blue
  static const Color primaryDark = Color(0xFF3A56D4); // Darker blue for pressed states
  static const Color primaryLight = Color(0xFF4895EF); // Lighter blue for highlights

  // Secondary Colors (Accents & Actions)
  static const Color secondary = Color(0xFF7209B7); // Purple for secondary buttons
  static const Color accent = Color(0xFFF72585); // Pink for important actions

  // Background & Surface Colors
  static const Color background = Color(0xFFF8F9FA); // Light gray background
  static const Color surface = Color(0xFFFFFFFF); // White for cards, forms
  static const Color card = Color(0xFFFFFFFF); // Card background

  // Text Colors
  static const Color textPrimary = Color(0xFF212529); // Dark gray for main text
  static const Color textSecondary = Color(0xFF6C757D); // Medium gray for secondary text
  static const Color textHint = Color(0xFFADB5BD); // Light gray for hints
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White text on colored backgrounds
  static const Color textOnSecondary = Color(0xFFFFFFFF); // White text on colored backgrounds

  // UI State Colors
  static const Color success = Color(0xFF4CC9F0); // Cyan for success messages
  static const Color warning = Color(0xFFF8961E); // Orange for warnings
  static const Color error = Color(0xFFE63946); // Red for errors
  static const Color info = Color(0xFF4361EE); // Same as primary for info

  // Border & Divider Colors
  static const Color border = Color(0xFFDEE2E6); // Light border
  static const Color divider = Color(0xFFE9ECEF); // Slightly darker divider

  // Disabled State
  static const Color disabled = Color(0xFFCED4DA); // Disabled elements
  static const Color disabledText = Color(0xFFADB5BD); // Disabled text

  // Shadow (for elevation)
  static const Color shadow = Color(0x1A000000); // Black with 10% opacity

  // Gradient for buttons/backgrounds
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4361EE), Color(0xFF3A56D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF7209B7), Color(0xFFF72585)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}