import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is ChangeBottomNavBarState;
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.scaffoldBackgroundColor,
          appBar: homeCubit.currentIndex != 1 ? AppBar(
            title: Text(
              homeCubit.titles[homeCubit.currentIndex],
              style: TextStylesManager.medium18,
            ),
            leading: homeCubit.currentIndex == 0 ? IconButton(
              icon: Icon(
                Icons.menu,
                color: ColorsManager.textColor,
              ),
              onPressed: () {
                // Handle menu button press
              },
            ) : null,
            actions: [
              if(homeCubit.currentIndex == 0)
                IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: ColorsManager.textColor,
                ),
                onPressed: () {
                  // Handle notifications button press
                },
              ),
            ],
            centerTitle: true,
            backgroundColor: ColorsManager.scaffoldBackgroundColor,
          ) : null,
          body: homeCubit.pages[homeCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorsManager.whiteColor,
            unselectedItemColor: ColorsManager.greyColor,
            selectedItemColor: ColorsManager.primaryColor,
            selectedLabelStyle: TextStylesManager.medium14.copyWith(
              height: 2.0,
            ),
            unselectedLabelStyle: TextStylesManager.medium14.copyWith(
              height: 2.0,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.home_outlined),
                ),
                label: 'Home',
                activeIcon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.home),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.saved_search),
                ),
                label: 'Explore',
                activeIcon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.search),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
                label: 'Cart',
                activeIcon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.person_outline_rounded),
                ),
                label: 'Profile',
                activeIcon: Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Icon(Icons.person),
                ),
              ),
            ],
            currentIndex: homeCubit.currentIndex,
            onTap: (index) {
              homeCubit.currentIndex = index;
            },
          ),
        );
      },
    );
  }
}
