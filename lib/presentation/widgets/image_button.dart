import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.iconFunction,
    required this.imagePath,
  }) : super(key: key);
  final VoidCallback iconFunction;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(imagePath),
      iconSize: 80,
      onPressed: iconFunction,
    );
  }
}
