import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/core/logic/project/bloc.dart';
import 'package:project_review/core/models/criteria/criteria_group_data.dart';
import 'package:project_review/ui/user/criteria_manager/components/add_criteria.dart';

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
                      leading: isReview
                          ? e.isSelected
                              ? const Icon(Icons.check_circle)
                              : const Icon(Icons.circle)
                          : null,
                      onTap: isReview
                          ? () {
                              context.read<ProjectBloc>().add(
                                  ChangeSelectionCriteriaEvent(
                                      groupId: groupData.groupId, id: e.id));
                            }
                          : null,
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
