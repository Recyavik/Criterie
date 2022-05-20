import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/config/singleton.dart';
import 'package:project_review/core/logic/auth/cubit.dart';
import 'package:project_review/core/services/navigation.dart';
import 'package:project_review/ui/splash/splash.dart';
import 'package:project_review/ui/user/auth/auth.dart';
import 'package:project_review/ui/user/profile.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: singleton.get<NavigationService>().navigatorKey,
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            context.read<AuthenticationCubit>().getUser();
            return const SplashPage();
          }
          if (state is AuthenticationLoading) {
            return const SplashPage();
          }
          if (state is NotAuthenticated) {
            return const AuthPage();
          }
          if (state is AuthenticatedState) {
            return const ProfilePage();
          }
          throw ("Undefined state");
        },
      ),
    );
  }
}
