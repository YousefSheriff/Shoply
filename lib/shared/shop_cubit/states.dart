import 'package:shoply/models/addresses_model/add_address_model.dart';
import 'package:shoply/models/addresses_model/delete_address_model.dart';
import 'package:shoply/models/addresses_model/update_address_screen.dart';
import 'package:shoply/models/carts_model/change_carts_model.dart';
import 'package:shoply/models/chaange_password_model/change_password_model.dart';
import 'package:shoply/models/favorites_model/change_favorites_model.dart';
import 'package:shoply/models/login_model/shop_login_model.dart';

abstract class ShopAppStates{}

class AppInitialState extends ShopAppStates{}

class AppChangeBottomNavBarState extends ShopAppStates{}

class ShopGetProductLoadingState extends ShopAppStates{}

class ShopGetProductSuccessState extends ShopAppStates{}

class ShopGetProductErrorState extends ShopAppStates {}

class ShopGetCategoryLoadingState extends ShopAppStates{}

class ShopGetCategorySuccessState extends ShopAppStates{}

class ShopGetCategoryErrorState extends ShopAppStates {}

class ShopChangeFavoritesState extends ShopAppStates {}

class ShopChangeFavoritesSuccessState extends ShopAppStates
{
  final ChangeFavoritesModel changeFavoritesModel ;

  ShopChangeFavoritesSuccessState(this.changeFavoritesModel);
}

class ShopChangeFavoritesErrorState extends ShopAppStates {}


class ShopChangeCartsLoadingState extends ShopAppStates {}

class ShopChangeCartsSuccessState extends ShopAppStates
{
  final ChangeCartsModel changeCartsModel ;

  ShopChangeCartsSuccessState(this.changeCartsModel);
}

class ShopChangeCartsErrorState extends ShopAppStates
{
  final ChangeCartsModel changeCartsModel ;

  ShopChangeCartsErrorState(this.changeCartsModel);
}


class ShopGetFavoritesLoadingState extends ShopAppStates{}

class ShopGetFavoritesSuccessState extends ShopAppStates{}

class ShopGetFavoritesErrorState extends ShopAppStates {}

class ShopGetCartsLoadingState extends ShopAppStates{}

class ShopGetCartsSuccessState extends ShopAppStates{}

class ShopGetCartsErrorState extends ShopAppStates {}

class ShopUserDataLoadingState extends ShopAppStates{}

class ShopUserDataSuccessState extends ShopAppStates{}

class ShopUserDataErrorState extends ShopAppStates {}

class ShopUpdateUserDataLoadingState extends ShopAppStates{}

class ShopUpdateUserDataSuccessState extends ShopAppStates{}

class ShopUpdateUserDataErrorState extends ShopAppStates
{
  final ShopLoginModel? model;
  ShopUpdateUserDataErrorState(this.model);

}

class ShopGetCatProductLoadingState extends ShopAppStates{}

class ShopGetCatProductSuccessState extends ShopAppStates{}

class ShopGetCatProductErrorState extends ShopAppStates {}

class ShopGetProductDetailsLoadingState extends ShopAppStates{}

class ShopGetProductDetailsSuccessState extends ShopAppStates{}

class ShopGetProductDetailsErrorState extends ShopAppStates {}

class ShopUpdateCartDataLoadingState extends ShopAppStates{}

class ShopUpdateCartDataSuccessState extends ShopAppStates{}

class ShopUpdateCartDataErrorState extends ShopAppStates{}

class ShopGetAddressLoadingState extends ShopAppStates{}

class ShopGetAddressSuccessState extends ShopAppStates{}

class ShopGetAddressErrorState extends ShopAppStates{}

class ShopAddAddressLoadingState extends ShopAppStates{}

class ShopAddAddressSuccessState extends ShopAppStates
{
  final AddAddressModel model;

  ShopAddAddressSuccessState(this.model);
}

class ShopAddAddressErrorState extends ShopAppStates{}

class ShopDeleteAddressLoadingState extends ShopAppStates{}

class ShopDeleteAddressSuccessState extends ShopAppStates
{
  final DeleteAddressModel model;

  ShopDeleteAddressSuccessState(this.model);
}

class ShopDeleteAddressErrorState extends ShopAppStates{}

class ShopUpdateAddressLoadingState extends ShopAppStates{}

class ShopUpdateAddressSuccessState extends ShopAppStates
{
  final UpdateAddressModel model;

  ShopUpdateAddressSuccessState(this.model);
}

class ShopUpdateAddressErrorState extends ShopAppStates{}

class ShopChangeEyeState extends ShopAppStates{}

class ShopChangePasswordLoadingState extends ShopAppStates{}

class ShopChangePasswordSuccessState extends ShopAppStates
{
  final ChangePasswordModel model;

  ShopChangePasswordSuccessState(this.model);
}

class ShopChangePasswordErrorState extends ShopAppStates{}

class ShopGetQuestionsLoadingState extends ShopAppStates{}

class ShopGetQuestionsSuccessState extends ShopAppStates {}

class ShopGetQuestionsErrorState extends ShopAppStates{}

class ShopContactUsLoadingState extends ShopAppStates{}

class ShopContactUsSuccessState extends ShopAppStates {}

class ShopContactUsErrorState extends ShopAppStates{}








