import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  isPassword: false,
                  label: 'search',
                  prefix: Icons.search,
                  suffix: Icons.arrow_forward,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                  child: screenBuilder(
                NewsCubit.get(context).search,
                context,
                isSearch: true,
              ))
            ],
          ),
        );
      },
    );
  }
}
