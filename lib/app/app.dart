import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:transactions_app/app/locator/locator.dart';
import 'package:transactions_app/app/routing/router.dart';
import 'package:transactions_app/localization/localization_wrapper.dart';
import 'package:transactions_app/resources/strings_manager.dart';

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  await setupLocator();
  runApp(
    const LocalizationWrapper(
      app: BookOrganizerApp(),
    ),
  );
}

class BookOrganizerApp extends StatefulWidget {


  const BookOrganizerApp({Key? key})
      : super(key: key);

  @override
  State<BookOrganizerApp> createState() => _BookOrganizerAppState();
}

class _BookOrganizerAppState extends State<BookOrganizerApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringsManager.appName,
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(
        initialRoutes: [const SplashPageRoute()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
