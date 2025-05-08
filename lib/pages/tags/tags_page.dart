import 'package:controle_financeiro/components/page_title.dart';
import 'package:flutter/material.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [PageTitle(title: "Cadastro de TAGs")]);
  }
}
