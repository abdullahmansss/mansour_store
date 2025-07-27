import 'package:flutter/material.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widgets/banners_home_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widgets/categories_home_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BannersHomeWidget(),
        verticalSpace30,
        const CategoriesHomeWidget(),
      ],
    );
  }
}
