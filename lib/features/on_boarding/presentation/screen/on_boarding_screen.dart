import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/assets_helper.dart';
import 'package:mansour_store/core/util/constants/primary/primary_padding.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  int currentPageIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  List<OnBoardingItemModel> onBoardingItems = [
    OnBoardingItemModel(
      image: AssetsHelper.onBoardingOne,
      title: 'Welcome to Mansour Store',
      description: 'Discover the best products at unbeatable prices',
    ),
    OnBoardingItemModel(
      image: AssetsHelper.onBoardingTwo,
      title: 'Quality Products',
      description: 'We offer a wide range of high-quality products',
    ),
    OnBoardingItemModel(
      image: AssetsHelper.onBoardingThree,
      title: 'Fast Delivery',
      description: 'Get your orders delivered quickly and safely',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackgroundColor,
      body: SafeArea(
        child: PrimaryPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.blackColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'English',
                    style: TextStylesManager.semiBold14,
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  children: [
                    ...onBoardingItems.asMap().map((index, item) {
                      return MapEntry(
                        index,
                        Image(
                          height: MediaQuery.of(context).size.height * 0.3,
                          image: AssetImage(
                            item.image,
                          ),
                        ),
                      );
                    }).values,
                  ],
                ),
              ),
              verticalSpace40,
              Text(
                onBoardingItems[currentPageIndex].title,
                style: TextStylesManager.bold20,
              ),
              verticalSpace20,
              Text(
                onBoardingItems[currentPageIndex].description,
                style: TextStylesManager.medium18,
              ),
              Spacer(),
              Row(
                children: [
                  ...onBoardingItems.asMap().map((index, item) {
                    return MapEntry(
                      index,
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: Container(
                          width: index == currentPageIndex ? 30.0 : 10,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: index == currentPageIndex ? ColorsManager.primaryColor : ColorsManager.blackColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    );
                  }).values,
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      if(currentPageIndex < onBoardingItems.length - 1) {
                        setState(() {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          currentPageIndex++;
                        });
                      } else {
                        context.push(Routes.homeScreen);
                      }
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: ColorsManager.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: ColorsManager.whiteColor,
                    ),
                  ),
                ],
              ),
              verticalSpace40,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class OnBoardingItemModel {
  final String image;
  final String title;
  final String description;

  OnBoardingItemModel({
    required this.image,
    required this.title,
    required this.description,
  });
}
