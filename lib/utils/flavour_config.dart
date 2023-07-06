import 'package:flutter/material.dart';
import 'package:transactions_app/resources/app_colors.dart';

enum Environment {
  stage,
  prod,
}

// ignore: avoid_classes_with_only_static_members
class Constants {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.stage:
        _config = _Config.stageConstants;
        break;
      case Environment.prod:
        _config = _Config.prodConstants;
        break;
    }
  }

  static String get whereAmI {
    return _config[_Config.flavour] as String;
  }
}

// ignore: avoid_classes_with_only_static_members
class _Config {
  static const flavour = 'flavour';

  static Map<String, dynamic> stageConstants = {
    flavour: 'stage',
  };

  static Map<String, dynamic> prodConstants = {
    flavour: 'prod',
  };
}

extension FlavourTypeExtension on String {
  Color getFlavourColor() {
    switch (this) {
      case 'stage':
        return AppColors.barsDark;
      case 'prod':
        return AppColors.blueCode;
      default:
        return AppColors.lightGreen;
    }
  }

  String getFlavourName() {
    switch (this) {
      case 'stage':
        return 'Stage';
      case 'prod':
        return 'Prod';
      default:
        return 'Unknown';
    }
  }
}
