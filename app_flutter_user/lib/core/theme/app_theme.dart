import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors from Style Guide
  static const Color primaryOrange = Color(0xFFFF6A00);
  static const Color primaryGradientStart = Color(0xFFFF8A00);
  static const Color primaryGradientEnd = Color(0xFFFF6A00);
  
  // Surface Colors
  static const Color background = Color(0xFFF7F8FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF2F4F7);
  
  // Text Colors
  static const Color onBackground = Color(0xFF1F2937);
  static const Color onSurface = Color(0xFF1F2937);
  static const Color onSurfaceVariant = Color(0xFF475467);
  
  // Border Colors
  static const Color outline = Color(0xFFE6E8EE);
  static const Color disabled = Color(0xFFA0A0B2);
  
  // Quick Action Colors
  static const Color contentTileBackground = Color(0xFFE8EEFF);
  static const Color contentTileIcon = Color(0xFF335CFF);
  static const Color usersTileBackground = Color(0xFFE9FCEB);
  static const Color usersTileIcon = Color(0xFF16A34A);
  static const Color paymentsTileBackground = Color(0xFFFFF6D8);
  static const Color paymentsTileIcon = Color(0xFFD97706);
  static const Color notificationsTileBackground = Color(0xFFF3E8FF);
  static const Color notificationsTileIcon = Color(0xFF7C3AED);
  
  // Chip Colors
  static const Color chipUnselectedBackground = Color(0xFFEFF2F5);
  static const Color chipUnselectedText = Color(0xFF111827);
  static const Color chipSelectedBackground = Color(0xFFFFEEE0);
  static const Color chipSelectedText = Color(0xFF9A3412);
  
  // Bottom Navigation
  static const Color bottomNavActive = primaryOrange;
  static const Color bottomNavInactive = Color(0xFF94A3B8);
  
  // Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: primaryOrange,
    brightness: Brightness.light,
    primary: primaryOrange,
    onPrimary: Colors.white,
    secondary: const Color(0xFFF97316),
    onSecondary: Colors.white,
    tertiary: const Color(0xFF8B5CF6),
    onTertiary: Colors.white,
    error: error,
    onError: Colors.white,
    background: background,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
    surfaceVariant: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
  );

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.interTextTheme().copyWith(
      headlineLarge: GoogleFonts.inter(
        fontSize: 28,
        height: 36/28,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        height: 32/24,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        height: 28/20,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        height: 24/16,
        fontWeight: FontWeight.w400,
        color: onBackground,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 20/14,
        fontWeight: FontWeight.w400,
        color: onBackground,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        height: 20/14,
        fontWeight: FontWeight.w500,
        color: onBackground,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: background,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.black.withOpacity(0.06),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 48),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryOrange,
          side: const BorderSide(color: primaryOrange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 48),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryOrange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: bottomNavActive,
        unselectedItemColor: bottomNavInactive,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: textTheme.labelLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: textTheme.labelLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: chipUnselectedBackground,
        selectedColor: chipSelectedBackground,
        labelStyle: textTheme.labelLarge?.copyWith(
          color: chipUnselectedText,
        ),
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(
          color: chipSelectedText,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        side: BorderSide.none,
      ),
    );
  }

  // Gradient for App Bars and Hero Buttons
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryGradientStart, primaryGradientEnd],
  );
  
  // Box Shadow for Cards
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      offset: const Offset(0, 1),
      blurRadius: 1,
    ),
  ];
  
  // Box Shadow for Elevated Buttons
  static List<BoxShadow> get elevatedButtonShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      offset: const Offset(0, 2),
      blurRadius: 8,
    ),
  ];
}

