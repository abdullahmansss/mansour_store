import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mansour_store/core/theme/colors.dart';
import 'package:mansour_store/core/theme/text_styles.dart';
import 'package:mansour_store/core/util/constants/spacing.dart';
import 'package:mansour_store/features/home/data/product_model.dart';
import 'package:mansour_store/features/home/presentation/logic/home_cubit.dart';
import 'package:mansour_store/features/home/presentation/logic/home_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsHomeWidget extends StatefulWidget {
  const ProductsHomeWidget({super.key});

  @override
  State<ProductsHomeWidget> createState() => _ProductsHomeWidgetState();
}

class _ProductsHomeWidgetState extends State<ProductsHomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (prev, current) {
        return current is GetProductsLoadingState
            || current is GetProductsErrorState
            || current is GetProductsSuccessState;
      },
      builder: (context, state) {
        if (state is GetProductsErrorState) {
          return SizedBox.shrink();
        }

        if (state is GetProductsSuccessState && homeCubit.productsModel!.products.isEmpty) {
          return Center(
            child: Text(
              'No products available',
              style: TextStylesManager.regular14.copyWith(
                color: ColorsManager.greyColor,
              ),
            ),
          );
        }

        if(state is GetProductsSuccessState) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 30.0,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              ProductModel product = homeCubit.productsModel!.products[index];

              return Container(
                decoration: BoxDecoration(
                  color: ColorsManager.whiteColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.blackColor.withValues(
                        alpha: 0.1,
                      ),
                      blurRadius: 10.0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              width: double.infinity,
                              product.image ?? '',
                            ),
                          ),
                          verticalSpace16,
                          Text(
                            product.name ?? 'No Name Found',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStylesManager.medium14,
                          ),
                          verticalSpace16,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${NumberFormat('#,##0').format(double.parse(product.effectivePrice ?? '0'))}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStylesManager.bold16.copyWith(
                                      color: ColorsManager.blackColor,
                                    ),
                                  ),
                                  verticalSpace4,
                                  Text(
                                    (product.isOnSale ?? false) ? '\$${NumberFormat('#,##0').format(double.parse(product.price ?? '0'))}' : '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStylesManager.regular12.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  verticalSpace4,
                                  if ((product.stockQuantity ?? 0) > 0)
                                    Text(
                                      'In Stock',
                                      style: TextStylesManager.regular14.copyWith(
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                                  if ((product.stockQuantity ?? 0) == 0)
                                    Text(
                                      'Out of Stock',
                                      style: TextStylesManager.regular14.copyWith(
                                        color: ColorsManager.errorColor,
                                      ),
                                    ),
                                ],
                              ),
                              Spacer(),
                              FloatingActionButton(
                                elevation: 0.0,
                                mini: true,
                                onPressed: () {},
                                backgroundColor: ColorsManager.primaryColor,
                                child: Icon(
                                  Icons.add,
                                  color: ColorsManager.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (product.isOnSale ?? false)
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          'On Sale',
                          style: TextStylesManager.regular12.copyWith(
                            color: ColorsManager.whiteColor,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            itemCount: homeCubit.productsModel!.products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        }

        return const ProductsHomeWidgetLoading();
      },
    );
  }
}

class ProductsHomeWidgetLoading extends StatelessWidget {
  const ProductsHomeWidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 30.0,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 30.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: ColorsManager.whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.blackColor.withValues(
                    alpha: 0.1,
                  ),
                  blurRadius: 10.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorsManager.whiteColor,
                    height: 100.0,
                    width: double.infinity,
                  ),
                  verticalSpace16,
                  Text(
                    'Apple 2024 MacBook Pro Laptop with M4 Max, 16‑core CPU, 40‑core GPU: Built for Apple Intelligence, 16.2-inch Liquid Retina XDR Display, 48GB Unified Memory, 1TB SSD Storage; Space Black',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStylesManager.medium14,
                  ),
                  verticalSpace16,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$2,499',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStylesManager.bold16.copyWith(
                              color: ColorsManager.blackColor,
                            ),
                          ),
                          verticalSpace4,
                          Text(
                            '\$3,000',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStylesManager.regular12.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          verticalSpace4,
                          Text(
                            'In Stock',
                            style: TextStylesManager.regular14.copyWith(
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      FloatingActionButton(
                        elevation: 0.0,
                        mini: true,
                        onPressed: () {},
                        backgroundColor: ColorsManager.primaryColor,
                        child: Icon(
                          Icons.add,
                          color: ColorsManager.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
