import 'dart:async';

import 'package:project_review/core/api/api.dart';
import 'package:project_review/core/models/user/auth_data.dart';
import 'package:project_review/core/models/user/user_data.dart';

class AuthenticationRepository {
  final ApiClient _client = ApiClient();
  AuthData? _auth;

  AuthData? get auth => _auth;

  FutureOr<void> login(UserData user) async {
    try {
      _auth = await _client.authentication(user);
    } catch (_) {
      return;
    }
  }

  void logout() {
    _auth = null;
  }
}
