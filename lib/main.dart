import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/news_app/controller/cubit.dart';
import 'package:swd4_s1/core/layout/news_app/news_layout.dart';
import 'package:swd4_s1/core/layout/shop/controller/cubit.dart';
import 'package:swd4_s1/core/layout/shop/shop_layout.dart';
import 'package:swd4_s1/core/shared/const/constanse.dart';
import 'package:swd4_s1/core/shared/network/local/cache_helper.dart';
import 'package:swd4_s1/core/shared/network/remote/dio_helper.dart';
import 'package:swd4_s1/core/shared/network/remote/shop_helper.dart';
import 'package:swd4_s1/core/shared/observer.dart';
import 'package:swd4_s1/core/shared/themes/controller/cubit.dart';
import 'package:swd4_s1/core/shared/themes/controller/state.dart';
import 'package:swd4_s1/core/shared/themes/theme_mode.dart';
import 'package:swd4_s1/features/shop/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:swd4_s1/features/shop/users/login/presentation/screens/shop_login_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  NewsHelper.init();
  ShopHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  debugPrint(onBoarding.toString());
  token = CacheHelper.getData(key: 'token');
  debugPrint(token.toString());
  Widget widget;

  if(onBoarding != null){
    if(token != null){
      widget = ShopLayout();
    }else{
      widget = ShopLoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(
          isDark: isDark,
          startWidget: widget,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp({super.key, required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  NewsCubit()
                    ..getBusiness()
                    ..getSports()
                    ..getScience(),
        ),
        BlocProvider(
          create:
              (context) =>
                  ThemeModeCubit()..changeThemeMode(fromShared: isDark),
        ),
        BlocProvider(create: (context) => ShopCubit(),
        )
      ],
      child: BlocConsumer<ThemeModeCubit, ThemeModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   useMaterial3: false
            // ),
            theme: getLightMode(),
            darkTheme: getDarkMode(),
            themeMode:
                ThemeModeCubit.get(context).isDark
                    ? ThemeMode.light
                    : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
