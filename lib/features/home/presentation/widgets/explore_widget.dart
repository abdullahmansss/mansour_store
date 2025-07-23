import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/text_styles.dart';

class ExploreWidget extends StatelessWidget {
  const ExploreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Explore Widget',
      style: TextStylesManager.bold20,
    );
  }
}
