import 'package:flutter/material.dart';

class MoodStep {
  final double from; // 0..1
  final double to; // 0..1
  final String label;
  final Widget center;

  const MoodStep({
    required this.from,
    required this.to,
    required this.label,
    required this.center,
  });

  bool contains(double p) => p >= from && p < to;
}
