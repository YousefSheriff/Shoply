import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (BuildContext context, state)
      {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        children:
                        const [
                          Icon(Icons.lock_outline_rounded,size: 70.0,color: defaultColor,),
                          Text('Change your password ',style: TextStyle(fontSize: 23.0),),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      const Text('Make sure you remember the old password !',style: TextStyle(fontSize: 20.0),),
                      const SizedBox(
                        height: 25.0,
                      ),
                      if(state is ShopChangePasswordLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 25.0,
                      ),
                      defaultTextFormField(
                        borderColor: defaultColor,
                        errorColor: Colors.blue[700],
                        labelColor: Colors.black,
                        controller: oldPasswordController,
                        keyboardType: TextInputType.text,
                        labelText: 'Old password',
                        prefixIcon: Icons.lock_outline_rounded,
                        prefixColor: defaultColor,
                        suffixOnPressed: ()
                        {
                          ShopCubit.get(context).changeOldEyeIcon();
                        },
                        isPassword: ShopCubit.get(context).isOldPassword,
                        validatorString: 'enter your old password first',
                        suffixIcon: ShopCubit.get(context).oldSuffix ,
                        suffixColor: !ShopCubit.get(context).isOldPassword? defaultColor:Colors.grey ,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      defaultTextFormField(
                        borderColor: defaultColor,
                        errorColor: Colors.blue[700],
                        labelColor: Colors.black,
                        controller: newPasswordController,
                        keyboardType: TextInputType.text,
                        labelText: 'New password',
                        prefixIcon: Icons.lock_outline_rounded,
                        prefixColor: defaultColor,
                        suffixOnPressed: ()
                        {
                          ShopCubit.get(context).changeNewEyeIcon();
                        },
                        isPassword:  ShopCubit.get(context).isNewPassword,
                        validatorString: 'enter your new password first',
                        suffixIcon: ShopCubit.get(context).newSuffix ,
                        suffixColor: !ShopCubit.get(context).isNewPassword? defaultColor:Colors.grey ,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      defaultButton(
                        color: Colors.white,
                        text: 'change',
                        textColor: defaultColor,
                        textSize: 22.0,
                        isUpper: true,
                        Function: () {
                          if (formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).changePassword(oldPassword: oldPasswordController.text, newPassword: newPasswordController.text,context: context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
