import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shoply/models/product_details_model/product_details_model.dart';
import 'package:shoply/modules/layout/layout_screen.dart';
import 'package:shoply/modules/search_screen/search_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';






class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);

  var boardingController = PageController();

  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context, state)
      {
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
      builder: (context, state)
      {
        return Scaffold(
          key:scaffoldKey ,
          appBar: AppBar(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const[
                SizedBox(width: 55,),
                Text(
                  'SALLA SHOPPING',
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
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).productDetailsModel != null,
            builder: (BuildContext context)
            {
              return buildProductDetail(ShopCubit.get(context).productDetailsModel!.data!,boardingController,scaffoldKey,context);

            },
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}










Widget buildProductDetail(ProductData model,boardingController,scaffoldKey,context) //
{

  return Stack(
    alignment: AlignmentDirectional.bottomEnd,
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(
                '${model.name}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 25.0,),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id!);
                      print(ShopCubit.get(context).favorites);

                    },
                    icon: CircleAvatar(
                      radius: 19.5,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor:Colors.grey,
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 26.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0,),
              SizedBox(
                width: 300,
                height: 300,
                child: PageView.builder(
                  controller:boardingController ,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ( context,  index)
                  {
                    print(index);
                    return Image(image: NetworkImage(model.images![index],),);
                  },
                  itemCount: model.images!.length,

                ),
              ),
              const SizedBox(height: 20.0,),
              SmoothPageIndicator(
                controller: boardingController,
                count: model.images!.length,
                effect:  const ExpandingDotsEffect(
                    spacing: 5.0,
                    dotHeight: 8.0,
                    dotWidth: 14.0,
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    expansionFactor: 4.0

                ),
              ),
              const SizedBox(height: 20.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EGP '' ${model.price}',
                    style: const TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0,),
                  if(model.discount!=0)
                    Row(
                      children: [
                        Text(
                          'EGP ' '${model.oldPrice}',
                          style: const TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough,color: Colors.grey),
                        ),
                        const SizedBox(width: 15.0,),
                        Text(
                          '${model.discount}% OFF',
                          style: const TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold,color: Colors.red),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20.0,),
                  myNewDivider(),
                  const SizedBox(height: 20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'OFFER',
                        style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.red),
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        children: [
                          const Text(
                            'FREE delivery in',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.green),
                          ),
                          const SizedBox(width: 10.0,),
                          Text(
                            DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 3))),
                            style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      const Text(
                        'Order in 3 days 5h 17m ',
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.grey),
                      ),
                      const SizedBox(height: 10.0,),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  myNewDivider(),
                  const SizedBox(height: 20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'OFFER benefits',
                        style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.red),
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        children: const [
                          Icon(Icons.check_circle_outline_sharp,color: Colors.green,),
                          SizedBox(width: 10.0,),
                          Text(
                            'Saving your money by using our offers',
                            style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500,color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Row(
                        children: const [
                          Icon(Icons.check_circle_outline_sharp,color: Colors.green,),
                          SizedBox(width: 10.0,),
                          Text(
                            'Original products',
                            style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500,color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Row(
                        children: const [
                          Icon(Icons.check_circle_outline_sharp,color: Colors.green,),
                          SizedBox(width: 10.0,),
                          Text(
                            '12 month in warranty',
                            style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500,color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Row(
                        children: const [
                          Icon(Icons.check_circle_outline_sharp,color: Colors.green,),
                          SizedBox(width: 10.0,),
                          Text(
                            'Sold by Salla Shopping',
                            style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500,color: Colors.grey),
                          ),
                        ],
                      ),

                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  myNewDivider(),
                  const SizedBox(height: 20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        'More Details',
                        style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      Text(
                        '${model.description}',
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 50.0,
        child: defaultButton(
            text: 'Add to cart',
            Function: ()
            {
              if(ShopCubit.get(context).carts[model.id]!)
              {
                showToast(message: 'Already in Your Cart \nCheck your cart To Edit or Delete ', state: ToastStates.ERROR);

              }
              else
              {
                ShopCubit.get(context).changeCarts(model.id!);
                scaffoldKey.currentState!.showBottomSheet((context)
                {
                  return Container(
                    width: double.infinity,
                    color: Colors.grey[100],
                    height: 180.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const Icon(Icons.check_circle,color: Colors.green,),
                                  const SizedBox(width: 10.0,),
                                  Expanded(
                                    child: Text(
                                      '${model.name}',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  const [
                                  Icon(Icons.check_circle,color: Colors.green,),
                                  SizedBox(width: 10.0,),
                                  Expanded(
                                    child: Text(
                                      'The process done successfully',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          const SizedBox(height: 15.0,),
                          Row(
                            children:
                            [
                              const SizedBox(width: 20.0,),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: ()
                                  {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Continue Shopping',style: TextStyle(fontSize: 17.5,fontWeight: FontWeight.bold,),),),
                              ),
                              const SizedBox(width: 20.0,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: defaultColor,
                                ),
                                width: 140.0,
                                height: 38.0,
                                child: MaterialButton(
                                  onPressed:()
                                  {
                                    navigateAndFinish(context, const ShopLayoutScreen());
                                    ShopCubit.get(context).currentIndex = 0;
                                  },
                                  child: const Text('Check Out',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.white),),
                                ),
                              ),
                              const SizedBox(width: 20.0,),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }


            },
            color: defaultColor
        ),
      ),
    ],
  );
}


Widget myNewDivider()
{
  return Container(width: double.infinity,height: 1,color: Colors.grey,);
}