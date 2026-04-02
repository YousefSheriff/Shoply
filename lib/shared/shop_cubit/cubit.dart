import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/addresses_model/add_address_model.dart';
import 'package:shoply/models/addresses_model/addresses_model.dart';
import 'package:shoply/models/addresses_model/delete_address_model.dart';
import 'package:shoply/models/addresses_model/update_address_screen.dart';
import 'package:shoply/models/carts_model/carts_model.dart';
import 'package:shoply/models/carts_model/change_carts_model.dart';
import 'package:shoply/models/carts_model/update_cart_data_model.dart';
import 'package:shoply/models/categories_model/categories_model.dart';
import 'package:shoply/models/categories_model/category_items_model.dart';
import 'package:shoply/models/chaange_password_model/change_password_model.dart';
import 'package:shoply/models/contact_us_model/contact_us_model.dart';
import 'package:shoply/models/favorites_model/change_favorites_model.dart';
import 'package:shoply/models/favorites_model/favorites_model.dart';
import 'package:shoply/models/frequently_asked_questions_model/frequently_asked_questions_model.dart';
import 'package:shoply/models/home_model/home_products_model.dart';
import 'package:shoply/models/login_model/shop_login_model.dart';
import 'package:shoply/models/product_details_model/product_details_model.dart';
import 'package:shoply/modules/addresses_screen/shop_address_screen.dart';
import 'package:shoply/modules/categories_screen/categories_screen.dart';
import 'package:shoply/modules/favorites_screen/favorites_screen.dart';
import 'package:shoply/modules/products_screen/products_screen.dart';
import 'package:shoply/modules/settings_screen/settings_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/components/constant.dart';
import 'package:shoply/shared/network/end_points.dart';
import 'package:shoply/shared/network/remote/dio_helper.dart';
import 'package:shoply/shared/shop_cubit/states.dart';

class ShopCubit  extends Cubit<ShopAppStates>
{

  ShopCubit():super(AppInitialState());

  int currentIndex = 0;

  List<BottomNavigationBarItem>bottomItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.apps_rounded),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),

  ];



  List<String> title = [
    'Home Shop',
    'Categories Shop',
    'Favorites Shop',
    'Settings Options',
  ];

List<Widget>screens=
[
  const ProductsScreen(),
  const CategoriesScreen(),
  const FavoritesScreen(),
  const SettingsScreen(),
];

  static ShopCubit get(context) => BlocProvider.of(context);


  void changeIndex(index)
  {
    currentIndex= index ;

    emit(AppChangeBottomNavBarState());
  }


  Map<int,bool>favorites= {};
  Map<int,bool>carts= {};

  HomeModel ? homeModel ;
  void getHomeProductData()
  {
    emit(ShopGetProductLoadingState());

    DioHelper.getData(url: HOME , token: token).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id!:element.inFavorites!,
        });
      });

      homeModel!.data!.products.forEach((element)
      {
        carts.addAll({
          element.id! : element.inCart!,
        });
      });

      print(carts.toString());
      emit(ShopGetProductSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetProductErrorState());
    });


  }



  CategoriesModel? categoriesModel ;
  void getCategoriesData()
  {

    DioHelper.getData(url: CATEGORIES , token: token).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopGetCategorySuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetCategoryErrorState());
    });
  }



  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      token:token,
      data:
      {
        'product_id':productId,
      },
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!)
      {
        favorites[productId] = !favorites[productId]!;
      }else
      {
        getFavoritesData();
      }
      print(value.data);
      print(favorites.toString());///////////////////////////////////////////////////////
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopChangeFavoritesErrorState());
    });
  }






  FavoritesModel ? favoritesModel;
  void getFavoritesData()
  {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
      print(favoritesModel!.data!.data!.length);
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }







  ShopLoginModel ? userModel;
  void getUserData()
  {
    emit(ShopUserDataLoadingState());
    DioHelper.getData
      (
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopUserDataSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopUserDataErrorState());
    });
  }




  void updateUserData({
  required String ? name,
  required String ? email,
  required String ? phone,
})
  {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      print(userModel!.message);
      emit(ShopUpdateUserDataSuccessState());
    }).catchError((error)
    {
      print('Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      print(userModel!.message);
      print(error.toString());
      emit(ShopUpdateUserDataErrorState(userModel));
    });
  }


  CategoryDetailModel ?categoryItemsModel;
  void getCategoryProduct(int? categoryID)
  {
    emit(ShopGetCatProductLoadingState());

    DioHelper.getData(
      url:CATEGORY_PRODUCTS ,
      query:
      {
        'category_id':categoryID,
      }
    ).then((value)
    {
      categoryItemsModel = CategoryDetailModel.fromJson(value.data);
      print(categoryID);
      print(categoryItemsModel!.status);
      print(categoryItemsModel!.data!.productData[0].name);
      // print(categoryItemsModel!.data.productData[0].id);
      emit(ShopGetCatProductSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetCatProductErrorState());
    });
  }



  ProductDetailsModel ?productDetailsModel;
  void getProductDetails(int? productID)
  {
    emit(ShopGetProductDetailsLoadingState());
    DioHelper.getData(
      url:PRODUCT_DETAILS+productID.toString(),
    ).then((value)
    {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print(PRODUCT_DETAILS+productID.toString());
      print(productID);
      print(productDetailsModel!.status);
      print(productDetailsModel!.data!.name);
      emit(ShopGetProductDetailsSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetProductDetailsErrorState());
    });
  }




  ChangeCartsModel? changeCartsModel;

  void changeCarts(int productId)
  {
    emit(ShopChangeCartsLoadingState());

    DioHelper.postData(
      url: CARTS,
      token:token,
      data:
      {
        'product_id':productId,
      },
    ).then((value)
    {
      changeCartsModel = ChangeCartsModel.fromJson(value.data);
      if(changeCartsModel!.status!)
      {
        getCartsData();
        getHomeProductData();
      }
      else
      {
        showToast(message: changeCartsModel?.message, state: ToastStates.ERROR);
      }
      emit(ShopChangeCartsSuccessState(changeCartsModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopChangeCartsErrorState(changeCartsModel!));
    });
  }


  CartsModel ? cartsModel;
  void getCartsData()
  {
    emit(ShopGetCartsLoadingState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value)
    {
      cartsModel = CartsModel.fromJson(value.data);
      // print(cartsModel!.data!.cartItems?.length);
      // print(value.data.toString());
      emit(ShopGetCartsSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetCartsErrorState());
    });
  }




  UpdateCartModel ? updateCartModel;
  void updateCartData(int ? cartId, int ? quantity)
  {
    emit(ShopUpdateCartDataLoadingState());
    DioHelper.putData(
      url: UPDATE_CARTS+cartId.toString(),
      data:
      {
        'quantity': '$quantity',
      },
      token: token,
    ).then((value)
    {
      updateCartModel= UpdateCartModel.fromJson(value.data);
      getCartsData();
      emit(ShopUpdateCartDataSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopUpdateCartDataErrorState());
    });
  }



  AddressesModel ? addressesModel;

  void getAddress()
  {
    emit(ShopGetAddressLoadingState());
    DioHelper.getData(
      url:ADDRESSES,
      token: token,
    ).then((value)
    {
      addressesModel = AddressesModel.fromJson(value.data);
      emit(ShopGetAddressSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetAddressErrorState());
    });
  }



  AddAddressModel ? addAddressModel;

  void addAddressData(
  {
  required String ? name,
  required String ? city,
  required String ? region,
  required String ? details,
  required String ? notes,
  required String ? latitude,
  required String ? longitude,
  required BuildContext? context,
})
  {
    emit(ShopAddAddressLoadingState());

    DioHelper.postData(
      url: ADDRESSES,
      data:
      {
        'name':name,
        'city':city,
        'region':region,
        'details':details,
        'notes':notes,
        'latitude':latitude,
        'longitude':longitude,
      },
      token: token,
    ).then((value)
    {
      addAddressModel = AddAddressModel.fromJson(value.data);
      if(addAddressModel!.status!)
      {
        getAddress();
        navigateAndFinish(context, const AddressScreen());
      }
      else
      {
        showToast(message: addAddressModel?.message, state: ToastStates.ERROR);
      }
      emit(ShopAddAddressSuccessState(addAddressModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopAddAddressErrorState());
    });
  }



  DeleteAddressModel ? deleteAddressModel;

  void deleteAddressData({
    required String ?addressId,
  })
  {
    emit(ShopDeleteAddressLoadingState());
    DioHelper.deleteData(
      url:DELETE_ADDRESS+addressId.toString(),
      token: token,
    ).then((value)
    {
      deleteAddressModel = DeleteAddressModel.fromJson(value.data);
      getAddress();
      emit(ShopDeleteAddressSuccessState(deleteAddressModel!),);
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopDeleteAddressErrorState());
    });
  }






  UpdateAddressModel ?  updateAddressModel;
  void updateAddressData({
    required String ? name,
    required String ? city,
    required String ? region,
    required String ? details,
    required String ? notes,
    required String ? addressId,
  })
  {
    emit(ShopUpdateAddressLoadingState());
    DioHelper.putData(
      url: UPDATE_ADDRESS+addressId.toString(),
      token: token,
      data:
      {
        'name':name,
        'city':city,
        'region':region,
        'details':details,
        'latitude': 30.0616863,
        'longitude': 31.3260088,
        'notes':notes,
      },
    ).then((value)
    {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      getAddress();
      emit(ShopUpdateAddressSuccessState(updateAddressModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopUpdateAddressErrorState());
    });
  }



  IconData oldSuffix = Icons.visibility_outlined ;
  bool isOldPassword =  true ;

  void changeOldEyeIcon()
  {
    isOldPassword = !isOldPassword;
    oldSuffix = isOldPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangeEyeState());
  }


  IconData newSuffix = Icons.visibility_outlined ;
  bool isNewPassword =  true ;
  void changeNewEyeIcon()
  {
    isNewPassword = !isNewPassword;
    newSuffix = isNewPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangeEyeState());
  }



  ChangePasswordModel ?changePasswordModel;

  void changePassword({
  required String ? oldPassword,
  required String ? newPassword,
  required BuildContext ? context,
})
  {
    emit(ShopChangePasswordLoadingState());
    DioHelper.postData(
      url: CHANGE_PASSWORD,
      data:
      {
        'current_password':oldPassword,
        'new_password':newPassword,
      },
      token: token,
    ).then((value)
    {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      if(changePasswordModel!.status!)
      {
        showToast(message:changePasswordModel!.message , state: ToastStates.SUCCESS);
        pop(context);
      } else {
        showToast(message:changePasswordModel!.message , state: ToastStates.ERROR);
      }
      emit(ShopChangePasswordSuccessState(changePasswordModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopChangePasswordErrorState());
    });
  }

  FrequentlyAskedQuestionsModel ? frequentlyAskedQuestionsModel;
  void getQuestions()
  {
    emit(ShopGetQuestionsLoadingState());
    DioHelper.getData(
      url: FAQS,
    ).then((value)
    {
      frequentlyAskedQuestionsModel = FrequentlyAskedQuestionsModel.fromJson(value.data);
      emit(ShopGetQuestionsSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetQuestionsErrorState());
    });
  }


  ContactUsModel ? contactUsModel;
  void contactUs()
  {
    emit(ShopContactUsLoadingState());
    DioHelper.getData(
      url: CONTACT_US,
    ).then((value)
    {
      contactUsModel = ContactUsModel.fromJson(value.data);
      emit(ShopContactUsSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopContactUsErrorState());
    });
  }



}

