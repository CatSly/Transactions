import 'package:flutter/material.dart';
import 'package:transactions_app/common/app_dimens.dart';
import 'package:transactions_app/resources/resources.dart';

class AuthBgScreen extends StatefulWidget {
  const AuthBgScreen({
    required this.child,
    this.backButton = false,
    super.key,
  });
  final Widget child;
  final bool backButton;

  @override
  State<AuthBgScreen> createState() => _AuthBgScreenState();
}

class _AuthBgScreenState extends State<AuthBgScreen> {
  Widget get _background => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(ImagesPaths.authBg, fit: BoxFit.cover),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _background,
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.backButton) SizedBox(height: AppDimens.size52, child: _backButton(context)),
                Expanded(child: widget.child)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget? _backButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
    );
  }
}
