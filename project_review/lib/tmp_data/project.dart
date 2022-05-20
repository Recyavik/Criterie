import 'package:project_review/core/models/criteria/criteria_group_data.dart';
import 'package:project_review/core/models/criteria/criterion_data.dart';
import 'package:project_review/core/models/criteria/project_criteria_data.dart';

ProjectCriteriaData projectCriteriaData =
    ProjectCriteriaData("qwe-asd", "asd-qwe", <CriteriaGroupData>[
  CriteriaGroupData(1, "asd-1we", "First group",
      <CriterionData>[CriterionData(id: 0, coast: 1, title: "First criterion")])
]);
