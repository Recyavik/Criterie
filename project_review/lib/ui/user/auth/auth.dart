import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/core/logic/auth/cubit.dart';
import 'package:project_review/core/models/user/user_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late TextEditingController loginController;
  late TextEditingController passwordController;

  @override
  initState() {
    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Flex(
            direction: Axis.vertical,
            children: [
              const Spacer(),
              const _AuthHeader(),
              TextField(
                controller: loginController,
                decoration: const InputDecoration(
                    label: Text("Логин"), prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    label: Text("Пароль"), prefixIcon: Icon(Icons.lock)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationCubit>().login(UserData(
                        username: loginController.text,
                        password: passwordController.text));
                  },
                  child: const Text("Войти")),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      child: Flex(
        direction: Axis.vertical,
        children: const [
          Flexible(
              fit: FlexFit.tight,
              child: Placeholder()),
          Text("Project review application")
        ],
      ),
    );
  }
}

