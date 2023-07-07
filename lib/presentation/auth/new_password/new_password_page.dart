import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/app/locator/locator.dart';

import 'bloc/new_password_cubit.dart';
import 'new_password_widget.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LoginCubit>(),
      child: NewPasswordWidget(),
    );
  }
}
