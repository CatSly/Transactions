import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:transactions_app/app/locator/locator.config.dart';

final locator = GetIt.instance;

@InjectableInit(asExtension: false)
FutureOr<GetIt> setupLocator() => init(locator);
