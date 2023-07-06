import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/app/locator/locator.dart';
import 'package:transactions_app/presentation/splash_screen/bloc/splash_cubit.dart';

import 'splash_widget.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SplashCubit>(),
      child: const SplashWidget(),
    );
  }
}
