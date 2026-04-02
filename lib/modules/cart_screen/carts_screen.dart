import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/carts_model/carts_model.dart';
import 'package:shoply/modules/products_screen/product_details_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

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
        if(state is ShopChangeCartsSuccessState)
        {
          if(state.changeCartsModel.status == false)
          {
            showToast(message: state.changeCartsModel.message, state: ToastStates.ERROR);
          }else
          {
            showToast(message: state.changeCartsModel.message, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).cartsModel != null||state is! ShopGetCartsLoadingState,
            builder: (context)
            {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index)=> buildCartItem(ShopCubit.get(context).cartsModel!.data!.cartItems![index],context),//
                      separatorBuilder: (context,index)=>myDivider(),
                      itemCount: ShopCubit.get(context).cartsModel!.data!.cartItems!.length,
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
                      height: 120.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children:
                            [
                              Text('Subtotal (${ShopCubit.get(context).cartsModel!.data!.cartItems!.length} items)',style: const TextStyle(fontSize: 17.0,fontWeight: FontWeight.w700,color: Colors.grey,),),
                              const Spacer(),
                              Text('EGP  ${ShopCubit.get(context).cartsModel!.data!.subTotal}',style: const TextStyle(fontSize: 17.0,fontWeight: FontWeight.w700,color: Colors.grey,),),

                            ],
                          ),
                          const SizedBox(height: 8.0,),
                          Row(
                            children:
                            const [
                              Text('Shopping free',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w700,),),
                              Spacer(),
                              Text('free',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w700,color: Colors.green,),),

                            ],
                          ),
                          const SizedBox(height: 8.0,),
                          Row(
                            children:
                            [
                              const Text('Total ',style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.w900,),),
                              const Text('(Inclusive of VAT)',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                              const Spacer(),
                              Text('EGP  ${ShopCubit.get(context).cartsModel!.data!.total}',style: const TextStyle(fontSize: 19.0,fontWeight: FontWeight.w900,),),

                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0,),

                  ],
                ),
              );
            },
            fallback: (context)
            {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }


}
Widget buildCartItem(CartItems? model,context )
{
  return InkWell(
    onTap: ()
    {
      ShopCubit.get(context).getProductDetails(model.product!.id);
      navigateTo(context, ProductDetailsScreen());
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children:
        [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage('${model!.product?.image}',),
                    width: 120.0,
                    height: 120.0,
                  ),
                  const SizedBox(height: 22.0,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: ()
                        {
                          if(model.quantity>1)
                          {
                            model.quantity--;
                            ShopCubit.get(context).updateCartData(model.id, model.quantity);

                          }
                          },
                        icon: const Icon(Icons.remove),
                      ),
                      Text('${model.quantity}',style: const TextStyle(fontSize: 22.0,fontWeight: FontWeight.w600),),
                      IconButton(
                        onPressed: ()
                        {
                          if(model.quantity<5)
                          {
                            model.quantity++;
                            ShopCubit.get(context).updateCartData(model.id, model.quantity);
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      '${model.product!.name}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      'EGP ${model.product?.price}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5.0,),
                    if(model.product?.discount!=0)
                      Text(
                        'EGP ${model.product?.oldPrice}',
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 25.0,),
                    Row(
                      children: [
                        InkWell(
                          onTap: ()
                          {
                            ShopCubit.get(context).changeFavorites(model.product!.id!);
                          },
                          child: Row(
                            children:  [
                              IconButton(
                                onPressed: ()
                                {
                                  ShopCubit.get(context).changeFavorites(model.product!.id!);
                                },
                                icon: CircleAvatar(
                                  radius: 17.5,
                                  backgroundColor: ShopCubit.get(context).favorites[model.product!.id]! ? defaultColor :Colors.grey,//
                                  child:  const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text('Fav / Unfav',style: TextStyle(fontSize: 16.1,color: Colors.grey),),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: ()
                          {
                            ShopCubit.get(context).changeCarts(model.product!.id!);
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.delete,color: Colors.grey,),
                              SizedBox(width: 5,),
                              Text('Remove',style: TextStyle(fontSize: 16.0,color: Colors.grey),),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0,),
        ],
      ),
    ),
  );
}

