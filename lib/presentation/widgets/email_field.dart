import 'package:flutter/material.dart';
import 'package:transactions_app/common/app_dimens.dart';
import 'package:transactions_app/resources/resources.dart';
import 'package:transactions_app/resources/strings_manager.dart';
import 'package:transactions_app/utils/exentions.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    required this.controller,
    this.hint,
    required this.validationEnabled,
    this.onFieldSubmitted,
    this.focus,
    super.key,
  });
  final TextEditingController controller;
  final String? hint;
  final ValueNotifier<bool> validationEnabled;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focus;

  @override
  State<EmailField> createState() => EmailFieldState();
}

class EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      focusNode: widget.focus,
      autovalidateMode: AutovalidateMode.always,
      controller: widget.controller,
      cursorColor: AppColors.darkGreyText,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: AppDecorations.textFieldDecoration.copyWith(
        hintText: widget.hint ?? StringsManager.email,
        prefixIcon: _messageIcon,
        errorMaxLines: 3,
      ),
      validator: _validator,
      onChanged: (text) {
        if (widget.validationEnabled.value == true) {
          widget.validationEnabled.value = false;
        }
      },
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }

  Widget get _messageIcon => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: AppDimens.size20,
            child: ImageIcon(
              AssetImage(ImagesPaths.message),
              color: AppColors.lightGreyText,
            ),
          ),
        ],
      );

  String? _validator(String? value) {
    if (!widget.validationEnabled.value) {
      return null;
    } else {
      if (value == null || value.isEmpty) {
        return 'required Field';
      } else if (!value.isEmail()) {
        return 'enter Valid Email';
      }
      return null;
    }
  }
}
