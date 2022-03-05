import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          var refreshKey = GlobalKey<RefreshIndicatorState>();

          return RefreshIndicator(
            key: refreshKey,
            onRefresh: () async{
              NewsCubit.get(context).getBusiness();

            },
            child: screenBuilder(list, context),
          );
        });
  }
}
