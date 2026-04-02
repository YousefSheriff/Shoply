import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';


class ShopAddAddressesScreen extends StatelessWidget {
  ShopAddAddressesScreen({Key? key}) : super(key: key);
  var locationNameController = TextEditingController();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  var notesController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (context,state)
      {
        if(state is ShopAddAddressSuccessState)
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
      builder: (context,state)
      {
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
                      hintText:  'Enter your Region ',
                      nameController: regionController,
                      validatorString: 'Region must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'Details :',
                      hintText:  'Enter your Details ',
                      nameController: detailsController,
                      validatorString: 'Details must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'Notes :',
                      hintText:  'Type your Notes ',
                      nameController: notesController,
                      validatorString: 'Notes must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'Latitude :',
                      hintText:  'Type your Latitude ',
                      nameController: latitudeController,
                      validatorString: 'Latitude must not be empty',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    addressItem(
                      labelText: 'Longitude :',
                      hintText:  'Type your Longitude ',
                      nameController: longitudeController,
                      validatorString: 'Longitude must not be empty',
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopAddAddressLoadingState,
                      builder: (BuildContext context)
                      {
                        return defaultButton(
                          color: defaultColor,
                          text: 'Add Address',
                          textSize: 20,
                          Function: ()
                          {
                            if (formKey.currentState!.validate())
                            {
                              ShopCubit.get(context).addAddressData(
                                name: locationNameController.text,
                                city: cityController.text,
                                region: regionController.text,
                                details: detailsController.text,
                                notes: notesController.text,
                                latitude: latitudeController.text,
                                longitude: longitudeController.text,
                                context: context,
                              );
                            }
                          },
                        );
                      },
                      fallback: (BuildContext context) {
                        return const Center(child: CircularProgressIndicator());
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
