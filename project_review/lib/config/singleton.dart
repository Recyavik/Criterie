import 'package:get_it/get_it.dart';
import 'package:project_review/core/logic/auth/repository.dart';
import 'package:project_review/core/services/navigation.dart';

final singleton = GetIt.instance;

Future<void> singletonInit() async {
  singleton.registerSingleton<AuthenticationRepository>(AuthenticationRepository());
  singleton.registerSingleton<NavigationService>(NavigationService());

  await singleton.allReady();
}