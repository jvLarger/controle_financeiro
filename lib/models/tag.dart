import 'package:controle_financeiro/core/utils/color_util.dart';
import 'package:flutter/material.dart';

class Tag {
  final int? id;
  final String name;
  final Color color;

  Tag({this.id, required this.name, required this.color});

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as int?,
      name: map['name'] as String,
      color: parseColor(map['color']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'color': toHexRGB(color)};
  }
}
