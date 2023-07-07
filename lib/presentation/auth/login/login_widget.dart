import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/app/routing/router.dart';
import 'package:transactions_app/common/app_dimens.dart';
import 'package:transactions_app/presentation/widgets/app_button.dart';
import 'package:transactions_app/presentation/widgets/auth_bg_screen.dart';
import 'package:transactions_app/presentation/widgets/email_field.dart';
import 'package:transactions_app/presentation/widgets/helpers/toast_mixin.dart';
import 'package:transactions_app/presentation/widgets/password_field.dart';
import 'package:transactions_app/presentation/widgets/socio_loading_overlay.dart';
import 'package:transactions_app/presentation/widgets/transparent_button.dart';
import 'package:transactions_app/resources/resources.dart';

import 'bloc/login_cubit.dart';

class LoginWidget extends StatelessWidget with ToastMixin {
  LoginWidget({super.key});

  final _emailController = TextEditingController(text: 'yevhenivanov@gmail.com');
  final _passwordController = TextEditingController(text: '#,Z/q2*FPrxv5fG');

  final _emailValidationEnabled = ValueNotifier(false);
  final _passwordValidationEnabled = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSucceed) {
          context.replaceRoute(const HomePageRoute());
        } else if (state is LoginFailed) {
          showToast(state.error);
        }
      },
      builder: (context, state) => AuthBgScreen(
        backButton: false,
        child: SocioLoadingOverlay(
          isLoading: state is LoginProcessing,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.size18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: AppDimens.size22),
                  Text(
                    'WelcomeBack',
                    style: StylesManager.header5(AppColors.darkBlue, AppDimens.size30),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 50),
                  Column(
                    children: [
                      _textFields(context),
                      const SizedBox(height: AppDimens.size16),
                      AppButton(
                        title: 'signIn'.toUpperCase(),
                        onPressed: () => _onLoginPressed(context),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TransparentButton(
                            style: StylesManager.subtitle2(AppColors.mainBlue, AppDimens.size16),
                            title: 'signUp'.toUpperCase(),
                            onPressed: () => context.popRoute(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(flex: 50),
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
              controller: _emailController,
              validationEnabled: _emailValidationEnabled,
              onFieldSubmitted: (v) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: AppDimens.size20),
            PasswordField(
              hint: 'password',
              controller: _passwordController,
              validationEnabled: _passwordValidationEnabled,
              focus: _passwordFocus,
              onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(FocusNode()),
            ),
          ],
        ),
      );

  void _onLoginPressed(BuildContext context) {
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
