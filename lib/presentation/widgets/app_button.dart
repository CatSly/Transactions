import 'package:flutter/material.dart';
import 'package:transactions_app/common/app_dimens.dart';
import 'package:transactions_app/resources/resources.dart';

enum ButtonType { white, darkBlue }

class AppButton extends StatelessWidget {
  const AppButton({
    this.hasImage = false,
    required this.title,
    this.imagePath = '',
    required this.onPressed,
    this.type = ButtonType.darkBlue,
    this.buttonHeight = 48,
    super.key,
  });
  final bool hasImage;
  final String title;
  final String imagePath;
  final VoidCallback onPressed;
  final int buttonHeight;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: _overlayColor,
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, AppDimens.size40)),
        backgroundColor: MaterialStateProperty.all<Color>(_color.withOpacity(1)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.size4)),
        ),
      ),
      onPressed: onPressed,
      child: hasImage
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppDimens.size18,
                  child: Image(image: AssetImage(imagePath)),
                ),
                const SizedBox(width: AppDimens.size24),
                Text(title, style: _style),
              ],
            )
          : Text(title, style: _style),
    );
  }

  MaterialStateProperty<Color>? get _overlayColor {
    switch (type) {
      case ButtonType.white:
        return MaterialStateProperty.all<Color>(
          AppColors.barsDark.withOpacity(0.1),
        );
      case ButtonType.darkBlue:
        return null;
    }
  }

  Color get _color {
    switch (type) {
      case ButtonType.white:
        return AppColors.white;
      case ButtonType.darkBlue:
        return AppColors.darkBlue;
    }
  }

  TextStyle get _style {
    switch (type) {
      case ButtonType.white:
        return StylesManager.subtitle2Roboto(AppColors.darkBlue, AppDimens.size16);
      case ButtonType.darkBlue:
        return StylesManager.subtitle2(AppColors.white, AppDimens.size16);
    }
  }
}
