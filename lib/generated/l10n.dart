// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Zaloguj`
  String get login {
    return Intl.message(
      'Zaloguj',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Zarejestruj się`
  String get register {
    return Intl.message(
      'Zarejestruj się',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Wyloguj`
  String get logout {
    return Intl.message(
      'Wyloguj',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Hasło`
  String get password {
    return Intl.message(
      'Hasło',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Powtórz hasło`
  String get repeatPassword {
    return Intl.message(
      'Powtórz hasło',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Nazwa użytkownika`
  String get username {
    return Intl.message(
      'Nazwa użytkownika',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Powrót`
  String get back {
    return Intl.message(
      'Powrót',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Napisz wiadomość...`
  String get writeMessage {
    return Intl.message(
      'Napisz wiadomość...',
      name: 'writeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Wiadomość`
  String get message {
    return Intl.message(
      'Wiadomość',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Zapomniałeś hasła?`
  String get forgotPassword {
    return Intl.message(
      'Zapomniałeś hasła?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Nie masz konta?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Nie masz konta?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Witaj!`
  String get hello {
    return Intl.message(
      'Witaj!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Zaloguj się do swojego konta`
  String get loginToYourAccount {
    return Intl.message(
      'Zaloguj się do swojego konta',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Dołącz do Spotty!`
  String get joinToSpotty {
    return Intl.message(
      'Dołącz do Spotty!',
      name: 'joinToSpotty',
      desc: '',
      args: [],
    );
  }

  /// `Zarejestruj się, odkrywaj i dziel się spotami`
  String get registerMessage {
    return Intl.message(
      'Zarejestruj się, odkrywaj i dziel się spotami',
      name: 'registerMessage',
      desc: '',
      args: [],
    );
  }

  /// `Dołącz do wydarzenia`
  String get joinToEvent {
    return Intl.message(
      'Dołącz do wydarzenia',
      name: 'joinToEvent',
      desc: '',
      args: [],
    );
  }

  /// `Stwórz wydarzenie`
  String get createEvent {
    return Intl.message(
      'Stwórz wydarzenie',
      name: 'createEvent',
      desc: '',
      args: [],
    );
  }

  /// `Opuść wydarzenie`
  String get leaveEvent {
    return Intl.message(
      'Opuść wydarzenie',
      name: 'leaveEvent',
      desc: '',
      args: [],
    );
  }

  /// `Wprowadź nazwę użytkownika...`
  String get findUser {
    return Intl.message(
      'Wprowadź nazwę użytkownika...',
      name: 'findUser',
      desc: '',
      args: [],
    );
  }

  /// `Wyszukaj wydarzenie...`
  String get findEvent {
    return Intl.message(
      'Wyszukaj wydarzenie...',
      name: 'findEvent',
      desc: '',
      args: [],
    );
  }

  /// `Wyszukaj czat...`
  String get findChat {
    return Intl.message(
      'Wyszukaj czat...',
      name: 'findChat',
      desc: '',
      args: [],
    );
  }

  /// `Użytkownicy`
  String get users {
    return Intl.message(
      'Użytkownicy',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `Dołącz`
  String get join {
    return Intl.message(
      'Dołącz',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Opuść`
  String get leave {
    return Intl.message(
      'Opuść',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Ostatnio wyszukiwane`
  String get recentlySearch {
    return Intl.message(
      'Ostatnio wyszukiwane',
      name: 'recentlySearch',
      desc: '',
      args: [],
    );
  }

  /// `Brak wyników`
  String get noResults {
    return Intl.message(
      'Brak wyników',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Lokalizacje`
  String get searchLocation {
    return Intl.message(
      'Lokalizacje',
      name: 'searchLocation',
      desc: '',
      args: [],
    );
  }

  /// `Wprowadź lokalizację...`
  String get enterLocation {
    return Intl.message(
      'Wprowadź lokalizację...',
      name: 'enterLocation',
      desc: '',
      args: [],
    );
  }

  /// `Wyszukane lokalizacje`
  String get searchedLocations {
    return Intl.message(
      'Wyszukane lokalizacje',
      name: 'searchedLocations',
      desc: '',
      args: [],
    );
  }

  /// `Szczegóły wydarzenia`
  String get eventDetails {
    return Intl.message(
      'Szczegóły wydarzenia',
      name: 'eventDetails',
      desc: '',
      args: [],
    );
  }

  /// `Nawiguj`
  String get navigate {
    return Intl.message(
      'Nawiguj',
      name: 'navigate',
      desc: '',
      args: [],
    );
  }

  /// `Opis wydarzenia`
  String get eventDescription {
    return Intl.message(
      'Opis wydarzenia',
      name: 'eventDescription',
      desc: '',
      args: [],
    );
  }

  /// `Twój profil`
  String get profile {
    return Intl.message(
      'Twój profil',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Wydarzenia`
  String get events {
    return Intl.message(
      'Wydarzenia',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Wiadomości`
  String get messages {
    return Intl.message(
      'Wiadomości',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Szczegóły użytkownika`
  String get userDetails {
    return Intl.message(
      'Szczegóły użytkownika',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `edytuj nazwę użytkownika`
  String get editUsername {
    return Intl.message(
      'edytuj nazwę użytkownika',
      name: 'editUsername',
      desc: '',
      args: [],
    );
  }

  /// `Dodaj nowy pojazd`
  String get addNewVehicle {
    return Intl.message(
      'Dodaj nowy pojazd',
      name: 'addNewVehicle',
      desc: '',
      args: [],
    );
  }

  /// `edytuj email`
  String get editEmail {
    return Intl.message(
      'edytuj email',
      name: 'editEmail',
      desc: '',
      args: [],
    );
  }

  /// `Dodaj pojazd`
  String get addVehicle {
    return Intl.message(
      'Dodaj pojazd',
      name: 'addVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Nie dodano pojazdu`
  String get vehicleNotAdded {
    return Intl.message(
      'Nie dodano pojazdu',
      name: 'vehicleNotAdded',
      desc: '',
      args: [],
    );
  }

  /// `Twoje pojazdy`
  String get yourVehicles {
    return Intl.message(
      'Twoje pojazdy',
      name: 'yourVehicles',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
