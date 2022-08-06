import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../repository/playground_repo.dart';

class PlaygroundEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaygroundState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends PlaygroundState {}

class StartRecordingEvent extends PlaygroundEvent {
  late ValueChanged<double> onAnimationChanged;
  late AnimationController controller;
  late GlobalKey repaintKey;

  StartRecordingEvent(this.controller, this.onAnimationChanged, this.repaintKey);
}

class FileSavedState extends PlaygroundState {
  late File file;
  FileSavedState(this.file);
}

class PlaygroundBloc extends Bloc<PlaygroundEvent, PlaygroundState> {
  PlaygroundRepo repo;

  PlaygroundBloc(PlaygroundState initialState, this.repo) : super(initialState);

  @override
  Stream<PlaygroundState> mapEventToState(PlaygroundEvent event) async* {
    if (event is StartRecordingEvent) {
      final file =
          await repo.startRecording(event.controller, event.onAnimationChanged, event.repaintKey);
      yield FileSavedState(file);
    }
  }
}
