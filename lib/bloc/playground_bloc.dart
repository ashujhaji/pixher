import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../repository/playground_repo.dart';

class PlaygroundEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaygroundState {
  @override
  List<Object?> get props => [];
}

class InitialState extends PlaygroundState {}

class StartRecordingEvent extends PlaygroundEvent {
  late ValueChanged<double> onAnimationChanged;
  late AnimationController controller;
  late GlobalKey repaintKey;
  bool download;
  String fileName;

  StartRecordingEvent(
    this.controller,
    this.onAnimationChanged,
    this.repaintKey, {
    this.download = false,
    this.fileName = 'img',
  });
}

class CaptureScreenEvent extends PlaygroundEvent {
  late GlobalKey repaintKey;
  bool download;
  String fileName;

  CaptureScreenEvent(this.repaintKey,
      {this.download = false, this.fileName = 'img'});
}

class FileSavedState extends PlaygroundState {
  late File? file;
  bool download;

  FileSavedState(this.file, this.download);
}

class DownloadFileEvent extends PlaygroundEvent{
  late File file;
  DownloadFileEvent(this.file);
}

class DownloadFileState extends PlaygroundState{
  String status = '';
  DownloadFileState(this.status,);
}

class PlaygroundBloc extends Bloc<PlaygroundEvent, PlaygroundState> {
  PlaygroundRepo repo;

  PlaygroundBloc(PlaygroundState initialState, this.repo) : super(initialState);

  @override
  Stream<PlaygroundState> mapEventToState(PlaygroundEvent event) async* {
    if (event is StartRecordingEvent) {
      final file = await repo.startRecording(
          event.controller, event.onAnimationChanged, event.repaintKey,fileName: event.fileName);
      yield FileSavedState(file, event.download);
    } else if (event is CaptureScreenEvent) {
      final file = await repo.captureScreen(event.repaintKey,fileName: event.fileName);
      yield FileSavedState(file, event.download);
    }else if(event is DownloadFileEvent){
      final status = await repo.downloadDesign(event.file);
      yield DownloadFileState(status);
    }
  }
}
