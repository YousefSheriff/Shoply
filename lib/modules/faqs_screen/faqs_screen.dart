import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';

import '../../models/frequently_asked_questions_model/frequently_asked_questions_model.dart';


class FAQsScreen extends StatelessWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).frequentlyAskedQuestionsModel!= null,
            builder: (BuildContext context)
            {
              return Column(
                children: [
                  Container(
                    height: 70.0,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Padding(
                      padding: EdgeInsetsDirectional.only(top: 23.0,start: 20.0),
                      child: Text('Repeated Questions !',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w800,),),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)
                          {
                            return buildQuestionItem(ShopCubit.get(context).frequentlyAskedQuestionsModel!.data!.data![index]);
                          },
                          separatorBuilder: (context,index) => const SizedBox(height: 35.0,),
                          itemCount: ShopCubit.get(context).frequentlyAskedQuestionsModel!.data!.data!.length,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback: (BuildContext context)
            {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }






  Widget buildQuestionItem(DataItem ? model) //
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text(
          '${model!.question}',
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          '${model.answer}',
          style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
