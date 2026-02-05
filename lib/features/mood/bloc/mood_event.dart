import 'package:equatable/equatable.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();
  @override
  List<Object?> get props => [];
}

class MoodChanged extends MoodEvent {
  final double value;
  const MoodChanged(this.value);

  @override
  List<Object?> get props => [value];
}
