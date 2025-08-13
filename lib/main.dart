import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/network/remote/dio_helper.dart';
import 'package:mansour_store/core/theme/theme.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';

import 'core/util/constants/bloc_observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadTokenFromSharedPreferences(),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Mansour Store',
            themeMode: HomeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemesManager.lightTheme,
            darkTheme: ThemesManager.darkTheme,
            // home: HomeScreen(),
            routes: Routes.routes,
            initialRoute: Routes.homeScreen,
          );
        },
      ),
    );
  }
}