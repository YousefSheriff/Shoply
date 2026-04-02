import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';

class ShopUpdateAddressesScreen extends StatelessWidget {

  final String ? addressId;
  ShopUpdateAddressesScreen(this.addressId , {Key? key}) : super(key: key);


  var locationNameController = TextEditingController();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  var notesController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {
        // if(state is ShopUpdateAddressSuccessState)
        // {
        //   if(state.model.status==true)
        //   {
        //     showToast(message:state.model.message, state: ToastStates.SUCCESS);
        //   }
        //   else
        //   {
        //     showToast(message:state.model.message, state: ToastStates.ERROR);
        //   }
        // }
      },
      builder: (context, state) {
        locationNameController.text = ShopCubit.get(context).addressesModel!.data!.data![0].name!;
        cityController.text = ShopCubit.get(context).addressesModel!.data!.data![0].city!;
        regionController.text = ShopCubit.get(context).addressesModel!.data!.data![0].region!;
        detailsController.text = ShopCubit.get(context).addressesModel!.data!.data![0].details!;
        notesController.text = ShopCubit.get(context).addressesModel!.data!.data![0].notes!;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25.0,),
                    if(state is ShopUpdateAddressLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 25.0,),
                    addressItem(
                      labelText: 'Location name :',
                      hintText: 'Enter your location name ',
                      nameController: locationNameController,
                      validatorString: 'location name must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'City :',
                      hintText: 'Enter your city name ',
                      nameController: cityController,
                      validatorString: 'City must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'Region :',
                      hintText: 'Enter your Region ',
                      nameController: regionController,
                      validatorString: 'Region must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'Details :',
                      hintText: 'Enter your Details ',
                      nameController: detailsController,
                      validatorString: 'Details must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'Notes :',
                      hintText: 'Type your Notes ',
                      nameController: notesController,
                      validatorString: 'Notes must not be empty',
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultButton(
                      color: defaultColor,
                      text: 'Update Address Data',
                      textSize: 20,
                      Function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateAddressData(
                            name: locationNameController.text,
                            city: cityController.text,
                            region: regionController.text,
                            details: detailsController.text,
                            notes: notesController.text,
                            // latitude: latitudeController.text,
                            // longitude: longitudeController.text,
                            addressId:addressId.toString(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
