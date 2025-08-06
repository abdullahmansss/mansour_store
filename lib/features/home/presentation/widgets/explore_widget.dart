import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/features/home/data/brand_model.dart';

import '../../data/category_model.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({super.key});

  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    homeCubit.getBrands();

    if (mounted) {
      _tabController = TabController(
        length: 2,
        vsync: this,
      );

    } else {
      _tabController?.dispose();
    }
  }

  TabController? _tabController;

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Text(
                'Categories',
                style: TextStylesManager.bold16.copyWith(
                  height: 3.0,
                  color: ColorsManager.textColor.withValues(
                    alpha: 0.8,
                  ),
                ),
              ),
              Text(
                'Brands',
                style: TextStylesManager.bold16.copyWith(
                  height: 3.0,
                  color: ColorsManager.textColor.withValues(
                    alpha: 0.8,
                  ),
                ),
              ),
            ],
            indicatorColor: ColorsManager.primaryColor,
            overlayColor: WidgetStateProperty.all<Color>(
              ColorsManager.greyColor.withValues(
                alpha: 0.2,
              ),
            ),
            dividerColor: ColorsManager.transparent,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.separated(
                  itemBuilder: (context, index) {
                    CategoryModel category = homeCubit.categoriesModel!.categories[index];

                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.network(
                            width: 60.0,
                            height: 60.0,
                            category.image,
                          ),
                          horizontalSpace16,
                          Text(
                            category.name,
                            style: TextStylesManager.medium16,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.shade400,
                    thickness: 0.5,
                  ),
                  itemCount: homeCubit.categoriesModel!.categories.length,
                ),
                BlocBuilder<HomeCubit, HomeStates>(
                  buildWhen: (prev, current) {
                    return current is GetBrandsLoadingState
                        || current is GetBrandsErrorState
                        || current is GetBrandsSuccessState;
                  },
                  builder: (context, state) {
                    if (state is GetBrandsLoadingState) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: ColorsManager.greyColor,
                          radius: 20.0,
                        ),
                      );
                    }

                    if (state is GetBrandsErrorState) {
                      return SizedBox.shrink();
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        BrandModel brand = homeCubit.brandsModel!.brands[index];

                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image.network(
                                width: 60.0,
                                height: 60.0,
                                brand.logo,
                              ),
                              horizontalSpace16,
                              Text(
                                brand.name,
                                style: TextStylesManager.medium16,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade400,
                        thickness: 0.5,
                      ),
                      itemCount: homeCubit.categoriesModel!.categories.length,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
