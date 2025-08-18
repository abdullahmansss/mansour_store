import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
    this.backgroundColor = ColorsManager.primaryColor,
    this.textColor = ColorsManager.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: isLoading
            ? CupertinoActivityIndicator(
                color: textColor,
                radius: 12.0,
              )
            : Text(
                text,
                style: TextStylesManager.bold16.copyWith(
                  color: textColor,
                ),
              ),
      ),
    );
  }
}
