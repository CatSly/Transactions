import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/app/locator/locator.dart';

import 'bloc/register_cubit.dart';
import 'register_widget.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const routeName = "/register";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RegisterCubit>(),
      child: RegisterWidget(),
    );
  }
}
