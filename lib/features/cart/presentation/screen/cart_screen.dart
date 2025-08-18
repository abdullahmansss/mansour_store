import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/primary/primary_button.dart';
import 'package:mansour_store/core/util/constants/primary/primary_padding.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';
import 'package:mansour_store/features/cart/data/cart_item_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  final bool isWithAppBar;

  const CartScreen({
    super.key,
    this.isWithAppBar = true,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: widget.isWithAppBar ? AppBar(
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
      ) : null,
      body: BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (prev, current) {
          return current is GetCartLoadingState
              || current is GetCartSuccessState
              || current is GetCartErrorState;
        },
        builder: (context, state) {
          if(homeCubit.cartModel!.data.items.isEmpty) {
            return Column(
              children: [
                if(!widget.isWithAppBar)
                  verticalSpace24,
                Expanded(
                  child: Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStylesManager.medium16.copyWith(
                        color: ColorsManager.textColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              if(!widget.isWithAppBar)
                verticalSpace24,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  itemBuilder: (context, index) {
                    CartItemModel item = homeCubit.cartModel!.data.items[index];

                    return SizedBox(
                      height: 140,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  item.product.image ?? '',
                                ),
                              ),
                            ),
                          ),
                          horizontalSpace14,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name ?? '',
                                  style: TextStylesManager.bold16,
                                ),
                                verticalSpace8,
                                Text(
                                  '\$${NumberFormat('#,##0').format(double.parse(item.subtotal.toString()))}',
                                  style: TextStylesManager.bold16.copyWith(
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorsManager.textColor.withValues(alpha: 0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if(item.quantity != 1) {
                                            homeCubit.updateCartQuantity(
                                              itemId: item.id,
                                              quantity: item.quantity - 1,
                                            );
                                          } else {
                                            homeCubit.deleteCartItem(
                                              itemId: item.id,
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          size: 18,
                                          color: ColorsManager.textColor,
                                        ),
                                      ),
                                      horizontalSpace8,
                                      Text(
                                        item.quantity.toString(),
                                        style: TextStylesManager.medium16,
                                      ),
                                      horizontalSpace8,
                                      IconButton(
                                        onPressed: () {
                                          homeCubit.updateCartQuantity(
                                            itemId: item.id,
                                            quantity: item.quantity + 1,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          size: 18,
                                          color: ColorsManager.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.shade400,
                    thickness: 0.5,
                  ),
                  itemCount: homeCubit.cartModel!.data.items.length,
                ),
              ),

              PrimaryPadding(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total: \$${NumberFormat('#,##0').format(double.parse(homeCubit.cartModel!.data.total.toString()))}',
                          style: TextStylesManager.bold16.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        verticalSpace16,
                        PrimaryButton(
                          onPressed: () {},
                          isLoading: false,
                          text: 'Checkout',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
