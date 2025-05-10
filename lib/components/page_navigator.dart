import 'package:controle_financeiro/pages/categories/categories_page.dart';
import 'package:controle_financeiro/pages/tags/tags_page.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:controle_financeiro/pages/home/home_page.dart';
import 'package:controle_financeiro/pages/transaction/transactions_page.dart';

class PageNavigatorMaterial extends StatefulWidget {
  const PageNavigatorMaterial({super.key});

  @override
  State<PageNavigatorMaterial> createState() => _PageNavigatorMaterialState();
}

class _PageNavigatorMaterialState extends State<PageNavigatorMaterial> {
  int selectedIndex = 0;
  bool isExtended = true;

  final List<Widget> pages = const [
    HomePage(),
    TransactionsPage(), // Lançamentos
    TransactionsPage(), // Faturas
    TransactionsPage(), // Contas Bancárias
    TransactionsPage(), // Lançamentos Recorrentes
    CategoriesPage(), // Categorias
    TagsPage(), // TAGs
    TransactionsPage(), // Configurações
  ];

  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(
      icon: Icon(IconlyLight.chart),
      selectedIcon: Icon(IconlyBold.chart),
      label: Text('Dashboard'),
    ),
    NavigationRailDestination(
      icon: Icon(IconlyLight.edit_square),
      selectedIcon: Icon(IconlyBold.editSquare),
      label: Text('Lançamentos'),
    ),
    NavigationRailDestination(
      icon: Icon(IconlyLight.document),
      selectedIcon: Icon(IconlyBold.document),
      label: Text('Faturas'),
    ),
    NavigationRailDestination(
      icon: Icon(IconlyLight.folder),
      selectedIcon: Icon(IconlyBold.folder),
      label: Text('Contas'),
    ),
    NavigationRailDestination(
      icon: Icon(IconlyLight.calendar),
      selectedIcon: Icon(IconlyBold.category),
      label: Text('Lançamentos Recorrentes'),
    ),
    NavigationRailDestination(
      icon: Icon(IconlyLight.category),
      selectedIcon: Icon(IconlyBold.category),
      label: Text('Categorias'),
    ),
    NavigationRailDestination(
      icon: Icon(IconlyLight.ticket_star),
      selectedIcon: Icon(IconlyBold.ticket_star),
      label: Text('TAGs'),
    ),
    NavigationRailDestination(
      icon: Icon(IconlyLight.setting),
      selectedIcon: Icon(IconlyBold.setting),
      label: Text('Configurações'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barra superior
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

            child: Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => isExtended = !isExtended),
                  icon: Icon(isExtended ? Icons.menu_open : Icons.menu),
                  tooltip: 'Alternar menu',
                ),
                const SizedBox(width: 8),
                const Text(
                  '💰 Controle Financeiro',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                const Text('v1.0.0', style: TextStyle(fontSize: 14)),
                const Spacer(),
                /*  IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  tooltip: 'Alternar tema',
                  onPressed:
                      () => context.read<ThemeController>().toggleTheme(),
                ),
                */
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'Sobre',
                ),
              ],
            ),
          ),
          // Corpo com NavigationRail + conteúdo
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected:
                      (index) => setState(() => selectedIndex = index),
                  extended: isExtended,
                  destinations: destinations,
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                      ),
                    ),

                    child: pages[selectedIndex],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
