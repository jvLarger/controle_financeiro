import 'package:flutter/material.dart';
import 'package:controle_financeiro/models/category.dart';
import 'package:iconly/iconly.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryTile({
    super.key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isExpense = category.type == CategoryType.expense;
    return Container(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            leading: Container(
              width: 10,
              height: double.infinity,
              color: isExpense ? Colors.red : Colors.green,
            ),
            title: Text(category.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(IconlyLight.edit, color: Colors.blueAccent),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(IconlyLight.delete, color: Colors.redAccent),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          Divider(thickness: 0.5, height: 1),
        ],
      ),
    );
  }
}
