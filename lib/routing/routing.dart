import 'package:flutter/material.dart';
import 'package:spotty_app/pages.dart';

class Routing {
  static const String login = '/login';
  static const String home = '/home';
  static const String events = '$home/events';
  static const String appSettings = '$home/settings';
  static const String chatsList = '$home/chats';
  static const String chatPage = '$chatsList/chat';

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
      case appSettings:
        child = Pages.settings();
        break;
      case chatsList:
        child = Pages.chatsList();
        break;
      case chatPage:
        child = Pages.chat();
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
