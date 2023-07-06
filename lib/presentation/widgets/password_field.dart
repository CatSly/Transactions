import 'package:flutter/material.dart';
import 'package:transactions_app/resources/resources.dart';

enum PassFieldType { regular, create, confirm }

class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.controller,
    required this.validationEnabled,
    this.type = PassFieldType.regular,
    this.onFieldSubmitted,
    required this.hint,
    this.focus,
    this.matchingPassController,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final TextEditingController? matchingPassController;
  final ValueNotifier<bool> validationEnabled;
  final ValueChanged<String>? onFieldSubmitted;
  final String hint;
  final FocusNode? focus;
  final PassFieldType type;

  @override
  State<PasswordField> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  final bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscure,
      textInputAction: TextInputAction.done,
      focusNode: widget.focus,
      autovalidateMode: AutovalidateMode.always,
      controller: widget.controller,
      cursorColor: AppColors.darkBlue,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: AppDecorations.textFieldDecoration.copyWith(
        hintText: widget.hint,
        prefixIcon: _lockIcon,
        errorMaxLines: 3,
      ),
      validator: _validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: (text) {
        if (widget.validationEnabled.value == true) {
          widget.validationEnabled.value = false;
        }
      },
    );
  }

  Widget get _lockIcon => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            child: ImageIcon(
              AssetImage(ImagesPaths.lock),
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
      } else if (value.length < 8) {
        return 'the Password Needs';
      } else if (widget.type == PassFieldType.confirm &&
          widget.matchingPassController != null) {
        if (widget.matchingPassController!.text != widget.controller.text) {
          return 'passwords Mismatch';
        } else {
          return null;
        }
      }
      return null;
    }
  }
}
