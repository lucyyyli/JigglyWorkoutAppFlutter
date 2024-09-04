import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;

  static ThemeData appTheme = themeData(colorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        centerTitle: false,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
    );
  }

  static const ColorScheme colorScheme = ColorScheme(
    primary: Color(0xFF322942),
    primaryContainer: Color(0xFF241E30),
    secondary: Color(0xFF7C7BBB),
    secondaryContainer: Color(0xFF605FA3),
    tertiary: Color(0xFFB8E598),
    tertiaryContainer: Color(0xFF5A805A),
    surface: Color(0xFF9F9DE1),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: Color(0xFF7C7BBB),
    onSecondary: Color(0xFF605FA3),
    onTertiary: Color(0xFF241E30),
    onTertiaryContainer: Color(0xFF241E30),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    headlineMedium: GoogleFonts.barlowCondensed(
      fontSize: 40.0,
      fontWeight: _semiBold,
      fontStyle: FontStyle.italic,
      color: colorScheme.primary,
    ),
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 50.0,
      color: colorScheme.primary,
    ),

    bodySmall: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 18.0),

    displaySmall: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 14.0),
    displayMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    displayLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 18.0),

    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    labelMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    labelLarge: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 18.0),

    titleSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    titleMedium: GoogleFonts.montserrat(
      fontWeight: _medium,
      fontSize: 20.0,
      color: colorScheme.primary,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: _bold,
      fontStyle: FontStyle.italic,
      color: colorScheme.primary,
    ),
  );
}
