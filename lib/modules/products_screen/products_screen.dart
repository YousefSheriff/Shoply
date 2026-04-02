import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/categories_model/categories_model.dart';
import 'package:shoply/models/home_model/home_products_model.dart';
import 'package:shoply/models/product_details_model/product_details_model.dart';
import 'package:shoply/modules/categories_screen/categories_product_screen.dart';
import 'package:shoply/modules/layout/layout_screen.dart';
import 'package:shoply/modules/products_screen/product_details_screen.dart';
import 'package:shoply/modules/search_screen/search_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state)
      {
        if(state is ShopChangeFavoritesSuccessState)
        {
          if(state.changeFavoritesModel.status == false)
          {
            showToast(message: state.changeFavoritesModel.message, state: ToastStates.ERROR);
          }else
          {
            showToast(message: state.changeFavoritesModel.message, state: ToastStates.SUCCESS);
          }

        }

      },
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context)=>productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel! ,context),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel ,context)
  {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
       [
         CarouselSlider(
          items: model.data?.banners.map((e) {
            return Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            );

          }).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,

          ),
         ),
         const SizedBox(
           height: 15.0,
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 15.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text(
                 'Categories',
                 style: TextStyle(
                   fontSize: 24.0,
                   fontWeight: FontWeight.w800,
                 ),
               ),
               const SizedBox(
                 height: 9.0,
               ),
               Container(
                 height: 100.0,
                 child: ListView.separated(
                   physics: const BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                   shrinkWrap: true,
                   itemBuilder: (context ,  index)
                   {
                     return buildCategoriesItem(categoriesModel.data!.data[index],context);
                   },
                   separatorBuilder: (context ,index)
                   {
                     return const SizedBox(width: 15.0,);
                   },
                   itemCount: categoriesModel.data!.data.length,
                 ),
               ),
               const SizedBox(
                 height: 15.0,
               ),
               const Text(
                 'New Products',
                 style: TextStyle(
                   fontSize: 24.0,
                   fontWeight: FontWeight.w800,
                 ),
               ),
             ],
           ),
         ),
         const SizedBox(
           height: 15.0,
         ),
         Container(
           color:   Colors.grey[100],
           child: GridView.count(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             crossAxisCount: 2,
             mainAxisSpacing: 1.0,
             crossAxisSpacing: 1.0,
             childAspectRatio: 1/1.6,// 1/1.46,
             children: List.generate(model.data!.products.length, (index)
             {
               return buildGridProductItem(model.data!.products[index],context);
             }
             ),
           ),
         ),
       ],
      ),
    );
  }

  Widget buildGridProductItem(ProductsModel product , context)
  {
    return InkWell(
      onTap: ()
      {
        ShopCubit.get(context).getProductDetails(product.id);
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
                  image: NetworkImage('${product.image}'),
                  width: double.infinity,
                  height:200.0 ,
                ),
                if(product.discount!=0)
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
                    '${product.name}',
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
                        '${product.price.round()}'' \$',
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      if(product.discount!=0)
                        Text(
                        '${product.oldPrice.round()}',
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
                          ShopCubit.get(context).changeFavorites(product.id!);
                        },
                        icon: CircleAvatar(
                          radius: 17.5,
                          backgroundColor: ShopCubit.get(context).favorites[product.id]! ? defaultColor:Colors.grey,
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

  Widget buildCategoriesItem(DataModel dataModel,context)
  {
    return InkWell(
      onTap: ()
      {
        ShopCubit.get(context).getCategoryProduct(dataModel.id!);
        navigateTo(context, CategoryProductScreen(dataModel.name));
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
         Image(
           image: NetworkImage('${dataModel.image}'),
           width: 100.0,
           height: 100.0,
           fit: BoxFit.cover,
         ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: 100.0,
            child: Text(
              '${dataModel.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ) ;
  }
}



