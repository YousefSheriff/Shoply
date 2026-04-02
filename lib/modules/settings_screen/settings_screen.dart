import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/contact_us_screen/contact_us_screen.dart';
import 'package:shoply/modules/faqs_screen/faqs_screen.dart';
import 'package:shoply/modules/addresses_screen/shop_address_screen.dart';
import 'package:shoply/modules/cart_screen/carts_screen.dart';
import 'package:shoply/modules/layout/layout_screen.dart';
import 'package:shoply/modules/settings_screen/change_password_screen/change_password_screen.dart';
import 'package:shoply/modules/settings_screen/update_user_data_screen/update_user_data_screen.dart';
import 'package:shoply/modules/settings_screen/user_data/user_data_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/components/constant.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: ()
                {
                  navigateAndFinish(context, const ShopLayoutScreen());
                  ShopCubit.get(context).changeIndex(0);
                },
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.perm_identity,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Show User Data',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: () {
                      ShopCubit.get(context).getUserData();
                      navigateTo(context, UserData());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.published_with_changes_sharp,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Update User Data',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: () {
                      ShopCubit.get(context).getUserData();
                      navigateTo(context, UpdateUserData());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.key,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Security Information',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      //ShopCubit.get(context).getAddress();
                      navigateTo(context, ChangePasswordScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.location_pin,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      ShopCubit.get(context).getAddress();
                      navigateTo(context, const AddressScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.shopping_cart,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Cart List',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      ShopCubit.get(context).getCartsData();
                      navigateTo(context, const CartsScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.map_outlined,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Country',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text('Egypt',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.grey,),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      showToast(message: 'تحيا مصر يعم', state: ToastStates.SUCCESS);

                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.flag_outlined,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Language',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text('English',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.grey,),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      showToast(message: 'Your language is en', state: ToastStates.SUCCESS);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.info_outline_rounded,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'FAQs',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      ShopCubit.get(context).getQuestions();
                      navigateTo(context, const FAQsScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.call,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      ShopCubit.get(context).contactUs();
                      navigateTo(context,  ContactScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children:  [
                          const Icon(Icons.brightness_4_outlined,color: defaultColor,),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Text(
                            'Appearance Mode',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: false ,
                            onChanged: (newValue) {},
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showToast(message: 'مش شغال يعم', state: ToastStates.SUCCESS);
                      // ShopMainCubit.get(context).changeAppMode();
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 60.0,
                  ),
                  InkWell(
                    onTap: ()
                    {
                      signOut(context);
                      ShopCubit.get(context).currentIndex = 0;
                    },
                    child: Container(
                      width: 250.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: defaultColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.power_settings_new,color: Colors.white,),
                          SizedBox(width: 10.0,),
                          Text('Sign Out',style: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



//                  defaultButton(
//                     color: defaultColor,
//                     text: 'Sign Out',
//                     textSize: 18.0,
//                     Function: ()
//                     {
//                       signOut(context);
//                       ShopCubit.get(context).currentIndex = 0;
//                     },
//                   ),