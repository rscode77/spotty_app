import 'package:flutter/material.dart';
import 'package:spotty_app/pages.dart';

class Routing {
  static const String login = '/login';
  static const String home = '/home';
  static const String events = '$home/events';
  static const String messages = '$home/messages';
  static const String appSettings = '$home/settings';

  const Routing._();

  static Route? getMainRoute(RouteSettings settings) {
    final Widget child;
    bool fullscreenDialog = false;

    switch (settings.name) {
      case home:
        child = Pages.home();
        break;
      case events:
        child = Pages.events();
        break;
      case login:
        child = Pages.login();
        break;
      case messages:
        child = Pages.messages();
        break;
      case appSettings:
        child = Pages.settings();
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
