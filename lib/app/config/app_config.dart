import 'package:flutter/material.dart';

abstract class AppConfig {
  AppConfig._();

  static final List<Locale> locales = [
    const Locale('en'),
  ];

  static const String localesPath = 'assets/localization/';
}
