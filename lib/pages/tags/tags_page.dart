// ignore_for_file: use_build_context_synchronously

import 'package:controle_financeiro/core/utils/toast.dart';
import 'package:controle_financeiro/models/tag.dart';
import 'package:controle_financeiro/pages/tags/widgets/tag_form_dialog.dart';
import 'package:controle_financeiro/pages/tags/widgets/tag_tile.dart';
import 'package:controle_financeiro/services/tag_service.dart';
import 'package:flutter/material.dart';
import 'package:controle_financeiro/components/page_title.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  final TagService _tagService = TagService();
  final TextEditingController _filterController = TextEditingController();

  late Future<List<Tag>> _tagsFuture;
  List<Tag> _allTags = [];
  List<Tag> _filteredTags = [];

  @override
  void initState() {
    super.initState();
    _tagsFuture = _loadTags();
    _filterController.addListener(_applyFilter);
  }

  Future<List<Tag>> _loadTags() async {
    final tags = await _tagService.getAllTags();
    _allTags = tags;
    _filteredTags = tags;
    return tags;
  }

  void _applyFilter() {
    final query = _filterController.text.toLowerCase();
    setState(() {
      _filteredTags =
          _allTags
              .where((tag) => tag.name.toLowerCase().contains(query))
              .toList();
    });
  }

  void _refreshTags() async {
    final tags = await _loadTags();
    if (!mounted) return;
    setState(() {
      _tagsFuture = Future.value(tags);
    });
  }

  void _openForm({Tag? tag}) {
    showDialog(
      context: context,
      builder:
          (_) => TagFormDialog(
            tag: tag ?? Tag(id: null, name: '', color: Colors.grey),
            onSave: (savedTag) async {
              if (tag == null) {
                try {
                  await _tagService.addTag(savedTag);
                  showSuccessToast(context, 'TAG criada com sucesso!');
                  _refreshTags();
                  Navigator.pop(context);
                } catch (e) {
                  showErrorToast(context, e.toString());
                }
              } else {
                try {
                  await _tagService.updateTag(savedTag);
                  showSuccessToast(context, 'TAG atualizada com sucesso!');
                  _refreshTags();
                  Navigator.pop(context);
                } catch (e) {
                  showErrorToast(context, e.toString());
                }
              }

              if (!mounted) return;
              _refreshTags();
            },
          ),
    );
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageTitle(title: "Cadastro de TAGs"),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _filterController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Filtrar por nome',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _openForm(),
                icon: const Icon(Icons.add),
                label: const Text('Nova TAG'),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Tag>>(
            future: _tagsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showErrorToast(context, snapshot.error.toString());
                });
                return const Center(child: Text('Erro ao carregar TAGs.'));
              } else if (_filteredTags.isEmpty) {
                return const Center(child: Text('Nenhuma TAG encontrada.'));
              }

              return ListView.builder(
                itemCount: _filteredTags.length,
                itemBuilder: (context, index) {
                  final tag = _filteredTags[index];
                  return TagTile(
                    tag: tag,
                    onEdit: () => _openForm(tag: tag),
                    onDelete: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text('Confirmar exclusão'),
                              content: Text(
                                'Deseja realmente excluir a TAG "${tag.name}"?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Excluir'),
                                ),
                              ],
                            ),
                      );

                      if (confirm == true) {
                        try {
                          await _tagService.deleteTag(tag.id!);
                          if (!mounted) return;
                          showSuccessToast(
                            context,
                            'TAG excluída com sucesso!',
                          );
                          _refreshTags();
                        } catch (e) {
                          showErrorToast(context, e.toString());
                        }
                      }
                    },
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
