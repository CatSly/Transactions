import 'package:flutter/material.dart';
import 'package:transactions_app/resources/resources.dart';
import 'package:transactions_app/resources/strings_manager.dart';

class NameField extends StatefulWidget {
  const NameField({
    required this.controller,
    required this.validationEnabled,
    this.onFieldSubmitted,
    this.focus,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final ValueNotifier<bool> validationEnabled;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focus;

  @override
  State<NameField> createState() => NameFieldState();
}

class NameFieldState extends State<NameField> {
  final RegExp nameRegExp = RegExp(r'([a-zA-Z]{3,30}\s*)+');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          textInputAction: TextInputAction.next,
          focusNode: widget.focus,
          autovalidateMode: AutovalidateMode.always,
          controller: widget.controller,
          cursorColor: AppColors.darkGreyText,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: AppDecorations.textFieldDecoration.copyWith(
            hintText: StringsManager.name,
            prefixIcon: _iconBuilder,
            errorMaxLines: 3,
          ),
          validator: _validator,
          onChanged: (text) {
            if (widget.validationEnabled.value == true) {
              widget.validationEnabled.value = false;
            }
          },
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }

  Widget get _iconBuilder => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            child: ImageIcon(
              AssetImage(ImagesPaths.accountBox),
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
      } else if (!nameRegExp.hasMatch(value)) {
        return 'please Enter Name';
      }
      return null;
    }
  }
}
