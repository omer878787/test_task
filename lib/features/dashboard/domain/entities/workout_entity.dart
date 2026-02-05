import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
  final String title;
  final String subtitle;
  final int minutes;

  const WorkoutEntity({
    required this.title,
    required this.subtitle,
    required this.minutes,
  });

  @override
  List<Object?> get props => [title, subtitle, minutes];
}
