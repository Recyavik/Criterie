part of 'bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

///Tmp event
class SelectLocalProjectEvent extends ProjectEvent {}

class AddCriteriaGroupEvent extends ProjectEvent {
  final CriteriaGroupData groupData;

  const AddCriteriaGroupEvent(this.groupData);
}

class AddCriteriaEvent extends ProjectEvent {
  final CriterionData criteria;
  final String groupId;

  const AddCriteriaEvent({required this.criteria, required this.groupId});
}

class ChangeSelectionCriteriaEvent extends ProjectEvent {
  final int id;
  final String groupId;

  const ChangeSelectionCriteriaEvent({required this.id, required this.groupId});
}
