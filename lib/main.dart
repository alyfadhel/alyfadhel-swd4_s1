import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/news_app/controller/cubit.dart';
import 'package:swd4_s1/core/layout/news_app/news_layout.dart';
import 'package:swd4_s1/core/shared/network/local/cache_helper.dart';
import 'package:swd4_s1/core/shared/network/remote/dio_helper.dart';
import 'package:swd4_s1/core/shared/observer.dart';
import 'package:swd4_s1/core/shared/themes/controller/cubit.dart';
import 'package:swd4_s1/core/shared/themes/controller/state.dart';
import 'package:swd4_s1/core/shared/themes/theme_mode.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  NewsHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp(
    isDark: isDark,
  )));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(
          create:
              (context) =>
                  ThemeModeCubit()..changeThemeMode(fromShared: isDark),
        ),
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
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
