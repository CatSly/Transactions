import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/app/routing/router.dart';
import 'package:transactions_app/common/app_dimens.dart';
import 'package:transactions_app/presentation/splash_screen/bloc/splash_cubit.dart';
import 'package:transactions_app/presentation/widgets/auth_bg_screen.dart';
import 'package:transactions_app/resources/app_colors.dart';
import 'package:transactions_app/resources/images_paths.dart';
import 'package:transactions_app/resources/strings_manager.dart';
import 'package:transactions_app/resources/styles_manager.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  String? path;
  String? userName;

  @override
  void initState() {
    context.read<SplashCubit>().checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UserAuthenticated) {
          context.pushRoute(const HomePageRoute());
        }
        if (state is UserNonAuthenticated) {
          context.pushRoute(const RegisterPageRoute());
        }
      },
      child: AuthBgScreen(
        backButton: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.size18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: AppDimens.size100,
                    child: Image(image: AssetImage(ImagesPaths.appLogo)),
                  ),
                  const SizedBox(height: AppDimens.size48),
                  Text(
                    StringsManager.appName,
                    style: StylesManager.header4(AppColors.darkBlue, AppDimens.size40),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
