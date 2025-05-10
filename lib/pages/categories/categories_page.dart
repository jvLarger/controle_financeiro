import 'package:controle_financeiro/components/page_title.dart';
import 'package:controle_financeiro/core/services/category_service.dart';
import 'package:controle_financeiro/pages/categories/widgets/category_form_dialog.dart';
import 'package:controle_financeiro/pages/categories/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:controle_financeiro/models/category.dart';
import 'package:controle_financeiro/core/utils/toast.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Category>> _categoriesFuture;
  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  CategoryType? _selectedType;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_applyFilter);
    _loadCategories();
  }

  void _loadCategories() {
    setState(() {
      if (_selectedType == null) {
        _categoriesFuture = _categoryService.getAllCategories();
      } else {
        _categoriesFuture = _categoryService.getCategoriesByType(
          _selectedType!,
        );
      }
    });
    _categoriesFuture.then((value) {
      _allCategories = value;
      _applyFilter();
    });
  }

  void _applyFilter() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories =
          _allCategories.where((category) {
            return category.name.toLowerCase().contains(query);
          }).toList();
    });
  }

  void _openForm({Category? category}) {
    showDialog(
      context: context,
      builder:
          (_) => CategoryFormDialog(
            category: category,
            categoryType: _selectedType ?? CategoryType.expense,
            onSaved: (success) {
              if (success && mounted) {
                Navigator.pop(context);
                _loadCategories();
              }
            },
          ),
    );
  }

  void _confirmDelete(Category category) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Excluir categoria'),
            content: Text('Deseja realmente excluir "${category.name}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      try {
        await _categoryService.deleteCategory(category.id!);
        showSuccessToast(context, 'Categoria excluída com sucesso!');
        _loadCategories();
      } catch (e) {
        showErrorToast(context, e.toString());
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageTitle(title: "Cadastro de Categorias"),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              DropdownButton<CategoryType?>(
                value: _selectedType,
                items: [
                  const DropdownMenuItem(value: null, child: Text('Todos')),
                  ...CategoryType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(
                        type == CategoryType.expense ? 'Despesas' : 'Receitas',
                      ),
                    );
                  }),
                ],
                onChanged: (type) {
                  setState(() => _selectedType = type);
                  _loadCategories();
                },
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Buscar por nome',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => _openForm(),
                icon: const Icon(Icons.add),
                label: const Text('Nova Categoria'),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Category>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else if (_filteredCategories.isEmpty) {
                return const Center(
                  child: Text('Nenhuma categoria encontrada.'),
                );
              }

              return ListView.builder(
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = _filteredCategories[index];
                  return CategoryTile(
                    category: category,
                    onEdit: () => _openForm(category: category),
                    onDelete: () => _confirmDelete(category),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
