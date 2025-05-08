import 'package:controle_financeiro/components/page_navigator.dart';
import 'package:controle_financeiro/core/services/database_service.dart';
import 'package:controle_financeiro/core/theme/theme.dart';
import 'package:controle_financeiro/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.database;
  final controller = ThemeController();
  await controller.loadThemeMode();

  runApp(ChangeNotifierProvider.value(value: controller, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp(
      title: 'Controle Financeiro',
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const PageNavigatorMaterial(),
    );
  }
}
