import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/constants.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';
import 'package:mansour_store/features/home/presentation/widgets/profile_widgets/profile_item_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if(homeCubit.token.isEmpty) {
              return ProfileItemWidget(
              icon: Icons.person,
              text: 'Login',
              onTap: () {
                context.push(Routes.loginScreen);
              },
            );
            }

            return Column(
              children: [
                ProfileItemWidget(
                  icon: Icons.person,
                  text: 'Profile',
                  onTap: () {

                  },
                ),
                ProfileItemWidget(
                  icon: Icons.location_city_outlined,
                  text: 'Addresses',
                  onTap: () {
                    context.push(Routes.addressesScreen);
                  },
                ),
                // ProfileItemWidget(
                //   icon: Icons.shopping_cart_outlined,
                //   text: 'Cart',
                //   onTap: () {
                //
                //   },
                // ),
                ProfileItemWidget(
                  icon: Icons.shopping_bag_outlined,
                  text: 'Orders',
                  onTap: () {
                    context.push(Routes.orderScreen);
                  },
                ),
              ],
            );
          },
        ),
        ProfileItemWidget(
          icon: Icons.language_outlined,
          text: 'Language',
          onTap: () {

          },
        ),
        ProfileItemWidget(
          icon: Icons.notifications_active_outlined,
          text: 'Notifications',
          onTap: () {

          },
        ),
      ],
    );
  }
}
