import 'package:equatable/equatable.dart';

class MoodState extends Equatable {
  final double value; // 0..1
  final String label;

  const MoodState({required this.value, required this.label});

  @override
  List<Object?> get props => [value, label];
}
