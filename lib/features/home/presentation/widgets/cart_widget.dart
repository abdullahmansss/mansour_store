import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/features/cart/presentation/screen/cart_screen.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CartScreen(
      isWithAppBar: false,
      // You can pass other parameters if needed
    );
  }
}
