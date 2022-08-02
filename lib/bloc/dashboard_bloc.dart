import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/categories.dart';
import '../model/template.dart';
import '../repository/dashboard_repo.dart';

class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends DashboardState {}

class FetchDashboardCategories extends DashboardEvent {}

class FetchTemplatesByCategory extends DashboardEvent {
  final Category category;

  FetchTemplatesByCategory(this.category);
}

class CategoriesFetchedState extends DashboardState {
  final List<Category>? categories;

  CategoriesFetchedState(this.categories);
}

class TemplatesFetchedState extends DashboardState {
  final List<Template>? _templates;
  final Category _category;

  TemplatesFetchedState(this._category, this._templates);

  List<Template>? get templates => _templates;
  Category get category => _category;
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardRepo repo;

  DashboardBloc(DashboardState initialState, this.repo) : super(initialState);

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is FetchDashboardCategories) {
      final data = await repo.fetchCategories();
      yield CategoriesFetchedState(data);
    } else if (event is FetchTemplatesByCategory) {
      final data =
          await repo.fetchTemplatesByCategory(event.category.id.toString());
      yield TemplatesFetchedState(event.category,data);
    }
  }
}
