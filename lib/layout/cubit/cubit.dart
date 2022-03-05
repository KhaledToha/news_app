import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/local/cache_helper.dart';

import '../../modules/business_screen/business_screen.dart';
import '../../modules/science_screen/science_screen.dart';
import '../../modules/sports_screen/sports_screen.dart';
import '../../shared/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = CacheHelper.getData(key: 'dark') ?? false;

  void changeThemeMode() {
    isDark = !isDark;
    CacheHelper.saveDara(key: 'dark', value: isDark).then((value) {
      emit(ChangeThemeMode());
    });

    emit(ChangeThemeMode());
  }

  List<BottomNavigationBarItem> barItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_football,
        ),
        label: 'Sports'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void ChangeNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData1(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'd713fa889f8e4e398c9d56b4fc0d228e',
      },
    ).then((value) {
      //print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    DioHelper.getData1(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'd713fa889f8e4e398c9d56b4fc0d228e',
      },
    ).then((value) {
      //print(value.data.toString());
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(NewsGetSportsSuccessState());
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    DioHelper.getData1(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'd713fa889f8e4e398c9d56b4fc0d228e',
      },
    ).then((value) {
      //print(value.data.toString());
      science = value.data['articles'];
      print(science[0]['title']);

      emit(NewsGetScienceSuccessState());
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData1(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'd713fa889f8e4e398c9d56b4fc0d228e',
      },
    ).then((value) {
      //print(value.data.toString());
      search = value.data['articles'];
      //print(science[0]['title']);

      emit(NewsGetScienceSuccessState());
    });
  }
}
