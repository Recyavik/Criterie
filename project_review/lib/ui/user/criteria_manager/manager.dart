import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/config/singleton.dart';
import 'package:project_review/core/logic/project/bloc.dart';
import 'package:project_review/core/logic/project/repository.dart';
import 'package:project_review/core/services/navigation.dart';
import 'package:project_review/ui/user/criteria_manager/components/criteria_group.dart';
import 'package:project_review/ui/user/criteria_manager/create_group_dialog.dart';

class CriteriaManager extends StatelessWidget {
  const CriteriaManager({Key? key}) : super(key: key);

  List<Widget> buildBody(ProjectRepository rep) {
    List<Widget> list = [];
    for (var group in rep.selected.criteria) {
      list.add(CriteriaGroup(
        groupData: group,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Project: ${context.read<ProjectBloc>().repository.selected.id}"),
        actions: [
          IconButton(
              onPressed: () {
                singleton
                    .get<NavigationService>()
                    .showPopUpDialog(const CreateGroupDialog());
              },
              icon: const Icon(Icons.add))
        ],
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
