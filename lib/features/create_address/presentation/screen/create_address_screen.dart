import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/primary/primary_button.dart';
import 'package:mansour_store/core/util/constants/primary/primary_form.dart';
import 'package:mansour_store/core/util/constants/primary/primary_padding.dart';
import 'package:mansour_store/core/util/constants/routes.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';
import 'package:mansour_store/features/home/presentation/widgets/profile_widgets/profile_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({
    super.key,
  });

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  @override
  void initState() {
    super.initState();
  }

  // key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      body: PrimaryPadding(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PrimaryForm(
                controller: homeCubit.addressController,
                labelText: 'Address',
                keyboardType: TextInputType.streetAddress,
                isEnabled: false,
              ),
              verticalSpace20,
              PrimaryForm(
                controller: homeCubit.firstNameController,
                labelText: 'First Name',
                keyboardType: TextInputType.name,
                validationMessage: 'Please enter your first name',
              ),
              verticalSpace20,
              PrimaryForm(
                controller: homeCubit.lastNameController,
                labelText: 'Last Name',
                keyboardType: TextInputType.name,
                validationMessage: 'Please enter your last name',
              ),
              verticalSpace20,
              PrimaryForm(
                controller: homeCubit.cityController,
                labelText: 'City',
                keyboardType: TextInputType.text,
                validationMessage: 'Please enter your city',
              ),
              verticalSpace20,
              PrimaryForm(
                controller: homeCubit.stateController,
                labelText: 'State',
                keyboardType: TextInputType.text,
                validationMessage: 'Please enter your state',
              ),
              verticalSpace20,
              PrimaryForm(
                controller: homeCubit.countryController,
                labelText: 'Country',
                keyboardType: TextInputType.text,
                validationMessage: 'Please enter your country',
              ),
              verticalSpace20,
              PrimaryForm(
                controller: homeCubit.zipCodeController,
                labelText: 'Zip Code',
                keyboardType: TextInputType.number,
                validationMessage: 'Please enter your zip code',
              ),
              verticalSpace20,
              Expanded(
                child: BlocConsumer<HomeCubit, HomeStates>(
                  listener: (context, state) {
                    if(state is CreateNewAddressSuccessState) {
                      context.popUntil(Routes.addressesScreen);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: homeCubit.isDefaultAddress,
                              checkColor: ColorsManager.primaryColor,
                              fillColor: WidgetStateProperty.all(ColorsManager.whiteColor),
                              // activeColor: ColorsManager.greyColor,
                              side: BorderSide(
                                color: ColorsManager.greyColor,
                                width: 1.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              visualDensity: VisualDensity.compact,
                              onChanged: (value) {
                                homeCubit.isDefaultAddress = value ?? false;
                              },
                            ),
                            horizontalSpace14,
                            Text(
                              'Set as default address',
                              style: TextStylesManager.regular16,
                            ),
                          ],
                        ),
                        Spacer(),
                        PrimaryButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              homeCubit.createNewAddress();
                            }
                          },
                          text: 'Save Address',
                          isLoading: state is CreateNewAddressLoadingState,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
