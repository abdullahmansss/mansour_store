import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/primary/primary_menu.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';

class AddressItemWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData icon;
  final String text;
  final bool isWithDivider;
  final bool isDefault;
  final String addressId;

  AddressItemWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.addressId,
    this.isWithDivider = true,
    this.isDefault = false,
  });

  final GlobalKey moreKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            showPrimaryMenu(
              context: context,
              key: moreKey,
              isBottomHeight: 30.0,
              items: [
                if(!isDefault)
                  PopupMenuItem(
                  onTap: () {
                    homeCubit.setDefaultAddress(
                      addressId: addressId,
                    );
                  },
                  child: Text(
                    'Set as Default',
                    style: TextStylesManager.regular14,
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    // Handle delete action
                  },
                  child: Text(
                    'Edit',
                    style: TextStylesManager.regular14,
                  ),
                ),
              ],
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: ColorsManager.textColor,
                ),
                horizontalSpace16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStylesManager.medium16,
                      ),
                      if(isDefault) verticalSpace12,
                      if(isDefault)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Text(
                            'Default Address',
                            style: TextStylesManager.regular14.copyWith(
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                horizontalSpace16,
                Icon(
                  key: moreKey,
                  Icons.more_vert_outlined,
                  size: 18,
                  color: ColorsManager.textColor,
                ),
              ],
            ),
          ),
        ),
        if (isWithDivider)
          Divider(
            color: Colors.grey.shade400,
            height: 0,
            thickness: 0.5,
          ),
      ],
    );
  }
}
