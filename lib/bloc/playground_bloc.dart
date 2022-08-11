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
  bool generateHashtag;

  StartRecordingEvent(this.controller, this.onAnimationChanged, this.repaintKey,
      {this.generateHashtag = false});
}

class CaptureScreenEvent extends PlaygroundEvent {
  late GlobalKey repaintKey;
  bool generateHashtag;

  CaptureScreenEvent(this.repaintKey, {this.generateHashtag = false});
}

class FileSavedState extends PlaygroundState {
  late File? file;
  bool generateHashtag;

  FileSavedState(this.file, this.generateHashtag);
}

class PlaygroundBloc extends Bloc<PlaygroundEvent, PlaygroundState> {
  PlaygroundRepo repo;

  PlaygroundBloc(PlaygroundState initialState, this.repo) : super(initialState);

  @override
  Stream<PlaygroundState> mapEventToState(PlaygroundEvent event) async* {
    if (event is StartRecordingEvent) {
      final file = await repo.startRecording(
          event.controller, event.onAnimationChanged, event.repaintKey);
      yield FileSavedState(file,event.generateHashtag);
    } else if (event is CaptureScreenEvent) {
      final file = await repo.captureScreen(event.repaintKey);
      yield FileSavedState(file,event.generateHashtag);
    }
  }
}
