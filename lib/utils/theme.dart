import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Custom Color Palette for AI Math App
class AppColors {
  // Primary colors - Deep blue representing intelligence and mathematics
  static const Color primaryBlue = Color(0xFF1E3A8A); // Deep blue
  static const Color primaryLight = Color(0xFF3B82F6); // Bright blue
  static const Color primaryDark = Color(0xFF1E40AF); // Darker blue
  
  // Secondary colors - Purple for AI/tech feeling
  static const Color secondaryPurple = Color(0xFF7C3AED); // Vivid purple
  static const Color secondaryLight = Color(0xFF8B5CF6); // Light purple
  static const Color accentPurple = Color(0xFF6366F1); // Indigo accent
  
  // Mathematical accent colors
  static const Color mathGreen = Color(0xFF10B981); // Success/correct answers
  static const Color mathOrange = Color(0xFFF59E0B); // Warning/attention
  static const Color mathRed = Color(0xFFEF4444); // Error/incorrect
  
  // Neural network inspired gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, secondaryPurple],
  );
  
  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, secondaryLight],
  );
  
  // Background colors
  static const Color backgroundLight = Color(0xFFFAFBFF); // Very light blue-white
  static const Color backgroundDark = Color(0xFF0F172A); // Dark slate
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceDark = Color(0xFF1E293B); // Dark surface
  
  // Text colors
  static const Color textPrimary = Color(0xFF0F172A); // Dark slate
  static const Color textSecondary = Color(0xFF475569); // Medium slate
  static const Color textLight = Color(0xFF94A3B8); // Light slate
  static const Color textWhite = Color(0xFFFFFFFF); // White
  
  // Card and container colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);
}

ThemeData buildAppTheme() {
  return ThemeData(
    // Core theme settings
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Color scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.textWhite,
      secondary: AppColors.secondaryPurple,
      onSecondary: AppColors.textWhite,
      tertiary: AppColors.accentPurple,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimary,
      background: AppColors.backgroundLight,
      onBackground: AppColors.textPrimary,
      error: AppColors.mathRed,
      onError: AppColors.textWhite,
    ),
    
    // App Bar Theme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 2,
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.textWhite,
      titleTextStyle: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(
        color: AppColors.textWhite,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    
    // Typography - Mathematical and clean
    textTheme: const TextTheme(
      // Display styles for headers
      displayLarge: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.25,
      ),
      displaySmall: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0,
      ),
      
      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
      ),
      
      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
      titleSmall: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.1,
      ),
      
      // Body text
      bodyLarge: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        letterSpacing: 0.25,
        height: 1.4,
      ),
      bodySmall: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      
      // Label text
      labelLarge: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
        letterSpacing: 0.5,
      ),
    ),
    
    // Card Theme - Clean and modern
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: AppColors.primaryBlue.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.cardLight,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Elevated Button Theme - Mathematical precision
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shadowColor: AppColors.primaryBlue.withOpacity(0.25),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.textWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.mathRed, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(
        color: AppColors.textLight,
        fontFamily: 'SF Pro Text',
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontFamily: 'SF Pro Text',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceLight,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.textLight,
      selectedLabelStyle: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryPurple,
      foregroundColor: AppColors.textWhite,
      elevation: 4,
      shape: CircleBorder(),
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textSecondary,
      size: 24,
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.borderLight,
      thickness: 1,
      space: 1,
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryLight.withOpacity(0.1),
      labelStyle: const TextStyle(
        color: AppColors.primaryBlue,
        fontFamily: 'SF Pro Text',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      pressElevation: 2,
    ),
    
    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryBlue,
      linearTrackColor: AppColors.borderLight,
      circularTrackColor: AppColors.borderLight,
    ),
    
    // Snack Bar Theme
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: TextStyle(
        color: AppColors.textWhite,
        fontFamily: 'SF Pro Text',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    ),
    
    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      titleTextStyle: const TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: 'SF Pro Text',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
    ),
  );
}

// Dark Theme for AI Math App
ThemeData buildDarkAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      onPrimary: AppColors.textPrimary,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.textPrimary,
      tertiary: AppColors.accentPurple,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textWhite,
      background: AppColors.backgroundDark,
      onBackground: AppColors.textWhite,
      error: AppColors.mathRed,
      onError: AppColors.textWhite,
    ),
    
    // Override specific themes for dark mode
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.textWhite,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: AppColors.primaryLight.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.cardDark,
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.textLight,
    ),
  );
}

// Utility class for theme-related constants
class ThemeConstants {
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 20.0;
  
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
}