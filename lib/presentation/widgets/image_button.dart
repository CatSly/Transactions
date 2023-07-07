import 'package:flutter/material.dart';
import 'package:transactions_app/common/app_dimens.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    required this.iconFunction,
    required this.imagePath,
    super.key,
  });
  final VoidCallback iconFunction;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(imagePath),
      iconSize: AppDimens.size80,
      onPressed: iconFunction,
    );
  }
}
