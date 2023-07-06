import 'package:flutter/material.dart';
import 'package:transactions_app/resources/app_colors.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    required this.title,
    required this.onPressed,
    required this.style,
    this.hasBorder = false,
    this.buttonColor,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final bool hasBorder;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: hasBorder == true
            ? const BorderSide(color: AppColors.mainBlue)
            : BorderSide.none,
      ),
      padding: const EdgeInsets.all(4),
      onPressed: onPressed,
      child: Text(title, style: style, textAlign: TextAlign.center),
    );
  }
}
