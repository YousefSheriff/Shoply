import 'package:shoply/models/login_model/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  final ShopLoginModel model ;

  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error ;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangeEyeIconState extends ShopRegisterStates{}
