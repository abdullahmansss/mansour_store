import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/features/home/presentation/logic/home_cubit.dart';
import 'package:mansour_store/features/home/presentation/logic/home_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesHomeWidget extends StatefulWidget {
  const CategoriesHomeWidget({super.key});

  @override
  State<CategoriesHomeWidget> createState() => _CategoriesHomeWidgetState();
}

class _CategoriesHomeWidgetState extends State<CategoriesHomeWidget> {
  @override
  void initState() {
    super.initState();

    homeCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (prev, current) {
        return current is GetCategoriesLoadingState ||
            current is GetCategoriesErrorState ||
            current is GetCategoriesSuccessState;
      },
      builder: (context, state) {
        if (state is GetCategoriesLoadingState) {
          return const CategoriesHomeWidgetLoading();
        }

        if (state is GetCategoriesErrorState) {
          return SizedBox.shrink();
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 16,
            children: [
              horizontalSpace16,
              ...homeCubit.categoriesModel!.categories.asMap().map((index, value) {
                return MapEntry(
                  index,
                  SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(value.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        verticalSpace10,
                        Text(
                          value.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStylesManager.regular16,
                        ),
                      ],
                    ),
                  ),
                );
              }).values,
              horizontalSpace16,
            ],
          ),
        );
      },
    );
  }
}

class CategoriesHomeWidgetLoading extends StatelessWidget {
  const CategoriesHomeWidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
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
                    Skeleton.leaf(
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
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
    );
  }
}








