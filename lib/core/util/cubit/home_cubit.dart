import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_store/core/models/product_model.dart';
import 'package:mansour_store/core/network/remote/api_endpoints.dart';
import 'package:mansour_store/core/network/remote/dio_helper.dart';
import 'package:mansour_store/features/home/data/banners_model.dart';
import 'package:mansour_store/features/home/data/brands_model.dart';
import 'package:mansour_store/features/home/data/categories_model.dart';
import 'package:mansour_store/features/home/data/category_model.dart';
import 'package:mansour_store/features/home/data/products_model.dart';
import 'package:mansour_store/core/util/cubit/home_states.dart';
import 'package:mansour_store/features/home/presentation/widgets/cart_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/explore_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/home_widget.dart';
import 'package:mansour_store/features/home/presentation/widgets/profile_widget.dart';
import 'package:mansour_store/features/product_details/data/product_details_model.dart';
import 'package:mansour_store/main.dart';

HomeCubit homeCubit = HomeCubit.get(navigatorKey.currentContext!);

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  // to access the cubit from anywhere in the app
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDark = false;

  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemeState());
  }

  List<Widget> pages = [
    const HomeWidget(),
    const ExploreWidget(),
    const CartWidget(),
    const ProfileWidget(),
  ];

  List<String> titles = [
    'Mansour Store',
    'Explore New Brands',
    'My Cart',
    'Profile',
  ];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  int _currentBannerIndex = 0;

  int get currentBannerIndex => _currentBannerIndex;

  set currentBannerIndex(int index) {
    _currentBannerIndex = index;
    emit(ChangeBannerIndexState());
  }

  CategoriesModel? categoriesModel;

  void getCategories() async {
    if (categoriesModel != null) {
      return;
    }

    categoriesModel = null;

    emit(GetCategoriesLoadingState());

    final result = await DioHelper.get(
      path: categoriesEndpoint,
    );

    result.fold(
      (l) {
        emit(
          GetCategoriesErrorState(
            error: l,
          ),
        );
      },
      (r) {
        categoriesModel = CategoriesModel.fromMap(r);

        selectedCategory = categoriesModel!.categories.isNotEmpty ? categoriesModel!.categories.first : null;

        debugPrint(
          'Categories fetched successfully => ${categoriesModel!.categories.length} categories',
        );

        emit(
          GetCategoriesSuccessState(),
        );
      },
    );
  }

  CategoryModel? _selectedCategory;

  CategoryModel? get selectedCategory => _selectedCategory;

  set selectedCategory(CategoryModel? category) {
    if (_selectedCategory == category) return;

    _selectedCategory = category;

    if (_selectedCategory != null) {
      ProductsModel? cachedProducts = getProductsByCategoryId(_selectedCategory!.id);

      if (cachedProducts != null) {
        setCachedProductsBasedOnCategory(
          products: cachedProducts,
        );
      } else {
        getProducts();
      }
    }

    emit(ChangeSelectedCategoryState());
  }

  BannersModel? bannersModel;

  void getBanners() async {
    if (bannersModel != null) {
      return;
    }

    bannersModel = null;

    emit(GetBannersLoadingState());

    final result = await DioHelper.get(
      path: bannersEndpoint,
    );

    result.fold(
      (l) {
        debugPrint('GetBannersErrorState => $l');
        emit(
          GetBannersErrorState(
            error: l,
          ),
        );
      },
      (r) {
        bannersModel = BannersModel.fromMap(r);

        debugPrint(
          'banners fetched successfully => ${bannersModel!.banners.length} banners',
        );

        emit(
          GetBannersSuccessState(),
        );
      },
    );
  }

  ProductsModel? productsModel;

  void getProducts() async {
    productsModel = null;

    emit(GetProductsLoadingState());

    final result = await DioHelper.get(
      path: '$productsEndpoint${_selectedCategory!.id}',
    );

    result.fold(
      (l) {
        debugPrint('GetProductsErrorState => $l');
        emit(
          GetProductsErrorState(
            error: l,
          ),
        );
      },
      (r) {
        productsModel = ProductsModel.fromMap(r);

        cacheProducts(
          categoryId: _selectedCategory!.id,
          products: productsModel!,
        );

        debugPrint(
          'productsModel fetched successfully => ${productsModel!.products.length} products',
        );

        emit(
          GetProductsSuccessState(),
        );
      },
    );
  }

  ProductDetailsModel? productDetailsModel;

  ProductModel get productDetails => productDetailsModel!.product;

  void getProductDetails({
    required int productId,
  }) async {
    productDetailsModel = null;

    debugPrint('Fetching product details for product ID => $productId');

    emit(GetProductDetailsLoadingState());

    final result = await DioHelper.get(
      path: '$productDetailsEndpoint$productId',
    );

    result.fold(
      (l) {
        debugPrint('GetProductDetailsErrorState => $l');
        emit(
          GetProductDetailsErrorState(
            error: l,
          ),
        );
      },
      (r) {
        productDetailsModel = ProductDetailsModel.fromMap(r);

        emit(
          GetProductDetailsSuccessState(),
        );
      },
    );
  }

  BrandsModel? brandsModel;

  void getBrands() async {
    brandsModel = null;

    emit(GetBrandsLoadingState());

    final result = await DioHelper.get(
      path: brandsEndpoint,
    );

    result.fold(
      (l) {
        debugPrint('GetBrandsErrorState => $l');
        emit(
          GetBrandsErrorState(
            error: l,
          ),
        );
      },
      (r) {
        brandsModel = BrandsModel.fromMap(r);

        emit(
          GetBrandsSuccessState(),
        );
      },
    );
  }

  Map<int, ProductsModel> productsCache = {};

  ProductsModel? getProductsByCategoryId(int categoryId) {
    if (productsCache.containsKey(categoryId)) {
      return productsCache[categoryId];
    } else {
      return null;
    }
  }

  void cacheProducts({
    required int categoryId,
    required ProductsModel products,
  }) {
    productsCache[categoryId] = products;
  }

  void setCachedProductsBasedOnCategory({
    required ProductsModel products,
  }) {
    productsModel = null;
    productsModel = products;

    emit(
      GetProductsSuccessState(),
    );
  }
}
