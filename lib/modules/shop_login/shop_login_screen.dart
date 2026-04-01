import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/shop_login/login_cubit/cubit.dart';
import 'package:shoply/modules/shop_login/login_cubit/states.dart';
import 'package:shoply/modules/shop_register_screen/shop_register_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/components/constant.dart';
import 'package:shoply/shared/network/local/cache_helper.dart';
import 'package:shoply/shared/styles/color.dart';


class ShopLoginScreen extends StatelessWidget
{
  ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)
      {
        return ShopLoginCubit();
      },

      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context ,state)
        {
          // if(state is ShopLoginSuccessState)
          // {
          //   if(state.model.status == true)
          //   {
          //     print(state.model.data!.token);
          //     showToast(message:state.model.message, state: ToastStates.SUCCESS);
          //     CacheHelper.saveData(key: 'token', value: state.model.data!.token).then((value)
          //     {
          //       token = state.model.data!.token ;
          //       ShopCubit.get(context).getUserData();   // verrrrrrrrrrrry importaaaaaaaaant
          //       navigateAndFinish(context, ShopLayoutScreen());
          //     });
          //
          //   }
          //   else
          //   {
          //     showToast(message:state.model.message, state: ToastStates.ERROR);
          //
          //   }
          //
          // }
        },
        builder: (context ,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Sign in Page',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Center(
                          child: Text(
                            'Sign in now to browse our hot offers',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          errorColor: Colors.blue[700],
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_rounded,
                          validatorString: 'email address must not be empty',
                          borderColor: defaultColor,
                          labelColor: Colors.black,

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
                          onSubmit: (val)
                          {
                            // if(formKey.currentState!.validate())
                            // {
                            //   ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                            // }

                          },
                          suffixOnPressed: ()
                          {
                            ShopLoginCubit.get(context).changeEyeIcon();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          validatorString: 'password must not be empty',
                          suffixIcon:ShopLoginCubit.get(context).suffix ,
                          suffixColor:!ShopLoginCubit.get(context).isPassword? defaultColor:Colors.grey ,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (BuildContext context)
                          {
                              return defaultButton(
                              color:defaultColor,
                              text: 'Sign In',
                              Function: ()
                              {
                                // if(formKey.currentState!.validate())
                                // {
                                //   ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                // }

                              },
                            );
                            },
                          fallback: (BuildContext context)
                          {
                            return const Center(child: CircularProgressIndicator());
                          },

                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            defaultTextButton(
                              Function: ()
                              {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'SignUp Now ',
                              color: defaultColor,
                            ),
                          ],
                        ),
                      ],
                    ),
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
