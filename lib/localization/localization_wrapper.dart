import 'package:flutter/material.dart';

class LocalizationWrapper extends StatelessWidget {
  const LocalizationWrapper({
    Key? key,
    required this.app,
  }) : super(key: key);
  final Widget app;

  @override
  Widget build(BuildContext context) {
    return app;
  }
}
