import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/config/singleton.dart';
import 'package:project_review/core/logic/auth/cubit.dart';
import 'package:project_review/core/logic/auth/repository.dart';
import 'package:project_review/core/services/navigation.dart';
import 'package:project_review/ui/user/criteria_manager/manager.dart';
import 'package:project_review/ui/user/criteria_manager/review/review.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  String _getUserType() {
    switch (singleton.get<AuthenticationRepository>().auth!.type) {
      case 1:
        return "User";
      case 5:
        return "Admin";
      default:
        return "Undefined user type";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Text(
              "Token: ${singleton.get<AuthenticationRepository>().auth!.token}"),
          Text(
              "Username: ${singleton.get<AuthenticationRepository>().auth!.username}"),
          Text(
              "UserId: ${singleton.get<AuthenticationRepository>().auth!.userId}"),
          Text("UserType: ${_getUserType()}"),
          ElevatedButton(
              onPressed: () {
                context.read<AuthenticationCubit>().logout();
              },
              child: const Text("Выход")),
          ElevatedButton(
              onPressed: () {
                singleton.get<NavigationService>().navigator.push(
                    MaterialPageRoute(
                        builder: (context) => const CriteriaManager()));
              },
              child: const Text("Менеджер критериев")),
          ElevatedButton(
              onPressed: () {
                singleton.get<NavigationService>().navigator.push(
                    MaterialPageRoute(
                        builder: (context) => const ReviewPage()));
              },
              child: const Text("Оценка")),
        ],
      ),
    );
  }
}
