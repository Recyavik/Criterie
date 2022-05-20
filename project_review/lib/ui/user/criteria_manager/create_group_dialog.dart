import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/config/singleton.dart';
import 'package:project_review/core/logic/project/bloc.dart';
import 'package:project_review/core/models/criteria/criteria_group_data.dart';
import 'package:project_review/core/services/navigation.dart';
import 'package:uuid/uuid.dart';

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({Key? key}) : super(key: key);

  @override
  State<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<CreateGroupDialog> {
  late TextEditingController controller;

  @override
  initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Новая группа критериев"),
      actions: [
        TextButton(
            onPressed: () {
              singleton.get<NavigationService>().navigator.pop();
            },
            child: const Text("Отмена")),
        ElevatedButton(
            onPressed: () {
              context.read<ProjectBloc>().add(AddCriteriaGroupEvent(
                  CriteriaGroupData(
                      0, const Uuid().v4(), controller.text, [])));
            },
            child: const Text("Добавить"))
      ],
      content: Container(
        constraints: const BoxConstraints(maxHeight: 80),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Flex(
          direction: Axis.vertical,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(label: Text("Название группы")),
            )
          ],
        ),
      ),
    );
  }
}
