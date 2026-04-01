import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/login_model/shop_login_model.dart';
import 'package:shoply/modules/shop_register_screen/register_cubit/states.dart';
import 'package:shoply/shared/network/end_points.dart';
import 'package:shoply/shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() :super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel ? shopRegisterModel ;
  void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }
        ).then((value)
    {
      // print(value.data);
      shopRegisterModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(shopRegisterModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  // ShopRegisterCubit.get(context).isPassword?
  IconData suffix = Icons.visibility_outlined ;
  bool isPassword =  true ;


  void changeEyeIcon()
  {
    isPassword = !isPassword;
    suffix = isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangeEyeIconState());

  }

}