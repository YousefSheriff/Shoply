import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/modules/on_boarding/on_boarding_screen.dart';
import 'package:shoply/modules/layout/layout_screen.dart';
import 'package:shoply/modules/shop_login/shop_login_screen.dart';
import 'package:shoply/shared/app_main_cubit/main_cubit.dart';
import 'package:shoply/shared/app_main_cubit/main_states.dart';
import 'package:shoply/shared/components/constant.dart';
import 'package:shoply/shared/shop_cubit/bloc_observer.dart';
import 'package:shoply/shared/network/local/cache_helper.dart';
import 'package:shoply/shared/network/remote/dio_helper.dart';
import 'package:shoply/shared/shop_cubit/cubit.dart';
import 'package:shoply/shared/styles/themes.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  darkCopy = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget startWidget;

  if (onBoarding != null)
  {
    if (token != null)
    {
      startWidget = const ShopLayoutScreen();
    }
    else
    {
      startWidget = ShopLoginScreen();
    }
  }
  else
  {
    startWidget = const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: darkCopy,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.isDark, required this.startWidget});

  bool? isDark;
  Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context)
            {
              return ShopMainCubit()..changeAppMode(fromShared: isDark);
            }
        ),
        BlocProvider(
            create: (BuildContext context)
            {
              return ShopCubit()..getHomeProductData()..getCategoriesData()..getFavoritesData();//   ..getHomeProductData()..getCategoriesData()..getFavoritesData()..getCartsData()
            }
        ),
      ],
      child: BlocConsumer<ShopMainCubit, ShopAppMainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,//ShopMainCubit.get(context).isDark?ThemeMode.dark:
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}



// abdoo.sherif@gmail.com     123456
// eng.yousef@gmail.com     123456



