import 'package:controle_financeiro/core/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:controle_financeiro/models/category.dart';
import 'package:controle_financeiro/core/utils/toast.dart';

class CategoryFormDialog extends StatefulWidget {
  final Category? category;
  final CategoryType categoryType;
  final void Function(bool success) onSaved;

  const CategoryFormDialog({
    super.key,
    this.category,
    required this.categoryType,
    required this.onSaved,
  });

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  final TextEditingController _nameController = TextEditingController();
  final CategoryService _categoryService = CategoryService();
  late CategoryType _selectedType;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.category?.name ?? '';
    _selectedType = widget.category?.type ?? widget.categoryType;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      showErrorToast(context, 'O nome é obrigatório');
      return;
    }

    try {
      if (widget.category == null) {
        await _categoryService.addCategory(
          Category(name: name, type: _selectedType),
        );
        showSuccessToast(context, 'Categoria criada com sucesso!');
      } else {
        await _categoryService.updateCategory(
          Category(id: widget.category!.id, name: name, type: _selectedType),
        );
        showSuccessToast(context, 'Categoria atualizada com sucesso!');
      }
      widget.onSaved(true);
    } catch (e) {
      showErrorToast(context, e.toString());
      widget.onSaved(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      child: AlertDialog(
        title: Text(
          widget.category == null ? 'Nova Categoria' : 'Editar Categoria',
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Tipo:'),
                  const SizedBox(width: 12),
                  DropdownButton<CategoryType>(
                    value: _selectedType,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedType = value);
                      }
                    },
                    items:
                        CategoryType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type == CategoryType.expense
                                  ? 'Despesa'
                                  : 'Receita',
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(onPressed: _save, child: const Text('Salvar')),
        ],
      ),
    );
  }
}
