part of 'bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

class ProjectInitState extends ProjectState{}

class ProjectLoadState extends ProjectState{}
class ProjectShowState extends ProjectState{
  final ProjectRepository repo;

  const ProjectShowState(this.repo);
}