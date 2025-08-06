import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/core/util/cubit/home_cubit.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/core/util/extensions/context_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
            Icons.arrow_back_ios_new_outlined,
            color: ColorsManager.textColor,
          ),
          onPressed: () {
            context.pop;
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: ColorsManager.textColor,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        backgroundColor: ColorsManager.whiteColor,
      ),
      body: BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (prev, current) {
          return current is GetProductDetailsLoadingState
              || current is GetProductDetailsErrorState
              || current is GetProductDetailsSuccessState;
        },
        builder: (context, state) {
          if (state is GetProductDetailsErrorState) {
            return SizedBox.shrink();
          }

          if(state is GetProductDetailsSuccessState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Image.network(
                        height: 240,
                        fit: BoxFit.cover,
                        homeCubit.productDetails.image ?? '',
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 0.5,
                  ),
                  verticalSpace10,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          homeCubit.productDetails.sku ?? '',
                          style: TextStylesManager.regular16,
                        ),
                        verticalSpace8,
                        Text(
                          homeCubit.productDetails.name ?? '',
                          style: TextStylesManager.medium18,
                        ),
                        verticalSpace8,
                        Text(
                          '\$${NumberFormat('#,##0').format(double.parse(homeCubit.productDetails.effectivePrice ?? '0'))}',
                          style: TextStylesManager.bold16.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        verticalSpace8,
                        Row(
                          children: [
                            Text(
                              'Availability: ',
                              style: TextStylesManager.regular16,
                            ),
                            Text(
                              (homeCubit.productDetails.stockQuantity ?? 0) > 0 ? 'In Stock (${homeCubit.productDetails.stockQuantity})' : 'Out of Stock',
                              style: TextStylesManager.semiBold16.copyWith(
                                color: ColorsManager.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace30,
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                key: const Key('buyNowButton'),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsManager.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Buy Now',
                                  style: TextStylesManager.bold16.copyWith(
                                    color: ColorsManager.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            horizontalSpace16,
                            Expanded(
                              child: ElevatedButton(
                                key: const Key('addToCartButton'),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsManager.lightGreyColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: TextStylesManager.bold16.copyWith(
                                    color: ColorsManager.textColor.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace30,
                        Text(
                          'Description',
                          style: TextStylesManager.bold18,
                        ),
                        verticalSpace10,
                        Text(
                          homeCubit.productDetails.description ?? '',
                          style: TextStylesManager.regular16.copyWith(
                            color: ColorsManager.textColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace80,
                ],
              ),
            );
          }

          return const ProductDetailsScreenLoading();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ProductDetailsScreenLoading extends StatelessWidget {
  const ProductDetailsScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.network(
                height: 240,
                fit: BoxFit.cover,
                'https://store.mansouracademy.com/storage/products/e21b293f-346a-4360-95da-4822a887f062.jpg',
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 0.5,
            ),
            verticalSpace10,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apple',
                    style: TextStylesManager.regular16,
                  ),
                  verticalSpace8,
                  Text(
                    'iPhone 14 Pro Max',
                    style: TextStylesManager.medium18,
                  ),
                  verticalSpace8,
                  Text(
                    '\$1,199.00',
                    style: TextStylesManager.bold16.copyWith(
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  verticalSpace8,
                  Row(
                    children: [
                      Text(
                        'Availability: ',
                        style: TextStylesManager.regular16,
                      ),
                      Text(
                        'In Stock (50)',
                        style: TextStylesManager.semiBold16.copyWith(
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace30,
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          key: const Key('buyNowButton'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Buy Now',
                            style: TextStylesManager.bold16.copyWith(
                              color: ColorsManager.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace16,
                      Expanded(
                        child: ElevatedButton(
                          key: const Key('addToCartButton'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.lightGreyColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStylesManager.bold16.copyWith(
                              color: ColorsManager.textColor.withValues(
                                alpha: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace30,
                  Text(
                    'Description',
                    style: TextStylesManager.bold18,
                  ),
                  verticalSpace10,
                  Text(
                    'The iPhone 14 Pro Max is the latest flagship smartphone from Apple, featuring a stunning 6.7-inch Super Retina XDR display, A16 Bionic chip for lightning-fast performance, and an advanced camera system with ProRAW and ProRes video capabilities. It offers up to 1TB of storage, 5G connectivity, and a sleek design with Ceramic Shield front cover for enhanced durability.',
                    style: TextStylesManager.regular16.copyWith(
                      color: ColorsManager.textColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

