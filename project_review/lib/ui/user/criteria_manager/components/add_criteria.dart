import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/core/logic/project/bloc.dart';
import 'package:project_review/core/models/criteria/criteria_group_data.dart';
import 'package:project_review/core/models/criteria/criterion_data.dart';

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
