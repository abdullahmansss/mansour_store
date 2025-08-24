import 'package:flutter/material.dart';
import 'package:mansour_store/features/addresses/presentation/screen/addresses_screen.dart';
import 'package:mansour_store/features/cart/presentation/screen/cart_screen.dart';
import 'package:mansour_store/features/create_address/presentation/screen/create_address_screen.dart';
import 'package:mansour_store/features/home/presentation/screen/home_screen.dart';
import 'package:mansour_store/features/login/presentation/screen/login_screen.dart';
import 'package:mansour_store/features/map/presentation/screen/map_screen.dart';
import 'package:mansour_store/features/on_boarding/presentation/screen/on_boarding_screen.dart';
import 'package:mansour_store/features/order_created/presentation/screen/order_created_screen.dart';
import 'package:mansour_store/features/orders/presentation/screen/orders_screen.dart';
import 'package:mansour_store/features/product_details/presentation/screen/product_details_screen.dart';
import 'package:mansour_store/features/splash/presentation/screen/splash_screen.dart';

class Routes {
  static const String homeScreen = '/homeScreen';
  static const String splashScreen = '/splashScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String loginScreen = '/loginScreen';
  static const String addressesScreen = '/addressesScreen';
  static const String mapScreen = '/mapScreen';
  static const String createAddressScreen = '/createAddressScreen';
  static const String cartScreen = '/cartScreen';
  static const String orderCreatedScreen = '/orderCreatedScreen';
  static const String orderScreen = '/orderScreen';

  static Map<String, WidgetBuilder> get routes => {
    splashScreen: (context) => const SplashScreen(),
    onBoardingScreen: (context) => const OnBoardingScreen(),
    homeScreen: (context) => const HomeScreen(),
    productDetailsScreen: (context) => const ProductDetailsScreen(),
    loginScreen: (context) => const LoginScreen(),
    addressesScreen: (context) => const AddressesScreen(),
    mapScreen: (context) => const MapScreen(),
    createAddressScreen: (context) => const CreateAddressScreen(),
    cartScreen: (context) => const CartScreen(),
    orderCreatedScreen: (context) => const OderCreatedScreen(),
    orderScreen: (context) => const OrdersScreen(),
  };
}