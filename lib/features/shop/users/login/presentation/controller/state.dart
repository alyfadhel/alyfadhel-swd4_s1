import 'package:swd4_s1/features/shop/users/login/data/model/login_model.dart';

abstract class ShopLoginStates{}

class InitialShopState extends ShopLoginStates{}

class ShopChangeVisibilityLoginPassword extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
  final LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);
}