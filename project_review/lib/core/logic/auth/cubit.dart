import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_review/config/singleton.dart';
import 'package:project_review/core/logic/auth/repository.dart';
import 'package:project_review/core/models/user/user_data.dart';
import 'package:project_review/core/services/navigation.dart';

part 'state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  final AuthenticationRepository _repository =
      singleton<AuthenticationRepository>();

  void getUser() async {
    //TODO: impl get local user data
    await Future.delayed(const Duration(seconds: 3));
    emit(NotAuthenticated());
  }

  void login(UserData user) async {
    emit(AuthenticationLoading());
    await _repository.login(user);
    if (_repository.auth != null) {
      emit(AuthenticatedState());
    } else {
      singleton.get<NavigationService>().showMessage("Неверный логин или пароль", color: Colors.red);
      emit(NotAuthenticated());
    }
  }

  void logout() {
    emit(AuthenticationLoading());
    _repository.logout();
    emit(NotAuthenticated());
  }
}
