import 'package:controle_financeiro/models/tag.dart';
import 'package:flutter/material.dart';

class TagFormDialog extends StatefulWidget {
  final Tag tag;
  final void Function(Tag updatedTag) onSave;

  const TagFormDialog({super.key, required this.tag, required this.onSave});

  @override
  State<TagFormDialog> createState() => _TagFormDialogState();
}

class _TagFormDialogState extends State<TagFormDialog> {
  late TextEditingController _nameController;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tag.name);
    _color = widget.tag.color;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _selectColor() async {
    final color = await showDialog<Color>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Escolha uma cor'),
            content: SingleChildScrollView(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    [
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                      Colors.orange,
                      Colors.purple,
                      Colors.brown,
                      Colors.teal,
                      Colors.pink,
                      Colors.amber,
                      Colors.indigo,
                      Colors.cyan,
                      Colors.lime,
                      Colors.deepOrange,
                      Colors.deepPurple,
                      Colors.lightBlue,
                      Colors.lightGreen,
                      Colors.yellow,
                      Colors.grey,
                      Colors.black,
                    ].map((c) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pop(c),
                        child: CircleAvatar(backgroundColor: c, radius: 20),
                      );
                    }).toList(),
              ),
            ),
          ),
    );

    if (color != null) setState(() => _color = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar TAG'),
      content: SizedBox(
        width: 400, // 👈 largura do diálogo
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Cor:'),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _selectColor,
                  child: CircleAvatar(backgroundColor: _color),
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
        ElevatedButton(
          onPressed: () {
            final updatedTag = Tag(
              id: widget.tag.id,
              name: _nameController.text.trim(),
              color: _color,
            );
            widget.onSave(updatedTag);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
