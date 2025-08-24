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
import 'package:mansour_store/features/orders/data/order_model.dart';
import 'package:mansour_store/features/orders/presentation/widgets/order_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();

    homeCubit.getOrders();
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
          Expanded(
            child: BlocBuilder<HomeCubit, HomeStates>(
              buildWhen: (prev, current) {
                return current is GetOrdersLoadingState
                    || current is GetOrdersSuccessState
                    || current is GetOrdersErrorState;
              },
              builder: (context, state) {
                if (state is GetOrdersLoadingState) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      separatorBuilder: (context, index) => verticalSpace16,
                      itemBuilder: (context, index) {
                        return OrderItemWidget();
                      },
                      itemCount: 20,
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  separatorBuilder: (context, index) => verticalSpace16,
                  itemBuilder: (context, index) {
                    OrderModel orderModel = homeCubit.ordersModel!.data[index];

                    return OrderItemWidget(
                      orderModel: orderModel,
                    );
                  },
                  itemCount: homeCubit.ordersModel!.data.length,
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
