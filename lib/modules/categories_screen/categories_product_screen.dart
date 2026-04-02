import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/categories_model/category_items_model.dart';
import 'package:shoply/modules/products_screen/product_details_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';

class CategoryProductScreen extends StatelessWidget
{
  final String? categoryName;
  const CategoryProductScreen(this.categoryName, {super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(),
          body:ConditionalBuilder(
            condition: ShopCubit.get(context).categoryItemsModel != null,
            builder: (context)
            {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 15.0),
                        child: Text('$categoryName',textAlign: TextAlign.right,style: const TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,),),
                      ),
                      const SizedBox(height: 15.0,),
                      Container(
                        color:   Colors.grey[100],
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 1/1.64, //1/1.5,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                          children: List.generate(ShopCubit.get(context).categoryItemsModel!.data!.productData.length, (index)
                          {
                            return gridProductItem(ShopCubit.get(context).categoryItemsModel!.data!.productData[index], context);//
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context)
            {
              return const Center(child:CircularProgressIndicator(),);
            },
          ),
        );
      },
    );
  }
}





Widget gridProductItem( ProductData model ,context)
{
  return InkWell(
    onTap: ()
    {
      ShopCubit.get(context).getProductDetails(model.id);
      navigateTo(context, ProductDetailsScreen());
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}',),
                width: double.infinity,
                height:200.0 ,
              ),
              if(model.discount!=0)
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
          Padding(
            padding: const EdgeInsets.all(14.0),
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
                      height: 1.4
                  ),
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    Text(
                      '${model.price}'' \$',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(width: 10.0,),
                    if(model.discount!=0)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          color: Colors.grey[400],
                          decoration:   TextDecoration.lineThrough,
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
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor:Colors.grey,//
                        child: const Icon(
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
  );
}