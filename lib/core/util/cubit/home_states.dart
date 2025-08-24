abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class CounterOneState extends HomeStates {}

class CounterTwoState extends HomeStates {}

class ResetState extends HomeStates {}

class FetchUserState extends HomeStates {}

class ChangeThemeState extends HomeStates {}

class GetTopHeadlinesLoadingState extends HomeStates {}

class GetTopHeadlinesErrorState extends HomeStates {
  final String error;

  GetTopHeadlinesErrorState({
    required this.error,
  });
}

class GetTopHeadlinesSuccessState extends HomeStates {}

class SetDefaultAddressLoadingState extends HomeStates {}

class SetDefaultAddressErrorState extends HomeStates {
  final String error;

  SetDefaultAddressErrorState({
    required this.error,
  });
}

class SetDefaultAddressSuccessState extends HomeStates {}

class GetOrdersLoadingState extends HomeStates {}

class GetOrdersErrorState extends HomeStates {
  final String error;

  GetOrdersErrorState({
    required this.error,
  });
}

class GetOrdersSuccessState extends HomeStates {}

class CreateNewOrderLoadingState extends HomeStates {}

class CreateNewOrderErrorState extends HomeStates {
  final String error;

  CreateNewOrderErrorState({
    required this.error,
  });
}

class CreateNewOrderSuccessState extends HomeStates {}

class DeleteCartItemLoadingState extends HomeStates {}

class DeleteCartItemErrorState extends HomeStates {
  final String error;

  DeleteCartItemErrorState({
    required this.error,
  });
}

class DeleteCartItemSuccessState extends HomeStates {}

class AddItemToCartLoadingState extends HomeStates {}

class AddItemToCartErrorState extends HomeStates {
  final String error;

  AddItemToCartErrorState({
    required this.error,
  });
}

class AddItemToCartSuccessState extends HomeStates {}

class ChangeSelectedAddressState extends HomeStates {}

class GetCartLoadingState extends HomeStates {}

class GetCartErrorState extends HomeStates {
  final String error;

  GetCartErrorState({
    required this.error,
  });
}

class GetCartSuccessState extends HomeStates {}

class GetAllAddressesLoadingState extends HomeStates {}

class GetAllAddressesErrorState extends HomeStates {
  final String error;

  GetAllAddressesErrorState({
    required this.error,
  });
}

class GetAllAddressesSuccessState extends HomeStates {}

class CreateNewAddressLoadingState extends HomeStates {}

class CreateNewAddressErrorState extends HomeStates {
  final String error;

  CreateNewAddressErrorState({
    required this.error,
  });
}

class CreateNewAddressSuccessState extends HomeStates {}

class LoginUserLoadingState extends HomeStates {}

class LoginUserErrorState extends HomeStates {
  final String error;

  LoginUserErrorState({
    required this.error,
  });
}

class LoginUserSuccessState extends HomeStates {}

class ChangeIsDefaultAddressState extends HomeStates {}

class GetAddressLoadingState extends HomeStates {}

class GetAddressSuccessState extends HomeStates {}

class ChangeMarkerState extends HomeStates {}

class MapControllerChangedState extends HomeStates {}

class TokenChangedState extends HomeStates {}

class GetBrandsLoadingState extends HomeStates {}

class GetBrandsErrorState extends HomeStates {
  final String error;

  GetBrandsErrorState({
    required this.error,
  });
}

class GetBrandsSuccessState extends HomeStates {}

class GetProductDetailsLoadingState extends HomeStates {}

class GetProductDetailsErrorState extends HomeStates {
  final String error;

  GetProductDetailsErrorState({
    required this.error,
  });
}

class GetProductDetailsSuccessState extends HomeStates {}

class GetProductsLoadingState extends HomeStates {}

class GetProductsErrorState extends HomeStates {
  final String error;

  GetProductsErrorState({
    required this.error,
  });
}

class GetProductsSuccessState extends HomeStates {}

class GetBannersLoadingState extends HomeStates {}

class GetBannersErrorState extends HomeStates {
  final String error;

  GetBannersErrorState({
    required this.error,
  });
}

class GetBannersSuccessState extends HomeStates {}

class GetCategoriesLoadingState extends HomeStates {}

class GetCategoriesErrorState extends HomeStates {
  final String error;

  GetCategoriesErrorState({
    required this.error,
  });
}

class GetCategoriesSuccessState extends HomeStates {}

class ChangeSelectedIndexState extends HomeStates {}

class ChangeSelectedCategoryState extends HomeStates {}

class ChangeBottomNavBarState extends HomeStates {}

class ChangeBannerIndexState extends HomeStates {}

