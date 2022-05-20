import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/config/singleton.dart';
import 'package:project_review/core/logic/project/bloc.dart';
import 'package:project_review/core/logic/project/repository.dart';
import 'package:project_review/core/models/criteria/criteria_group_data.dart';
import 'package:project_review/core/models/criteria/criterion_data.dart';
import 'package:project_review/core/services/navigation.dart';
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

class CriteriaGroup extends StatelessWidget {
  final CriteriaGroupData groupData;
  final bool isReview;

  const CriteriaGroup(
      {Key? key, required this.groupData, this.isReview = false})
      : super(key: key);

  double calculateTotal() {
    double total = 0;
    for (var element in groupData.criterion) {
      if (isReview) {
        if (element.isSelected) {
          total += element.coast;
        }
      } else {
        total += element.coast;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Text(
                  groupData.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  groupData.groupId,
                  style: Theme.of(context).textTheme.caption,
                ),
                const Spacer(),
                Text(calculateTotal().toString())
              ],
            ),
          ),
          const Divider(),
          Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: groupData.criterion
                .map<Widget>((e) => ListTile(
              leading: isReview ? e.isSelected ? const Icon(Icons.check_circle) : const Icon(Icons.circle) : null,
                      onTap: isReview ? () {
                        context.read<ProjectBloc>().add(ChangeSelectionCriteriaEvent(
                          groupId: groupData.groupId,
                          id: e.id
                        ));
                      } : null,
                      title: Text(e.title),
                      trailing: Text(e.coast.toString()),
                    ))
                .toList()
              ..add(isReview
                  ? Container()
                  : AddCriteria(
                      criteriaGroupData: groupData,
                    )),
          )
        ],
      ),
    );
  }
}

class AddCriteria extends StatefulWidget {
  final CriteriaGroupData criteriaGroupData;

  const AddCriteria({Key? key, required this.criteriaGroupData})
      : super(key: key);

  @override
  State<AddCriteria> createState() => _AddCriteriaState();
}

class _AddCriteriaState extends State<AddCriteria> {
  late TextEditingController coastController;
  late TextEditingController titleController;

  @override
  initState() {
    coastController = TextEditingController();
    titleController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const Text("Название: "),
          Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: TextField(
                controller: titleController,
              )),
          const Text("Бал: "),
          Flexible(
              fit: FlexFit.tight,
              child: TextField(
                controller: coastController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              )),
          IconButton(
              onPressed: () {
                context.read<ProjectBloc>().add(AddCriteriaEvent(
                    criteria: CriterionData(
                        id: widget.criteriaGroupData.criterion.length,
                        coast: double.parse(coastController.text),
                        title: titleController.text),
                    groupId: widget.criteriaGroupData.groupId));
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
