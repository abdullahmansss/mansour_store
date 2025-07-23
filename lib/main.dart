import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/network/remote/dio_helper.dart';
import 'package:mansour_store/core/theme/theme.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/features/home/presentation/logic/home_cubit.dart';
import 'package:mansour_store/features/home/presentation/logic/home_states.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
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