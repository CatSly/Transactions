import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/presentation/widgets/app_button.dart';
import 'package:transactions_app/presentation/widgets/auth_bg_screen.dart';
import 'package:transactions_app/presentation/widgets/email_field.dart';
import 'package:transactions_app/presentation/widgets/helpers/toast_mixin.dart';
import 'package:transactions_app/presentation/widgets/password_field.dart';
import 'package:transactions_app/presentation/widgets/socio_loading_overlay.dart';
import 'package:transactions_app/resources/app_colors.dart';
import 'package:transactions_app/resources/styles_manager.dart';

import 'bloc/new_password_cubit.dart';

class NewPasswordWidget extends StatelessWidget with ToastMixin {
  NewPasswordWidget({Key? key}) : super(key: key);

  final _emailController = TextEditingController(
    text:
        // kDebugMode ? DebugConst.email :
        '',
  );
  final _passwordController = TextEditingController(
    text:
        // kDebugMode ? DebugConst.password :
        '',
  );

  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  final _emailValidationEnabled = ValueNotifier(false);
  final _passwordValidationEnabled = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) showToast(state.error);
      },
      builder: (context, state) => AuthBgScreen(
        backButton: false,
        child: SocioLoadingOverlay(
          isLoading: state is LoginProcessing,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'create New Password',
                    style: StylesManager.header5(AppColors.darkBlue, 30.17),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'for Completing Password',
                    style: StylesManager.subtitle1(AppColors.darkBlue, 24),
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      _textFields(context),
                      const SizedBox(height: 16),
                      AppButton(
                        title: 'apply New Password'.toUpperCase(),
                        onPressed: () => _onLoginPressed(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFields(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            EmailField(
              hint: 'new Password',
              controller: _emailController,
              validationEnabled: _emailValidationEnabled,
              onFieldSubmitted: (v) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: 20),
            PasswordField(
              hint: 'confirm New Password',
              controller: _passwordController,
              validationEnabled: _passwordValidationEnabled,
              focus: _passwordFocus,
              onFieldSubmitted: (v) => _onLoginPressed(context),
            ),
          ],
        ),
      );

  void _onLoginPressed(BuildContext context) {
    // context.pushRoute(const StepOneRoute());
    _emailValidationEnabled.value = true;
    _passwordValidationEnabled.value = true;
    final valid = _formKey.currentState?.validate();
    if (valid == true) {
      context.read<LoginCubit>().loginWithEmail(
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }
}
