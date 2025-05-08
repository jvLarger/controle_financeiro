import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF00BE44);

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  brightness: Brightness.light,
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  brightness: Brightness.dark,
);

final ThemeData lightTheme = ThemeData(
  cardColor: Colors.white,
  useMaterial3: true,
  colorScheme: lightColorScheme,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: lightColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    elevation: 1,
    titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: lightColorScheme.onPrimary,
      backgroundColor: lightColorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 3,
    color: lightColorScheme.surface,
    margin: const EdgeInsets.all(12),
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: lightColorScheme.surface,
    selectedIconTheme: IconThemeData(
      color: lightColorScheme.onSecondaryContainer,
    ),
    unselectedIconTheme: IconThemeData(
      color: lightColorScheme.onSurface.withOpacity(0.7),
    ),
    selectedLabelTextStyle: TextStyle(
      color: lightColorScheme.onSecondaryContainer,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: lightColorScheme.onSurface.withOpacity(0.7),
    ),
    useIndicator: true,
    indicatorColor: lightColorScheme.secondaryContainer.withOpacity(0.5),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  cardColor: darkColorScheme.surfaceVariant,
  useMaterial3: true,
  colorScheme: darkColorScheme,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: darkColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    elevation: 1,
    titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: darkColorScheme.onPrimary,
      backgroundColor: darkColorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 3,
    color: darkColorScheme.surface,
    margin: const EdgeInsets.all(12),
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: darkColorScheme.surface,
    selectedIconTheme: IconThemeData(
      color: darkColorScheme.onSecondaryContainer,
    ),
    unselectedIconTheme: IconThemeData(
      color: darkColorScheme.onSurface.withOpacity(0.7),
    ),
    selectedLabelTextStyle: TextStyle(
      color: darkColorScheme.onSecondaryContainer,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: darkColorScheme.onSurface.withOpacity(0.7),
    ),
    useIndicator: true,
    indicatorColor: darkColorScheme.secondaryContainer.withOpacity(0.5),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
