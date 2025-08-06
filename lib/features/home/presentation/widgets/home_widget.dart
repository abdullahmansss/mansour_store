import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widgets/banners_home_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widgets/categories_home_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widgets/products_home_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const BannersHomeWidget(),
          verticalSpace30,
          const CategoriesHomeWidget(),
          BlocBuilder<HomeCubit, HomeStates>(
            buildWhen: (prev, current) {
              return current is GetCategoriesLoadingState
                  || current is GetCategoriesErrorState
                  || current is GetCategoriesSuccessState;
            },
            builder: (context, state) {
              if (state is GetCategoriesLoadingState) {
                return const ProductsHomeWidgetLoading();
              }

              if (state is GetCategoriesErrorState) {
                return SizedBox.shrink();
              }

              return ProductsHomeWidget();
            },
          ),
        ],
      ),
    );
  }
}
