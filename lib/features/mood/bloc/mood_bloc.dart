import 'package:flutter_bloc/flutter_bloc.dart';
import 'mood_event.dart';
import 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc() : super(const MoodState(value: 0.7, label: "Calm")) {
    on<MoodChanged>((e, emit) {
      // simple label mapping
      final v = e.value.clamp(0.0, 1.0);
      final label = v < 0.33 ? "Low" : (v < 0.66 ? "Okay" : "Calm");
      emit(MoodState(value: v, label: label));
    });
  }
}
