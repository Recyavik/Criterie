import 'package:flutter/material.dart';
import 'package:project_review/config/bloc_wrapper.dart';
import 'package:project_review/ui/root.dart';

import 'config/singleton.dart';

void main() async {
  await singletonInit();
  runApp(const BlocWrapper(child: RootPage()));
}
