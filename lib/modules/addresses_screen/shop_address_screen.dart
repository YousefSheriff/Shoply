import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/addresses_model/addresses_model.dart';
import 'package:shoply/modules/addresses_screen/shop_add_addresses_screen.dart';
import 'package:shoply/modules/addresses_screen/shop_update_addresses_screen.dart';
import 'package:shoply/modules/settings_screen/settings_screen.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';


class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state)
      {
        if(state is ShopDeleteAddressSuccessState)
        {
          if(state.model.status==true)
          {
            showToast(message:state.model.message, state: ToastStates.SUCCESS);
          }
          else
          {
            showToast(message:state.model.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar
            (
            leading: defaultTextButton(
              Function: ()
              {
                navigateAndFinish(context, const SettingsScreen());
              },
              text: 'back',
              color: defaultColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).addressesModel != null ||state is! ShopGetAddressLoadingState,
            builder: (context)
            {
              return ConditionalBuilder(
                condition: ShopCubit.get(context).addressesModel!.data!.data!.isNotEmpty,
                builder: (BuildContext context)
                {
                  return buildAddressItem(ShopCubit.get(context).addressesModel!.data!.data![0],context);
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
                          const Text(
                            'Sorry, you haven\'t added your address yet',
                            style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          defaultTextButton(
                            Function: ()
                            {
                              navigateTo(context, ShopAddAddressesScreen());
                            },
                            text: 'Add address now',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            color: defaultColor,
                            isLine: true,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildAddressItem(AddressesData? model,context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 30.0,),
          Row(
            children:
             [
              const Icon(Icons.location_on_outlined,color: Colors.green,size: 30.0,),
              const SizedBox(width: 7.0,),
              const Text('Home',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900),),
              const Spacer(),
              InkWell(
                onTap: ()
                {
                  ShopCubit.get(context).deleteAddressData(addressId:model!.id.toString());

                },
                child: Row(
                  children:
                  const [
                    Icon(Icons.delete_outline_outlined,color: defaultColor,),
                    Text('Delete',style: TextStyle(color: defaultColor,fontSize: 19.0,fontWeight: FontWeight.w900,),),
                  ],
                ),
              ),
              const SizedBox(width: 25.0,),
              InkWell(
                onTap: ()
                {
                  navigateTo(context, ShopUpdateAddressesScreen(model!.id.toString()));
                },
                child: Row(
                  children:
                  const [
                    Icon(Icons.edit,color: Colors.grey,),
                    Text('Edit',style: TextStyle(color: Colors.grey,fontSize: 20.0,fontWeight: FontWeight.w500,),),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0,),
          myDivider(),
          const SizedBox(height: 25.0,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Location name :',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'City :',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Region :',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Details :',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Notes :',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 95.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model!.name}',
                      style: const TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '${model.city}',
                      style: const TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '${model.region}',
                      style: const TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '${model.details}',
                      style: const TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '${model.notes}',
                      style: const TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
