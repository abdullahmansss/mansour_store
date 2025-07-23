import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Profile Widget',
      style: TextStylesManager.bold20,
    );
  }
}
