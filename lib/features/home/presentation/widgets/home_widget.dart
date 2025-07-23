import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widgets/banners_home_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BannersHomeWidget(),
        verticalSpace30,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 16,
            children: [
              horizontalSpace16,
              ...[1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6].asMap().map((index, value) {
                return MapEntry(
                  index,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      verticalSpace10,
                      Text(
                        'Men',
                        style: TextStylesManager.regular16,
                      ),
                    ],
                  ),
                );
              }).values,
              horizontalSpace16,
            ],
          ),
        ),
      ],
    );
  }
}
