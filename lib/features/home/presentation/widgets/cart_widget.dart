import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/text_styles.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Cart Widget',
      style: TextStylesManager.bold20,
    );
  }
}
