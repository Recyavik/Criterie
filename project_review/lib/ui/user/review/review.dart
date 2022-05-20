import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/core/logic/project/bloc.dart';
import 'package:project_review/core/logic/project/repository.dart';
import 'package:project_review/ui/user/criteria_manager/manager.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  List<Widget> buildBody(ProjectRepository rep) {
    List<Widget> list = [];
    for (var group in rep.selected.criteria) {
      list.add(CriteriaGroup(
        isReview: true,
        groupData: group,
      ));
    }
    return list;
  }

  double calcTotal(BuildContext context){
    double total = 0;
    context.read<ProjectBloc>().repository.selected.criteria.forEach((element) { for (var element in element.criterion) { if(element.isSelected)total+=element.coast;}});
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Review: ${context.read<ProjectBloc>().repository.selected.id}"),
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectInitState) {
            context.read<ProjectBloc>().add(SelectLocalProjectEvent());
            return const Center(
              child: Text("init"),
            );
          }
          if (state is ProjectLoadState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProjectShowState) {
            return SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                children: buildBody(state.repo),
              ),
            );
          }
          throw ("Undefined project state");
        },
      ),
    );
  }
}
