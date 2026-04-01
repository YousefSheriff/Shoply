import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/login_model/shop_login_model.dart';
import 'package:shoply/modules/shop_login/login_cubit/states.dart';
import 'package:shoply/shared/network/end_points.dart';
import 'package:shoply/shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() :super(ShopLoginInitialState());


  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel ? shopLoginModel ;
  void userLogin({
  required String email,
  required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        }
        ).then((value) {
      // print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  // ShopLoginCubit.get(context).isPassword?
  IconData suffix = Icons.visibility_outlined ;
  bool isPassword =  true ;


  void changeEyeIcon()
  {
    isPassword = !isPassword;
    suffix = isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopLoginChangeEyeIconState());

  }

}