import 'package:flutter/material.dart';
import 'package:mansour_store/features/home/presentation/screen/home_screen.dart';
import 'package:mansour_store/features/on_boarding/presentation/screen/on_boarding_screen.dart';
import 'package:mansour_store/features/product_details/presentation/screen/product_details_screen.dart';
import 'package:mansour_store/features/splash/presentation/screen/splash_screen.dart';

class Routes {
  static const String homeScreen = '/homeScreen';
  static const String splashScreen = '/splashScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String productDetailsScreen = '/productDetailsScreen';

  static Map<String, WidgetBuilder> get routes => {
    splashScreen: (context) => const SplashScreen(),
    onBoardingScreen: (context) => const OnBoardingScreen(),
    homeScreen: (context) => const HomeScreen(),
    productDetailsScreen: (context) => const ProductDetailsScreen(),
  };
}