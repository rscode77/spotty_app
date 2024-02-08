import 'package:flutter/material.dart';
import 'package:spotty_app/pages.dart';

class Routing {
  static const String login = '/login';
  static const String map = '/map';
  static const String mapSearch = '$map/mapSearch';
  static const String mainPage = '/mainPage';
  static const String register = '$login/register';
  static const String events = '$mainPage/events';
  static const String addNewVehicle = '$profilePage/addNewVehicle';
  static const String eventDetails = '$events/events';
  static const String appSettings = '$mainPage/settings';
  static const String chatsList = '$mainPage/chats';
  static const String chatPage = '$chatsList/chat';
  static const String profilePage = '$mainPage/profile';

  const Routing._();

  static Route? getMainRoute(RouteSettings settings) {
    final Widget child;
    bool fullscreenDialog = false;

    switch (settings.name) {
      case map:
        child = Pages.map();
        break;
      case mapSearch:
        child = Pages.mapSearch();
        break;
      case events:
        child = Pages.events();
        break;
      case eventDetails:
        child = Pages.eventDetails();
        break;
      case login:
        child = Pages.login();
        break;
      case register:
        child = Pages.register();
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
      case mainPage:
        child = Pages.mainPage();
        break;
      case profilePage:
        child = Pages.profilePage();
        break;
      case addNewVehicle:
        child = Pages.addNewVehicle();
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
