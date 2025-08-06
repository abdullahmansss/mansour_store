import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannersHomeWidget extends StatefulWidget {
  const BannersHomeWidget({super.key});

  @override
  State<BannersHomeWidget> createState() => _BannersHomeWidgetState();
}

class _BannersHomeWidgetState extends State<BannersHomeWidget> {
  @override
  void initState() {
    super.initState();

    homeCubit.getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (prev, current) {
        return current is GetBannersLoadingState ||
            current is GetBannersErrorState ||
            current is GetBannersSuccessState;
      },
      builder: (context, state) {
        if (state is GetBannersLoadingState) {
          return const BannersHomeWidgetLoading();
        }

        if (state is GetBannersErrorState) {
          return SizedBox.shrink();
        }

        debugPrint('inside BannersHomeWidget build method =>');
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
              items: homeCubit.bannersModel!.banners.map((i) {
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
                            image: DecorationImage(
                              image: NetworkImage(i.image),
                              fit: BoxFit.cover,
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
                  children: homeCubit.bannersModel!.banners
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
      },
    );
  }
}

class BannersHomeWidgetLoading extends StatelessWidget {
  const BannersHomeWidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
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
                  return Skeleton.leaf(
                    child: Padding(
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
                    ),
                  );
                },
              );
            }).toList(),
          ),
          verticalSpace12,
          Skeleton.leaf(
            child: Row(
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
            ),
          ),
        ],
      ),
    );
  }
}
