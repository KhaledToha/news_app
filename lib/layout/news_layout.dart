import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search_screen/search_screen.dart';
import '../shared/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      NewsCubit.get(context).changeThemeMode();
                    },
                    icon: Icon(Icons.brightness_2))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.barItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeNavBar(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
