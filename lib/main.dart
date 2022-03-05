import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/local/cache_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';
import 'package:news_app/shared/observer.dart';
import 'package:news_app/styles/themes.dart';
import 'layout/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();

  BlocOverrides.runZoned(
        () {
      NewsCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'dark')?? false;

  runApp( MyApp(isDark));


}

class MyApp extends StatelessWidget {
bool isDark;

MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create : (BuildContext context)=> NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeLight,
              darkTheme: themeDark,
              themeMode:  isDark ? ThemeMode.dark : ThemeMode.light,
              home: NewsLayout(),
          );
        }
      ),

    );
  }
}


