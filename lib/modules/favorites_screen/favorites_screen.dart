import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/favorites_model/favorites_model.dart';
import 'package:shoply/modules/products_screen/product_details_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {

        //                            حرااااااام شرعاااا
        // int  cubit = ShopCubit.get(context).favoritesModel!.data!.data!.length;
        // print('cubottttttttttttttttttttttttttttttt $cubit');
        return ConditionalBuilder(
          condition:ShopCubit.get(context).favoritesModel != null ,
          builder: (context)
          {
            return  ConditionalBuilder(
              condition: ShopCubit.get(context).favoritesModel!.data!.data!.isNotEmpty ,
              builder: (BuildContext context)
              {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFavoritesItem(ShopCubit.get(context).favoritesModel!.data!.data![index].product , context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
                ) ;
              },
              fallback: (BuildContext context)
              {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Sorry, you have no favorites yet  ',
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Icon(Icons.tag_faces_rounded,color: defaultColor,)
                          ],
                        ),
                        const Icon(Icons.menu,size: 120.0,color: defaultColor,)
                      ],
                    ),
                  ),
                );
              },
            ) ;
          },
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}




Widget buildFavoritesItem(FavProduct? model, context)
{
  return InkWell(
    onTap: ()
    {
      ShopCubit.get(context).getProductDetails(model.id);
      navigateTo(context, ProductDetailsScreen());
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 135.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    '${model!.image}',
                  ),
                  width: 135.0,
                  height: 135.0,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 6.5),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        height: 1.4),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price} ' + '\$',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0 )
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 17.5,
                          backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor :Colors.grey,//
                          child:  const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
















//Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.menu,
//                       size: 100.0,
//                       color: Colors.grey[400],
//                     ),
//                     const SizedBox(
//                       height: 20.0,
//                     ),
//                     const Text(
//                       'No Favorites yet Please Add Some Favorites First.',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),




