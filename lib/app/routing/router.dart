import 'package:auto_route/auto_route.dart';
import 'package:transactions_app/presentation/auth/login/login_page.dart';
import 'package:transactions_app/presentation/auth/register/register_page.dart';
import 'package:transactions_app/presentation/home_screen/home_page.dart';
import 'package:transactions_app/presentation/splash_screen/splash_page.dart';

import 'package:injectable/injectable.dart';

part 'router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Screen,Route,Page')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashPageRoute.page,
          path: SplashPage.routeName,
          initial: true,
        ),
        AutoRoute(
          page: HomePageRoute.page,
          path: HomePage.routeName,
        ),
        AutoRoute(
          page: LoginPageRoute.page,
          path: LoginPage.routeName,
        ),
        AutoRoute(
          page: RegisterPageRoute.page,
          path: RegisterPage.routeName,
        )
      ];
}
