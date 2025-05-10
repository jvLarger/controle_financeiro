import 'package:flutter/material.dart';

Color parseColor(String hex) {
  final cleaned = hex.replaceFirst('#', '');
  final withAlpha = cleaned.length == 6 ? 'FF$cleaned' : cleaned;
  return Color(int.parse('0x$withAlpha'));
}

String toHexRGB(Color color) {
  // ignore: deprecated_member_use
  final rgb = color.value & 0xFFFFFF;
  return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
