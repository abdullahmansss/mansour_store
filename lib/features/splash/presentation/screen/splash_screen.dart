import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:mansour_store/core/util/constants/assets_helper.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        if (mounted) {
          context.push(Routes.onBoardingScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Lottie.asset(
            AssetsHelper.splashAnimation,
          ),
        ),
      ),
    );
  }
}
