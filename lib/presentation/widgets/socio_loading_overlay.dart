import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SocioLoadingOverlay extends StatelessWidget {
  const SocioLoadingOverlay({
    required this.child,
    required this.isLoading,
    super.key,
  });
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: Colors.transparent,
      child: child,
    );
  }
}
