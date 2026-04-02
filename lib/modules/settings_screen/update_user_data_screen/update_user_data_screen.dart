import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/layout/layout_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';
class UpdateUserData extends StatelessWidget
{
  UpdateUserData({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        var model = ShopCubit.get(context).userModel;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) {
            nameController.text = model!.data!.name!;
            emailController.text = model.data!.email!;
            phoneController.text = model.data!.phone!;
            return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey ,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color:Colors.grey[100],
                        ),
                        child: const Center(
                          child: Text(
                            'User Update',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      if(state is ShopUpdateUserDataLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 30.0,),
                      defaultTextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        labelText: 'Name ',
                        prefixIcon: Icons.person,
                        validatorString: 'name must not be empty',
                        borderColor: defaultColor,
                        labelColor: Colors.black,
                        prefixColor: defaultColor,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email Address',
                        prefixIcon: Icons.email_rounded,
                        validatorString: 'email address must not be empty',
                        borderColor: defaultColor,
                        labelColor: Colors.black,
                        prefixColor: defaultColor,

                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone ',
                        prefixIcon: Icons.phone,
                        validatorString: 'Phone must not be empty',
                        borderColor: defaultColor,
                        labelColor: Colors.black,
                        prefixColor: defaultColor,


                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultButton(
                        color: Colors.white,
                        text: 'update',
                        textColor: defaultColor,
                        textSize: 22.0,
                        isUpper: true,
                        Function: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);
                          }
                        },
                      ) ,
                    ],
                  ),
                ),
              ),
            ),
          );
          },
          fallback: (context) => Container(
            width: double.infinity,
            height: double.infinity,
            padding:  const EdgeInsets.all(20.0),
            color: Colors.white,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children:  [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35.0,),
                  child: TextButton(
                    onPressed: ()
                    {
                      navigateAndFinish(context, const ShopLayoutScreen());
                      ShopCubit.get(context).changeIndex(3);                    },
                    child: const Icon(Icons.arrow_back,size: 35,color: Colors.black,),
                  ),
                ),
                const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      },
    );
  }
}
