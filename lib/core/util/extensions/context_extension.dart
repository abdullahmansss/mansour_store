import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void push<ARG>(
    String routeName, {
    ARG? arguments,
  }) =>
      Navigator.pushNamed(
        this,
        routeName,
        arguments: arguments,
      );

  void get pop => Navigator.pop(this);

  void popUntil(String routeName) =>
      Navigator.popUntil(this, ModalRoute.withName(routeName));

  ARG? getArg<ARG>() {
    return (ModalRoute.of(this)?.settings.arguments as ARG?)!;
  }
}
