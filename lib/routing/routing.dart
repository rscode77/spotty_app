import 'package:flutter/material.dart';
import 'package:spotty_app/pages.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

class Routing {
  static const String _prefix = 'workPlan';
  static const String login = '$_prefix/login';
  static const String partDetail = '$_prefix/partDetail';
  static const String workPlan = _prefix;

  const Routing._();

  static bool canHandleRoute(String? routeName, String prefix) => routeName?.startsWith('$prefix/') ?? false;

  static Route? getMainRoute(RouteSettings settings) {
    final String routeName = settings.name.orEmpty();

    final Widget child;

    bool fullscreenDialog = false;
    final dynamic arguments = settings.arguments;

    switch (settings.name) {
    case workPlan:

    case login:
      child = Pages.login();
      break;
    default:
      return null;
    }

    return Routing.buildRoute(settings, fullscreenDialog, child);
  }

  static Route buildRoute(
      RouteSettings settings,
      bool fullscreenDialog,
      Widget child,
      ) =>
      MaterialPageRoute(
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        builder: (_) => child,
      );
}