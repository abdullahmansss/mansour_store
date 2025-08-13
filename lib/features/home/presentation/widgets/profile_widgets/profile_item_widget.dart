import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';

class ProfileItemWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData icon;
  final String text;
  final bool isWithDivider;

  const ProfileItemWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    this.isWithDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
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
                  child: Text(
                    text,
                    style: TextStylesManager.medium16,
                  ),
                ),
                horizontalSpace16,
                Icon(
                  Icons.arrow_forward_ios_rounded,
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
