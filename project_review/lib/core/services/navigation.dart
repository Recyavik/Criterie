import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => navigatorKey.currentState!;

  Future showPopUpDialog(
      AlertDialog dialog, {
        bool barrierDismissible = true,
      }) async {
    final context = navigatorKey.currentState!.overlay!.context;

    return await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (_) => dialog,
    );
  }

  void showMessage(String message, {Color color = Colors.green, int duration = 1}) {
    final context = navigatorKey.currentState!.overlay!.context;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }
}