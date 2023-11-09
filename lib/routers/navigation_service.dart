import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setupLocator() {
    locator.registerLazySingleton(() => NavigationService());
  }

  void navigateToPage(Widget page) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => page));
  }

  // chuyển sang page giữ nguyên các page trước trong stack
  void goPage(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  // chuyển sang page mà k cần chuyển về màn trước đÓ (bỏ màn trước đÓ ra khỏi stack)
  void goToPage(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  // chuyển sang page và xoá hết các page trước trong stack.
  void goToPageAndRemoveAllRoutes(Widget page) {
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
