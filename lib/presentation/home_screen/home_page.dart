import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}