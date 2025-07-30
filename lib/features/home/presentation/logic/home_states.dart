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

