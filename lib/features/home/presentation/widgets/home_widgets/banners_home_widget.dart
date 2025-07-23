import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/features/home/presentation/logic/home_cubit.dart';
import 'package:mansour_store/features/home/presentation/logic/home_states.dart';

class BannersHomeWidget extends StatelessWidget {
  const BannersHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            viewportFraction: 0.9,
            onPageChanged: (index, __) {
              homeCubit.currentBannerIndex = index;
            },
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      // Handle banner tap
                      debugPrint('Banner $i tapped');
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorsManager.primaryColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          'text $i',
                          style: TextStylesManager.bold18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        verticalSpace12,
        BlocBuilder<HomeCubit, HomeStates>(
          buildWhen: (previous, current) {
            return current is ChangeBannerIndexState;
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4, 5]
                  .asMap()
                  .map((index, item) {
                    return MapEntry(
                      index,
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 6.0,
                        ),
                        child: Container(
                          width: index == homeCubit.currentBannerIndex ? 30.0 : 7,
                          height: 7.0,
                          decoration: BoxDecoration(
                            color:
                                index == homeCubit.currentBannerIndex ? ColorsManager.primaryColor : ColorsManager.blackColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    );
                  })
                  .values
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
