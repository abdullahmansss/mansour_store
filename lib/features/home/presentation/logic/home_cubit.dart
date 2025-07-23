import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/features/home/presentation/logic/home_states.dart';
import 'package:mansour_store/features/home/presentation/widgets/cart_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/explore_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/profile_widget.dart';
import 'package:mansour_store/main.dart';

HomeCubit homeCubit = HomeCubit.get(navigatorKey.currentContext!);

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  // to access the cubit from anywhere in the app
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDark = false;

  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemeState());
  }

  List<Widget> pages = [
    const HomeWidget(),
    const ExploreWidget(),
    const CartWidget(),
    const ProfileWidget(),
  ];

  List<String> titles = [
    'Mansour Store',
    'Explore New Brands',
    'My Cart',
    'Profile',
  ];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  int _currentBannerIndex = 0;

  int get currentBannerIndex => _currentBannerIndex;

  set currentBannerIndex(int index) {
    _currentBannerIndex = index;
    emit(ChangeBannerIndexState());
  }
}










