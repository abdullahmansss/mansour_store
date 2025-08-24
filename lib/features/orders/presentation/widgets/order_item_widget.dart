import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/primary/primary_menu.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/features/orders/data/order_model.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel? orderModel;

  OrderItemWidget({
    super.key,
    this.orderModel,
  });

  final GlobalKey moreKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorsManager.lightGreyColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                orderModel?.orderNumber ?? 'Order #12345',
                style: TextStylesManager.medium16,
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  orderModel?.status ?? 'processing',
                  style: TextStylesManager.regular12.copyWith(
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace8,
          Row(
            children: [
              Text(
                'Total Price: \$${orderModel?.totalAmount ?? '00.00'}',
                style: TextStylesManager.regular14,
              ),
              const Spacer(),
              Text(
                'Items: ${orderModel?.totalItems ?? '0'}',
                style: TextStylesManager.regular14,
              ),
            ],
          ),
          verticalSpace8,
          // Format date using intl package to be date and time
          Text(
            'Date: ${DateFormat.MMMMEEEEd().format(DateTime.parse(orderModel?.createdAt ?? DateTime.now().toString()))}',
            style: TextStylesManager.regular14,
          ),
        ],
      ),
    );
  }
}
