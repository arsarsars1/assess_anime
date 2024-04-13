import 'package:assess_anime/core/utils/utilities.dart';
import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? context;

  static Future<void> pushRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    if (navigatorKey.currentState != null) {
      await navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog));
    } else {
      Utilities.debugPrintCustom("pushRoute null");
    }
  }

  static void pop() {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pop();
    } else {
      Utilities.debugPrintCustom("pushRoute null");
    }
  }
}
