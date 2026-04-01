import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/shop_register_screen/register_cubit/cubit.dart';
import 'package:shoply/modules/shop_register_screen/register_cubit/states.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/components/constant.dart';
import 'package:shoply/shared/network/local/cache_helper.dart';
import 'package:shoply/shared/styles/color.dart';


class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ShopRegisterCubit();
      },
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state)
        {
          // if (state is ShopRegisterSuccessState)
          // {
          //   if (state.model.status == true) {
          //     print(state.model.data!.token);
          //     showToast(message: state.model.message, state: ToastStates.SUCCESS,);
          //
          //     CacheHelper.saveData(key: 'token', value: state.model.data!.token).then((value)
          //     {
          //       token = state.model.data!.token;
          //       ShopCubit.get(context).getUserData();
          //       navigateAndFinish(context, ShopLayoutScreen());
          //     });
          //   }
          //   else
          //   {
          //     showToast(message: state.model.message, state: ToastStates.ERROR);
          //   }
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Create Your Account',
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Center(
                        child: Text(
                          'Sign up now to browse our hot offers',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        borderColor: defaultColor,
                        labelColor: Colors.black,
                        errorColor: Colors.blue[700],
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'User Name',
                        prefixIcon: Icons.perm_identity,
                        validatorString: 'Name must not be empty',
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        borderColor: defaultColor,
                        labelColor: Colors.black,
                        errorColor: Colors.blue[700],
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        validatorString: 'email address must not be empty',
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        borderColor: defaultColor,
                        labelColor: Colors.black,
                        errorColor: Colors.blue[700],
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        suffixOnPressed: ()
                        {
                          ShopRegisterCubit.get(context).changeEyeIcon();
                        },
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                        validatorString: 'password must not be empty',
                        suffixIcon: ShopRegisterCubit.get(context).suffix,
                        suffixColor:
                            !ShopRegisterCubit.get(context).isPassword
                                ? defaultColor
                                : Colors.grey,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        borderColor: defaultColor,
                        labelColor: Colors.black,
                        errorColor: Colors.blue[700],
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone Number',
                        prefixIcon: Icons.phone,
                        validatorString: 'Phone must not be empty',
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                            color: defaultColor,
                            text: 'Sign Up',
                            textSize: 20,
                            Function: ()
                            {
                              // if (formKey.currentState!.validate())
                              // {
                              //   ShopRegisterCubit.get(context).userRegister(
                              //     name:nameController.text ,
                              //     email: emailController.text,
                              //     password: passwordController.text,
                              //     phone: phoneController.text,
                              //
                              //   );
                              // }
                            },
                          );
                        },
                        fallback: (BuildContext context) {
                          return const Center(child: CircularProgressIndicator(color: defaultColor,));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
