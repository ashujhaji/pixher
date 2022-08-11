import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../repository/create_repo.dart';

class CreateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateLabelEvent extends CreateEvent{
  File file;
  GenerateLabelEvent(this.file);
}

class InitialState extends CreateState {}

class LabelState extends CreateState{
  List<String> labels;
  LabelState(this.labels);
}


class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateRepo repo;

  CreateBloc(CreateState initialState, this.repo) : super(initialState);

  @override
  Stream<CreateState> mapEventToState(CreateEvent event) async* {
    if (event is GenerateLabelEvent) {
      final lables = await repo.getLabels(event.file);
      yield LabelState(lables);
    }
  }
}
