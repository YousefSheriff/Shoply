import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/search_screen/search_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';



class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
     var cubit = ShopCubit.get(context) ;
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state)
      {},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const[
                SizedBox(width: 55,),
                Text(
                  'SALLA ',//SHOPPING
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: defaultColor,
                  ),
                ),
                SizedBox(width: 5.0,),
                Icon(Icons.shopping_cart_outlined,color: defaultColor,),
              ],
            ),
            actions: [
              IconButton(
                  onPressed:()
              {
                navigateTo(context, SearchScreen());
              },
                  icon: const Icon(Icons.search_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            selectedItemColor: defaultColor,
            onTap: (index)
            {
              cubit.changeIndex(index);
            },
            items: ShopCubit.get(context).bottomItems,
            unselectedItemColor: Colors.black87,
          ),
        ) ;
      },
    );
  }
}
