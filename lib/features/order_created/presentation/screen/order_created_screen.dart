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

class OderCreatedScreen extends StatefulWidget {
  const OderCreatedScreen({
    super.key,
  });

  @override
  State<OderCreatedScreen> createState() => _OderCreatedScreenState();
}

class _OderCreatedScreenState extends State<OderCreatedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: ColorsManager.textColor,
          ),
          onPressed: () {
            context.popUntil(Routes.homeScreen);
          },
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.whiteColor,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            verticalSpace100,
            Icon(
              Icons.check_circle,
              color: ColorsManager.primaryColor,
              size: 200,
            ),
            Text(
              'Order Created!',
              style: TextStylesManager.bold20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
