import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
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
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          homeCubit.selectedCategory = value;
                        },
                        highlightColor: ColorsManager.transparent,
                        splashColor: ColorsManager.transparent,
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: ColorsManager.transparent,
                                  image: DecorationImage(
                                    image: NetworkImage(value.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              verticalSpace10,
                              BlocBuilder<HomeCubit, HomeStates>(
                                buildWhen: (prev, current) {
                                  return current is ChangeSelectedCategoryState;
                                },
                                builder: (context, state) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        value.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStylesManager.regular16.copyWith(
                                          color: homeCubit.selectedCategory!.id == value.id
                                              ? ColorsManager.primaryColor
                                              : null,
                                        ),
                                      ),
                                      verticalSpace4,
                                      Container(
                                        width: 60.0,
                                        height: 4.0,
                                        decoration: BoxDecoration(
                                          color: homeCubit.selectedCategory!.id == value.id
                                              ? ColorsManager.primaryColor
                                              : ColorsManager.transparent,
                                          borderRadius: BorderRadius.circular(2.0),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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








