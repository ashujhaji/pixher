import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/create_repo.dart';

class CreateEvent {
  @override
  List<Object?> get props => [];
}

class CreateState {
  @override
  List<Object?> get props => [];
}

class GenerateLabelEvent extends CreateEvent {
  File file;

  GenerateLabelEvent(this.file);
}

class FetchTagsEvent extends CreateEvent {
  List<String> labels;

  FetchTagsEvent(this.labels);
}

class InitialState extends CreateState {}

class LabelState extends CreateState {
  List<String> labels;

  LabelState(this.labels);
}

class TagsFetched extends CreateState {
  Map<String, bool> tags;

  TagsFetched(this.tags);
}

class FetchCaption extends CreateEvent {
  List<String> tags;

  FetchCaption(this.tags);
}

class CaptionFetched extends CreateState {
  String caption;

  CaptionFetched(this.caption);
}

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateRepo repo;

  CreateBloc(CreateState initialState, this.repo) : super(initialState);

  @override
  Stream<CreateState> mapEventToState(CreateEvent event) async* {
    if (event is GenerateLabelEvent) {
      final lables = await repo.getLabels(event.file);
      print(lables);
      yield LabelState(lables);
    } else if (event is FetchTagsEvent) {
      for (String label in event.labels) {
        final tags = await repo.getTags(label);
        yield TagsFetched(tags);
      }
    }else if(event is FetchCaption){
      final data = await repo.getRandomCaption(event.tags);
      yield CaptionFetched(data);
    }
  }
}
