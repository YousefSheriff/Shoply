import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/layout/layout_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';

class UserData extends StatelessWidget {
  UserData({Key? key}) : super(key: key);

  String? nameController;

  String? emailController;

  String? phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context)
          {
            nameController = model!.data!.name!;
            emailController = model.data!.email!;
            phoneController = model.data!.phone!;
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Container(
                         width: double.infinity,
                         height: 40.0,
                         color: Colors.grey[100],
                         child: const Center(
                           child:  Text(
                             'User Profile',
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
                      buildDataInfoItem(
                        label: 'Name',
                        text: nameController,
                        icon: Icons.person,
                        iconColor: defaultColor,
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      buildDataInfoItem(
                        label: 'Email Address',
                        text: emailController,
                        icon: Icons.email_outlined,
                        iconColor: defaultColor,
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      buildDataInfoItem(
                        label: 'Phone',
                        text: phoneController,
                        icon: Icons.phone,
                        iconColor: defaultColor,
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      defaultButton(
                        color: Colors.white,
                        text: 'Done',
                        textSize: 24.0,
                        textColor: defaultColor,
                        isUpper: true,
                        Function: ()
                        {
                          navigateAndFinish(context, const ShopLayoutScreen());
                          ShopCubit.get(context).changeIndex(3);

                        },
                      ),
                    ],
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
                      ShopCubit.get(context).changeIndex(3);
                    },
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
