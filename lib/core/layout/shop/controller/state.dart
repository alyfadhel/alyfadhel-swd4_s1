import 'package:swd4_s1/features/shop/home/data/model/change_favorites_model.dart';

abstract class ShopStates{}

class InitialShopState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopGetHomeDataLoadingState extends ShopStates{}
class ShopGetHomeDataSuccessState extends ShopStates{}
class ShopGetHomeDataErrorState extends ShopStates{
  final String error;

  ShopGetHomeDataErrorState(this.error);
}

class ShopGetCategoriesHomeLoadingState extends ShopStates{}
class ShopGetCategoriesHomeSuccessState extends ShopStates{}
class ShopGetCategoriesHomeErrorState extends ShopStates{
  final String error;

  ShopGetCategoriesHomeErrorState(this.error);
}

class ShopChangeFavoritesHomeLoadingState extends ShopStates{}
class ShopChangeFavoritesHomeSuccessState extends ShopStates{
  final ChangeFavoritesModel changeFavoritesModel;

  ShopChangeFavoritesHomeSuccessState(this.changeFavoritesModel);
}
class ShopChangeFavoritesHomeErrorState extends ShopStates{
  final String error;

  ShopChangeFavoritesHomeErrorState(this.error);
}

class ShopGetProfileLoadingState extends ShopStates{}
class ShopGetProfileSuccessState extends ShopStates{}
class ShopGetProfileErrorState extends ShopStates{
  final String error;

  ShopGetProfileErrorState(this.error);
}