import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/primary/primary_padding.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';
import 'package:mansour_store/features/addresses/data/address_model.dart';
import 'package:mansour_store/features/addresses/presentation/widgets/address_item_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/profile_widgets/profile_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({
    super.key,
  });

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    super.initState();

    homeCubit.getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorsManager.textColor,
          ),
          onPressed: () {
            context.pop;
          },
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.whiteColor,
      ),
      body: Column(
        children: [
          ProfileItemWidget(
            onTap: () {
              context.push(Routes.mapScreen);
            },
            icon: Icons.add,
            text: 'Add New Address',
          ),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeStates>(
              buildWhen: (prev, current) {
                return current is GetAllAddressesLoadingState
                    || current is GetAllAddressesSuccessState
                    || current is GetAllAddressesErrorState;
              },
              builder: (context, state) {
                if(state is GetAllAddressesLoadingState) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ProfileItemWidget(
                          onTap: () {

                          },
                          icon: Icons.location_city,
                          text: 'Loading...',
                        );
                      },
                      itemCount: 20,
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    AddressModel address = homeCubit.addressesModel!.addresses[index];

                    return AddressItemWidget(
                      onTap: () {

                      },
                      addressId: address.id.toString(),
                      icon: Icons.location_city,
                      text: address.fullAddress,
                      isDefault: address.isDefault,
                    );
                  },
                  itemCount: homeCubit.addressesModel!.addresses.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
