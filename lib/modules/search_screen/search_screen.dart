import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/products_screen/product_details_screen.dart';
import 'package:shoply/modules/search_screen/cubit/cubit.dart';
import 'package:shoply/modules/search_screen/cubit/states.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/styles/color.dart';
import 'package:shoply/models/search_model/shop_search_model.dart';



class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        labelText: 'Search',
                        prefixIcon: Icons.search,
                        validatorString: 'enter text to search for',
                        labelColor: Colors.black,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            SearchCubit.get(context).search(text: value);
                          }
                        }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(SearchCubit.get(context).searchModel!.data!.data![index],context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data!
                              .length,
                        ),
                      ),
                    if (state is SearchErrorState)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu,
                                size: 100.0,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                'Sorry check your connection first',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
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
      ),
    );
  }
}

Widget buildSearchItem(Product model,context)
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
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              width: 135.0,
              height: 135.0,
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
                        fontSize: 16.0, fontWeight: FontWeight.bold, height: 1.4),
                  ),
                  const Spacer(),
                  Text(
                    '${model.price} ' '\$',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      height: 1.6,
                      color: defaultColor,
                    ),
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
