
import 'package:shoply/models/login_model/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel model ;

  ShopLoginSuccessState(this.model);
}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error ;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangeEyeIconState extends ShopLoginStates{}
