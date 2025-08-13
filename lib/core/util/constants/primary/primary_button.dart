import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryColor,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: isLoading
            ? CupertinoActivityIndicator(
                color: ColorsManager.whiteColor,
                radius: 12.0,
              )
            : Text(
                text,
                style: TextStylesManager.bold16.copyWith(
                  color: ColorsManager.whiteColor,
                ),
              ),
      ),
    );
  }
}
