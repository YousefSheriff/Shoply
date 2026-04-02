import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/models/contact_us_model/contact_us_model.dart';
import 'package:shoply/shared/components/components.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/shop_cubit/states.dart';
import 'package:shoply/shared/styles/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Item
{
  late String  name ;
  late Color color ;
  Item({
    required this.name,
    required this.color,
});
}

class ContactScreen extends StatelessWidget {
  ContactScreen({Key? key}) : super(key: key);

  List<Item> list =
  [
    Item(name:'Facebook', color:Colors.blue ),
    Item(name:'Instagram', color:Colors.purple ),
    Item(name:'Twitter', color:Colors.blue ),
    Item(name:'Gmail', color:Colors.blue ),
    Item(name:'Phone', color:Colors.green ),
    Item(name:'Whatsapp', color:Colors.green ),
    Item(name:'SnapChat', color:Colors.amber ),
    Item(name:'Youtube', color:Colors.red ),
    Item(name:'Valuxapps', color:Colors.purple ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).contactUsModel!=null,
            builder: (BuildContext context)
            {
              return Column(
                children: [
                  Container(
                    height: 70.0,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Padding(
                      padding: EdgeInsetsDirectional.only(top: 23.0, start: 20.0),
                      child: Text(
                        'Contact us using the following ways',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildQuestionItem(ShopCubit.get(context).contactUsModel!.data!.data![index],list[index],context);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 35.0,
                          ),
                          itemCount: ShopCubit.get(context).contactUsModel!.data!.data!.length,
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

  Widget buildQuestionItem(ContactDataItem ? model,Item ? item,context) {
    return InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Image(
            image: NetworkImage(
              '${model!.image}',
            ),
            color: item!.color,
          ),
          const SizedBox(width: 25.0,),
          const Text('Via ',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,),),
          Text(item.name,style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.w800,color:item.color,),),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,),
        ],
      ),
      onTap: ()
      {

      navigateTo(
        context, WebViewWidget(controller: WebViewController()..loadRequest(Uri.parse('${model.value}'))
        ..setJavaScriptMode(JavaScriptMode.unrestricted),),);
      },
    );
  }
}
