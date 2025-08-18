import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mansour_store/core/models/base_model.dart';
import 'package:mansour_store/core/models/product_model.dart';
import 'package:mansour_store/core/network/remote/api_endpoints.dart';
import 'package:mansour_store/core/network/remote/dio_helper.dart';
import 'package:mansour_store/features/addresses/data/addresses_model.dart';
import 'package:mansour_store/features/cart/data/cart_model.dart';
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
import 'package:mansour_store/features/login/data/login_model.dart';
import 'package:mansour_store/features/product_details/data/product_details_model.dart';
import 'package:mansour_store/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      token: token,
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
      token: token,
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
      token: token,
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
      token: token,
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

        bool a = cartModel!.data.items.any((item) => item.productId == productDetails.id);

        debugPrint(
          'Product details fetched successfully => ${a}',
        );

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
      token: token,
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

  LoginModel? loginModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    loginModel = null;

    emit(LoginUserLoadingState());

    final result = await DioHelper.post(
      path: loginEndpoint,
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },
      token: token,
    );

    result.fold(
      (l) {
        debugPrint('LoginUserErrorState => $l');
        emit(
          LoginUserErrorState(
            error: l,
          ),
        );
      },
      (r) {
        loginModel = LoginModel.fromMap(r);
        token = loginModel!.token;

        saveTokenToSharedPreferences(
          token: _token,
        );

        debugPrint(
          'LoginUserSuccessState => ${loginModel!.token} logged in successfully',
        );

        emit(
          LoginUserSuccessState(),
        );
      },
    );
  }

  void saveTokenToSharedPreferences({
    required String token,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void loadTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    debugPrint('Token loaded from SharedPreferences => $_token');

    getUserCart();

    emit(TokenChangedState());
  }

  String _token = '';

  String get token => _token;

  set token(String value) {
    _token = value;
    emit(TokenChangedState());
  }

  GoogleMapController? _mapsController;

  GoogleMapController? get mapsController => _mapsController;

  set mapsController(GoogleMapController? value) {
    _mapsController = value;
    emit(MapControllerChangedState());
  }

  Marker _marker = Marker(
    markerId: MarkerId('current_location'),
    position: LatLng(30.163656, 31.625738),
    draggable: true,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    onDragStart: (LatLng position) {
      debugPrint('Marker dragged to: ${position.latitude}, ${position.longitude}');
    },
    infoWindow: InfoWindow(title: 'Current Location'),
  );

  Marker get marker => _marker;

  set marker(Marker value) {
    _marker = value;
    emit(ChangeMarkerState());
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  void getAddress() async {
    emit(GetAddressLoadingState());

    List<Placemark> placemarks = await placemarkFromCoordinates(
      marker.position.latitude,
      marker.position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address = '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      addressController.text = address;
      debugPrint('Address fetched: $address');
    } else {
      addressController.text = 'No address found';
    }

    emit(GetAddressSuccessState());
  }

  bool _isDefaultAddress = false;

  bool get isDefaultAddress => _isDefaultAddress;

  set isDefaultAddress(bool value) {
    _isDefaultAddress = value;
    emit(ChangeIsDefaultAddressState());
  }

  BaseModel? createAddressModel;

  void createNewAddress() async {
    createAddressModel = null;

    emit(CreateNewAddressLoadingState());

    final result = await DioHelper.post(
      path: addressesEndpoint,
      data: {
        'type': 'shipping',
        'address_line_1': addressController.text,
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'city': cityController.text,
        'state': stateController.text,
        'country': countryController.text,
        'postal_code': zipCodeController.text,
        'is_default': isDefaultAddress,
      },
      token: token,
    );

    result.fold(
      (l) {
        debugPrint('CreateNewAddressErrorState => $l');
        emit(
          CreateNewAddressErrorState(
            error: l,
          ),
        );
      },
      (r) {
        createAddressModel = BaseModel.fromMap(r);

        getAddresses();

        addressController.clear();
        firstNameController.clear();
        lastNameController.clear();
        cityController.clear();
        stateController.clear();
        countryController.clear();
        zipCodeController.clear();
        isDefaultAddress = false;

        emit(
          CreateNewAddressSuccessState(),
        );
      },
    );
  }

  AddressesModel? addressesModel;

  void getAddresses() async {
    addressesModel = null;

    emit(GetAllAddressesLoadingState());

    final result = await DioHelper.get(
      path: addressesEndpoint,
      token: token,
    );

    result.fold(
      (l) {
        emit(
          GetAllAddressesErrorState(
            error: l,
          ),
        );
      },
      (r) {
        addressesModel = AddressesModel.fromMap(r);

        emit(
          GetAllAddressesSuccessState(),
        );
      },
    );
  }

  BaseModel? defaultAddressModel;

  void setDefaultAddress({
    required String addressId,
  }) async {
    defaultAddressModel = null;

    emit(GetAllAddressesLoadingState());

    final result = await DioHelper.patch(
      path: setDefaultAddressEndpoint.replaceAll('ADDRESS_ID', addressId),
      token: token,
    );

    result.fold(
      (l) {
        emit(
          SetDefaultAddressErrorState(
            error: l,
          ),
        );
      },
      (r) {
        defaultAddressModel = BaseModel.fromMap(r);

        getAddresses();

        emit(
          SetDefaultAddressSuccessState(),
        );
      },
    );
  }

  CartModel? cartModel;

  void getUserCart() async {
    if (token.isEmpty) {
      debugPrint('Token is empty, cannot fetch cart');
      return;
    }

    emit(GetCartLoadingState());

    final result = await DioHelper.get(
      path: getCartEndpoint,
      token: token,
    );

    result.fold(
      (l) {
        emit(
          GetCartErrorState(
            error: l,
          ),
        );
      },
      (r) {
        cartModel = CartModel.fromMap(r);

        emit(
          GetCartSuccessState(),
        );
      },
    );
  }

  BaseModel? addItemToCartModel;

  void addItemToCart() async {
    addItemToCartModel = null;

    emit(AddItemToCartLoadingState());

    final result = await DioHelper.post(
      path: getCartEndpoint,
      token: token,
      data: {
        'product_id': productDetails.id,
        'quantity': 1, // Default quantity is 1
      },
    );

    result.fold(
      (l) {
        emit(
          AddItemToCartErrorState(
            error: l,
          ),
        );
      },
      (r) {
        addItemToCartModel = BaseModel.fromMap(r);

        getUserCart();

        // emit(
        //   AddItemToCartSuccessState(),
        // );
      },
    );
  }

  BaseModel? updateCartQuantityModel;

  void updateCartQuantity({
    required int itemId,
    required int quantity,
  }) async {
    updateCartQuantityModel = null;

    emit(AddItemToCartLoadingState());

    final result = await DioHelper.put(
      path: updateCartQuantityEndpoint.replaceAll('ITEM_ID', itemId.toString()),
      token: token,
      data: {
        'quantity': quantity,
      },
    );

    result.fold(
      (l) {
        emit(
          AddItemToCartErrorState(
            error: l,
          ),
        );
      },
      (r) {
        updateCartQuantityModel = BaseModel.fromMap(r);

        getUserCart();
      },
    );
  }

  BaseModel? deleteCartItemModel;

  void deleteCartItem({
    required int itemId,
  }) async {
    deleteCartItemModel = null;

    emit(DeleteCartItemLoadingState());

    final result = await DioHelper.delete(
      path: updateCartQuantityEndpoint.replaceAll('ITEM_ID', itemId.toString()),
      token: token,
    );

    result.fold(
          (l) {
        emit(
          DeleteCartItemErrorState(
            error: l,
          ),
        );
      },
          (r) {
        deleteCartItemModel = BaseModel.fromMap(r);

        getUserCart();
      },
    );
  }
}
