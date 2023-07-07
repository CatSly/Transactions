import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/app/locator/locator.dart';

import 'bloc/login_cubit.dart';
import 'login_widget.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LoginCubit>(),
      child: LoginWidget(),
    );
  }
}
