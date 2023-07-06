import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_app/app/routing/router.dart';
import 'package:transactions_app/presentation/widgets/app_button.dart';
import 'package:transactions_app/presentation/widgets/auth_bg_screen.dart';
import 'package:transactions_app/presentation/widgets/email_field.dart';
import 'package:transactions_app/presentation/widgets/helpers/toast_mixin.dart';
import 'package:transactions_app/presentation/widgets/name_field.dart';
import 'package:transactions_app/presentation/widgets/password_field.dart';
import 'package:transactions_app/presentation/widgets/socio_loading_overlay.dart';
import 'package:transactions_app/presentation/widgets/transparent_button.dart';
import 'package:transactions_app/resources/app_colors.dart';
import 'package:transactions_app/resources/strings_manager.dart';
import 'package:transactions_app/resources/styles_manager.dart';

import 'bloc/register_cubit.dart';

class RegisterWidget extends StatelessWidget with ToastMixin {
  RegisterWidget({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailValidationEnabled = ValueNotifier(false);
  final _nameValidationEnabled = ValueNotifier(false);
  final _passwordValidationEnabled = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSucceed) {
          // context.replaceRoute(const StepOneRoute());
        } else if (state is RegistrationFailed) {
          showToast(state.error);
        }
      },
      builder: (context, state) => AuthBgScreen(
        backButton: false,
        child: SocioLoadingOverlay(
          isLoading: state is RegistrationProcessing,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 22),
                    Text(
                      StringsManager.wellcome,
                      style: StylesManager.header5(AppColors.darkBlue, 30.17),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      StringsManager.signUp,
                      style: StylesManager.subtitle1(AppColors.darkBlue, 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        _textFields(context),
                        const SizedBox(height: 16),
                        AppButton(
                          title: StringsManager.signUp.toUpperCase(),
                          onPressed: () => _onRegisterPressed(context),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringsManager.already,
                              style: StylesManager.subtitle1(
                                AppColors.darkBlue,
                                30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            TransparentButton(
                              style: StylesManager.subtitle2(
                                AppColors.mainBlue,
                                16,
                              ),
                              title: StringsManager.signIn.toUpperCase(),
                              onPressed: () => context.pushRoute(const LoginPageRoute()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
            NameField(
              controller: _nameController,
              validationEnabled: _nameValidationEnabled,
              onFieldSubmitted: (v) {
                _emailFocus.requestFocus();
              },
            ),
            const SizedBox(height: 20),
            EmailField(
              controller: _emailController,
              validationEnabled: _emailValidationEnabled,
              onFieldSubmitted: (v) {
                _passwordFocus.requestFocus();
              },
            ),
            const SizedBox(height: 20),
            PasswordField(
              type: PassFieldType.regular,
              hint: StringsManager.password,
              controller: _passwordController,
              validationEnabled: _passwordValidationEnabled,
              focus: _passwordFocus,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ],
        ),
      );

  void _onRegisterPressed(BuildContext context) {
    _emailValidationEnabled.value = true;
    _passwordValidationEnabled.value = true;
    _nameValidationEnabled.value = true;
    if (_formKey.currentState?.validate() == true) {
      context.read<RegisterCubit>().registerWithEmail(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }
}
