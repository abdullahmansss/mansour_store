import 'package:flutter/material.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';

class PrimaryForm extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isEnabled;
  final String labelText;
  final bool isValidationEnabled;
  final String? validationMessage;
  final String Function(String)? additionalValidation;

  const PrimaryForm({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    required this.labelText,
    this.validationMessage,
    this.isValidationEnabled = true,
    this.additionalValidation,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: ColorsManager.primaryColor,
      style: TextStylesManager.semiBold16,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (!isValidationEnabled) {
          return null; // Skip validation if not enabled
        }

        if (value == null || value.isEmpty) {
          return validationMessage;
        }

        if (additionalValidation != null) {
          additionalValidation!.call(value);
        }

        return null;
      },
      enabled: isEnabled,
      // readOnly: !isEnabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStylesManager.medium16,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: ColorsManager.lightGreyColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: ColorsManager.lightGreyColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: ColorsManager.primaryColor,
          ),
        ),
      ),
    );
  }
}
