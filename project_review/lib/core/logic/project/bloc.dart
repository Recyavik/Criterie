import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/config/singleton.dart';
import 'package:project_review/core/logic/project/repository.dart';
import 'package:project_review/core/models/criteria/criteria_group_data.dart';
import 'package:project_review/core/models/criteria/criterion_data.dart';
import 'package:project_review/core/services/navigation.dart';

part 'event.dart';

part 'state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitState()) {
    on<SelectLocalProjectEvent>(_onSelectLocal);
    on<AddCriteriaGroupEvent>(_onAddCriteriaGroup);
    on<AddCriteriaEvent>(_onAddCriteria);
    on<ChangeSelectionCriteriaEvent>(_onSelectCriteria);
  }

  ProjectRepository repository = ProjectRepository();

  ///Tmp method
  FutureOr<void> _onSelectLocal(
      SelectLocalProjectEvent event, Emitter<ProjectState> emitter) async {
    emitter(ProjectLoadState());
    emitter(ProjectShowState(repository));
  }

  FutureOr<void> _onAddCriteriaGroup(
      AddCriteriaGroupEvent event, Emitter<ProjectState> emitter) async {
    emitter(ProjectLoadState());
    singleton.get<NavigationService>().navigator.pop();
    repository.selected.criteria.add(event.groupData);
    emitter(ProjectShowState(repository));
  }

  FutureOr<void> _onAddCriteria(
      AddCriteriaEvent event, Emitter<ProjectState> emitter) async {
    emitter(ProjectLoadState());

    repository.selected.criteria
        .firstWhere((element) => element.groupId == event.groupId)
        .criterion
        .add(event.criteria);
    emitter(ProjectShowState(repository));
  }

  FutureOr<void> _onSelectCriteria(
      ChangeSelectionCriteriaEvent event, Emitter<ProjectState> emitter) async {
    emitter(ProjectLoadState());

    repository.selected.criteria
        .firstWhere((element) => element.groupId == event.groupId)
        .criterion
        .firstWhere((element) => element.id == event.id)
        .changeSelection();
    emitter(ProjectShowState(repository));
  }
}
