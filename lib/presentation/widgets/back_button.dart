import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transactions_app/resources/images_paths.dart';

class BackPageButton extends StatelessWidget {
  const BackPageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.popRoute(),
      icon:
          SizedBox(height: 12, child: Image.asset(ImagesPaths.arrowLeftBlack)),
    );
  }
}
