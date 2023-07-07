import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transactions_app/common/app_dimens.dart';
import 'package:transactions_app/resources/images_paths.dart';

class BackPageButton extends StatelessWidget {
  const BackPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.popRoute(),
      icon: SizedBox(height: AppDimens.size12, child: Image.asset(ImagesPaths.arrowLeftBlack)),
    );
  }
}
