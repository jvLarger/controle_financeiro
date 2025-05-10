import 'package:controle_financeiro/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class TagTile extends StatelessWidget {
  final Tag tag;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TagTile({super.key, required this.tag, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? Theme.of(context).cardColor : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        leading: CircleAvatar(backgroundColor: tag.color),
        title: Text(tag.name, style: const TextStyle(fontSize: 16)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Editar',
              icon: const Icon(IconlyLight.edit, color: Colors.blueAccent),
              onPressed: onEdit,
            ),
            IconButton(
              tooltip: 'Excluir',
              icon: const Icon(IconlyLight.delete, color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
